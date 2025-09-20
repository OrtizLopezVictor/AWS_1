import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../state/providers.dart';

class DashboardScreen extends ConsumerStatefulWidget {
  const DashboardScreen({super.key});

  @override
  ConsumerState<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends ConsumerState<DashboardScreen> {
  final _searchCtrl = TextEditingController();

  @override
  void dispose() {
    _searchCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(usernameProvider) ?? 'Operador';
    final cs = Theme.of(context).colorScheme;
    final notif = ref.watch(notificationsCountProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Panel principal'),
        actions: [
          Stack(
            alignment: Alignment.topRight,
            children: [
              IconButton(
                icon: const Icon(Icons.notifications_outlined),
                onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Centro de notificaciones (demo)')),
                ),
              ),
              if (notif > 0)
                Positioned(
                  right: 8,
                  top: 8,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(color: cs.error, shape: BoxShape.circle),
                    child: Text('$notif', style: TextStyle(color: cs.onError, fontSize: 10, fontWeight: FontWeight.bold)),
                  ),
                ),
            ],
          ),
          IconButton(
            tooltip: 'Cerrar sesión',
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await ref.read(authRepositoryProvider).logout();
              if (!mounted) return;
              // ignore: use_build_context_synchronously
              context.go('/login');
            },
          ),
        ],
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final isWide = constraints.maxWidth >= 700;
          final crossAxisCount = constraints.maxWidth >= 950 ? 4 : constraints.maxWidth >= 700 ? 3 : 2;

          return ListView(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Hola $user 👋', style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w800)),
                        const SizedBox(height: 4),
                        Text('Bienvenido a tu WMS', style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: cs.onSurfaceVariant)),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                  _LocationDropdown(),
                ],
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _searchCtrl,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: cs.surface,
                  hintText: 'Buscar folio de operación',
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(28)),
                  enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(28), borderSide: BorderSide(color: cs.outlineVariant)),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
                  suffixIcon: IconButton(
                    tooltip: 'Buscar',
                    icon: const Icon(Icons.arrow_forward),
                    onPressed: () {
                      final q = _searchCtrl.text.trim();
                      if (q.isEmpty) return;
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Buscando folio "$q" (demo)')));
                    },
                  ),
                ),
                onSubmitted: (_) => FocusScope.of(context).unfocus(),
              ),
              const SizedBox(height: 16),
              if (isWide) _SummaryRowWide() else _SummaryRowCompact(),
              const SizedBox(height: 16),
              GridView.count(
                crossAxisCount: crossAxisCount,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                childAspectRatio: 1.15,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  // ignore: deprecated_member_use
                  _GradientTile(icon: Icons.inventory_2_outlined, title: 'Recepción', onTap: () => context.push('/recepcion'), colors: [cs.primaryContainer, cs.primary.withOpacity(.3)]),
                  // ignore: deprecated_member_use
                  _GradientTile(icon: Icons.local_shipping_outlined, title: 'Entregas', onTap: () => context.push('/entregas'), colors: [cs.tertiaryContainer, cs.tertiary.withOpacity(.28)]),
                  // ignore: deprecated_member_use
                  _GradientTile(icon: Icons.scale_outlined, title: 'Pesaje', onTap: () => context.push('/pesaje'), colors: [cs.secondaryContainer, cs.secondary.withOpacity(.28)]),
                  // ignore: deprecated_member_use
                  _GradientTile(icon: Icons.assignment_outlined, title: 'Almacenaje', onTap: () => context.push('/almacenaje'), colors: [cs.surfaceVariant, cs.primary.withOpacity(.18)]),
                  // ignore: deprecated_member_use
                  _GradientTile(icon: Icons.sync_outlined, title: 'Sincronización', onTap: () => context.push('/sync'), colors: [cs.surfaceVariant, cs.secondary.withOpacity(.2)]),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}

class _LocationDropdown extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cs = Theme.of(context).colorScheme;
    final location = ref.watch(activeLocationProvider);
    return DropdownButtonHideUnderline(
      child: DecoratedBox(
        decoration: BoxDecoration(color: cs.surface, borderRadius: BorderRadius.circular(12), border: Border.all(color: cs.outlineVariant)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: DropdownButton<String>(
            value: location,
            hint: const Text('Bodega'),
            items: const [
              DropdownMenuItem(value: 'Bodega MTY', child: Text('Bodega MTY')),
              DropdownMenuItem(value: 'Bodega CUL', child: Text('Bodega CUL')),
              DropdownMenuItem(value: 'Bodega GDL', child: Text('Bodega GDL')),
            ],
            onChanged: (v) => ref.read(activeLocationProvider.notifier).state = v,
          ),
        ),
      ),
    );
  }
}

class _GradientTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;
  final List<Color> colors;
  const _GradientTile({required this.icon, required this.title, required this.onTap, required this.colors});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(18),
      child: Ink(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          gradient: LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: colors),
          // ignore: deprecated_member_use
          boxShadow: [BoxShadow(color: cs.primary.withOpacity(.08), blurRadius: 12, offset: const Offset(0, 6))],
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Icon(icon, size: 32, color: cs.onPrimaryContainer),
            const Spacer(),
            Text(title, style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700)),
          ]),
        ),
      ),
    );
  }
}

class _SummaryRowCompact extends StatelessWidget {
  const _SummaryRowCompact();

  @override
  Widget build(BuildContext context) {
    return Row(children: const [
      Expanded(child: _StatCard(label: 'Pendientes', value: '8')),
      SizedBox(width: 12),
      Expanded(child: _StatCard(label: 'Hoy', value: '3')),
      SizedBox(width: 12),
      Expanded(child: _StatCard(label: 'Atrasados', value: '1')),
    ]);
  }
}

class _SummaryRowWide extends StatelessWidget {
  const _SummaryRowWide();

  @override
  Widget build(BuildContext context) {
    return Row(children: const [
      Expanded(child: _StatCard(label: 'Pendientes', value: '8')),
      SizedBox(width: 12),
      Expanded(child: _StatCard(label: 'Hoy', value: '3')),
      SizedBox(width: 12),
      Expanded(child: _StatCard(label: 'Atrasados', value: '1')),
      SizedBox(width: 12),
      Expanded(child: _StatCard(label: 'Órdenes', value: '12')),
    ]);
  }
}

class _StatCard extends StatelessWidget {
  final String label;
  final String value;
  const _StatCard({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Container(
      height: 86,
      // ignore: deprecated_member_use
      decoration: BoxDecoration(color: cs.primary.withOpacity(.06), borderRadius: BorderRadius.circular(16), border: Border.all(color: cs.outlineVariant)),
      padding: const EdgeInsets.all(14),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(label, style: Theme.of(context).textTheme.labelLarge?.copyWith(color: cs.onSurfaceVariant)),
        const Spacer(),
        Text(value, style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w800)),
      ]),
    );
  }
}

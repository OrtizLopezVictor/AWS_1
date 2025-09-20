import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../dev/dev_fixtures.dart';
import 'reception_repository.dart';

class ReceptionDetailScreen extends ConsumerStatefulWidget {
  const ReceptionDetailScreen({super.key, required this.orderId});
  final String orderId;

  @override
  ConsumerState<ReceptionDetailScreen> createState() => _ReceptionDetailScreenState();
}

class _ReceptionDetailScreenState extends ConsumerState<ReceptionDetailScreen> {
  late Future<List<Map<String, dynamic>>> _future;
  final _codeCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    _future = ref.read(receptionRepositoryProvider).fetchOrderDetail(widget.orderId);
  }

  @override
  void dispose() {
    _codeCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Recepción ${widget.orderId}')),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _future,
        builder: (context, snap) {
          final data = snap.data ?? (DevFixtures.receptionDetail[widget.orderId] ?? []);
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _codeCtrl,
                        decoration: const InputDecoration(
                          labelText: 'Código de caja',
                          prefixIcon: Icon(Icons.qr_code_scanner),
                        ),
                        onSubmitted: (_) => _addBox(),
                      ),
                    ),
                    const SizedBox(width: 8),
                    FilledButton.icon(
                      onPressed: _addBox,
                      icon: const Icon(Icons.add),
                      label: const Text('Agregar'),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView.separated(
                  padding: const EdgeInsets.all(16),
                  itemCount: data.length,
                  itemBuilder: (_, i) {
                    final bx = data[i];
                    return ListTile(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                      tileColor: Theme.of(context).colorScheme.surface,
                      leading: const Icon(Icons.production_quantity_limits),
                      title: Text(bx['code'] ?? 'SIN-COD'),
                      subtitle: Text('Peso: ${bx['weight'] ?? '-'} · ${bx['date'] ?? ''}'),
                    );
                  },
                  separatorBuilder: (_, __) => const SizedBox(height: 8),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Future<void> _addBox() async {
    final code = _codeCtrl.text.trim();
    if (code.isEmpty) return;
    await ref.read(receptionRepositoryProvider).manualEntry(
      orderId: widget.orderId,
      code: code,
      date: DateTime.now().toIso8601String(),
      weight: 11 + (code.hashCode % 8) / 10,
    );
    setState(() {
      _future = ref.read(receptionRepositoryProvider).fetchOrderDetail(widget.orderId);
    });
    _codeCtrl.clear();
  }
}

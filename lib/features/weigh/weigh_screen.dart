import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../state/providers.dart';
import 'weigh_repository.dart';

class WeighScreen extends ConsumerStatefulWidget {
  const WeighScreen({super.key});
  @override
  ConsumerState<WeighScreen> createState() => _WeighScreenState();
}

class _WeighScreenState extends ConsumerState<WeighScreen> {
  final _code = TextEditingController(text: 'BX-');
  final _weight = TextEditingController(text: '11.5');

  @override
  void dispose() {
    _code.dispose();
    _weight.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final rows = ref.watch(weighLogProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Pesaje')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Expanded(
                  flex: 3,
                  child: TextField(
                    controller: _code,
                    decoration: const InputDecoration(
                      labelText: 'Código',
                      prefixIcon: Icon(Icons.qr_code),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: TextField(
                    controller: _weight,
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    decoration: const InputDecoration(
                      labelText: 'Peso (kg)',
                      prefixIcon: Icon(Icons.monitor_weight),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                FilledButton.icon(
                  onPressed: () async {
                    final w = double.tryParse(_weight.text);
                    final c = _code.text.trim();
                    if (w == null || c.isEmpty) return;
                    await ref.read(weighRepositoryProvider).registerWeight(code: c, weight: w);
                    final copy = [...ref.read(weighLogProvider)];
                    copy.add({'codigo': c, 'peso': w, 'fecha': DateTime.now().toIso8601String()});
                    ref.read(weighLogProvider.notifier).state = copy;
                    _code.text = 'BX-';
                  },
                  icon: const Icon(Icons.save),
                  label: const Text('Registrar'),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: rows.length,
              separatorBuilder: (_, __) => const SizedBox(height: 8),
              itemBuilder: (_, i) {
                final r = rows[i];
                return ListTile(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  tileColor: Theme.of(context).colorScheme.surface,
                  leading: const Icon(Icons.inventory_rounded),
                  title: Text(r['codigo'].toString()),
                  subtitle: Text('Peso: ${r['peso']} · ${r['fecha']}'),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

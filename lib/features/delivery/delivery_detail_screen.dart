import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'delivery_repository.dart';

class DeliveryDetailScreen extends ConsumerStatefulWidget {
  const DeliveryDetailScreen({super.key, required this.deliveryId});
  final String deliveryId;

  @override
  ConsumerState<DeliveryDetailScreen> createState() => _DeliveryDetailScreenState();
}

class _DeliveryDetailScreenState extends ConsumerState<DeliveryDetailScreen> {
  late Future<List<String>> _future;
  final _codeCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    _future = ref.read(deliveryRepositoryProvider).fetchDeliveryScans(widget.deliveryId);
  }

  @override
  void dispose() {
    _codeCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Entrega ${widget.deliveryId}')),
      body: FutureBuilder<List<String>>(
        future: _future,
        builder: (context, snap) {
          final data = snap.data ?? <String>[];
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
                        onSubmitted: (_) => _scan(),
                      ),
                    ),
                    const SizedBox(width: 8),
                    FilledButton.icon(
                      onPressed: _scan,
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
                  separatorBuilder: (_, __) => const SizedBox(height: 8),
                  itemBuilder: (_, i) => ListTile(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    tileColor: Theme.of(context).colorScheme.surface,
                    leading: const Icon(Icons.inventory_2_outlined),
                    title: Text(data[i]),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: FilledButton.icon(
                  onPressed: data.isEmpty ? null : _confirm,
                  icon: const Icon(Icons.check_circle),
                  label: const Text('Confirmar salida'),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Future<void> _scan() async {
    final code = _codeCtrl.text.trim();
    if (code.isEmpty) return;
    await ref.read(deliveryRepositoryProvider).scanToDelivery(deliveryId: widget.deliveryId, code: code);
    setState(() {
      _future = ref.read(deliveryRepositoryProvider).fetchDeliveryScans(widget.deliveryId);
    });
    _codeCtrl.clear();
  }

  Future<void> _confirm() async {
    final data = await ref.read(deliveryRepositoryProvider).fetchDeliveryScans(widget.deliveryId);
    await ref.read(deliveryRepositoryProvider).confirmDelivery(deliveryId: widget.deliveryId, codes: data);
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Entrega confirmada (DEV)')));
  }
}

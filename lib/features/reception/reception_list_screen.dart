import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../state/providers.dart';

class ReceptionListScreen extends ConsumerWidget {
  const ReceptionListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final orders = ref.watch(receptionOrdersProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('Recepción')),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemBuilder: (_, i) {
          final o = orders[i];
          return ListTile(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            tileColor: Theme.of(context).colorScheme.surface,
            leading: const Icon(Icons.inventory_2_outlined),
            title: Text(o['id'] as String),
            subtitle: Text('${o['proveedor']} · ${o['fecha']}'),
            trailing: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('${o['cajas']} cajas'),
                const SizedBox(height: 4),
                Chip(label: Text('${o['estado']}')),
              ],
            ),
            onTap: () => context.push('/recepcion/${o['id']}'),
          );
        },
        separatorBuilder: (_, __) => const SizedBox(height: 10),
        itemCount: orders.length,
      ),
    );
  }
}

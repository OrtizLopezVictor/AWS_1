import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../state/providers.dart';

class DeliveryListScreen extends ConsumerWidget {
  const DeliveryListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final items = ref.watch(deliveriesProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('Entregas')),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: items.length,
        separatorBuilder: (_, __) => const SizedBox(height: 10),
        itemBuilder: (_, i) {
          final e = items[i];
          return ListTile(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            tileColor: Theme.of(context).colorScheme.surface,
            leading: const Icon(Icons.local_shipping_outlined),
            title: Text(e['id']),
            subtitle: Text('${e['cliente']} · ${e['fecha']}'),
            trailing: Chip(label: Text('${e['estado']}')),
            onTap: () => context.push('/entregas/${e['id']}'),
          );
        },
      ),
    );
  }
}

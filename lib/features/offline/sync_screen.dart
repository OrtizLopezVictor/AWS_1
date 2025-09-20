import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../state/providers.dart';
import 'sync_repository.dart';

class SyncScreen extends ConsumerWidget {
  const SyncScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final queue = ref.watch(offlineQueueProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Sincronización')),
      body: Column(
        children: [
          Expanded(
            child: queue.isEmpty
                ? const Center(child: Text('Sin operaciones pendientes'))
                : ListView.separated(
                    padding: const EdgeInsets.all(16),
                    itemCount: queue.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 8),
                    itemBuilder: (_, i) {
                      final op = queue[i];
                      return ListTile(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                        tileColor: Theme.of(context).colorScheme.surface,
                        leading: const Icon(Icons.sync),
                        title: Text(op['op'].toString()),
                        subtitle: Text(op.entries.map((e) => '${e.key}: ${e.value}').join(' · ')),
                      );
                    },
                  ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: FilledButton.icon(
              onPressed: queue.isEmpty
                  ? null
                  : () async {
                      await ref.read(syncRepositoryProvider).pushQueue(queue);
                      ref.read(offlineQueueProvider.notifier).state = [];
                      if (context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Cola subida (DEV)')),
                        );
                      }
                    },
              icon: const Icon(Icons.cloud_upload),
              label: const Text('Subir ahora'),
            ),
          ),
        ],
      ),
    );
  }
}

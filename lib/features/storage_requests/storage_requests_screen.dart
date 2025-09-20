import 'package:flutter/material.dart';

class StorageRequestsScreen extends StatelessWidget {
  const StorageRequestsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final items = List.generate(8, (i) => {
      'folio': 'ALM-${2000 + i}',
      // ignore: unnecessary_brace_in_string_interps
      'ubicacion': i.isEven ? 'A-01-0${i}' : 'B-02-0${i - 1}',
      'estado': i.isEven ? 'Pendiente' : 'En curso',
    });

    return Scaffold(
      appBar: AppBar(title: const Text('Almacenaje')),
      body: GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, mainAxisSpacing: 12, crossAxisSpacing: 12, childAspectRatio: 1.25),
        itemCount: items.length,
        itemBuilder: (_, i) {
          final it = items[i];
          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              gradient: LinearGradient(
                // ignore: deprecated_member_use
                colors: [cs.surfaceContainerHighest, cs.primary.withOpacity(.15)],
                begin: Alignment.topLeft, end: Alignment.bottomRight),
            ),
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(it['folio']!, style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700)),
                const Spacer(),
                Text('Ubicación: ${it['ubicacion']}'),
                const SizedBox(height: 4),
                Chip(label: Text(it['estado']!)),
              ],
            ),
          );
        },
      ),
    );
  }
}

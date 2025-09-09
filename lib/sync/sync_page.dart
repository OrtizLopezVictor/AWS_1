import 'package:flutter/material.dart';

class SyncPage extends StatelessWidget {
  const SyncPage({super.key});

  @override
  Widget build(BuildContext context) {
    final pendientes = [
      {"id": "1", "tipo": "Recepción", "estado": "Pendiente"},
      {"id": "2", "tipo": "Entrega", "estado": "Error"},
    ];

    return Scaffold(
      appBar: AppBar(title: const Text("Sincronización Offline")),
      body: ListView.builder(
        itemCount: pendientes.length,
        itemBuilder: (context, i) {
          final item = pendientes[i];
          return Card(
            margin: const EdgeInsets.all(8),
            child: ListTile(
              leading: const Icon(Icons.sync_problem, color: Colors.red),
              title: Text("${item['tipo']} - ${item['id']}"),
              subtitle: Text("Estado: ${item['estado']}"),
            ),
          );
        },
      ),
    );
  }
}

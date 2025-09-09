import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class EntregaListPage extends StatelessWidget {
  const EntregaListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final entregas = [
      {"id": "1", "cliente": "Cliente X", "estado": "Pendiente"},
      {"id": "2", "cliente": "Cliente Y", "estado": "Procesando"},
    ];

    return Scaffold(
      appBar: AppBar(title: const Text("Entregas")),
      body: ListView.builder(
        itemCount: entregas.length,
        itemBuilder: (context, i) {
          final entrega = entregas[i];
          return Card(
            margin: const EdgeInsets.all(8),
            child: ListTile(
              leading: const Icon(Icons.local_shipping),
              title: Text("Entrega ${entrega['id']}"),
              subtitle: Text(
                "Cliente: ${entrega['cliente']} - Estado: ${entrega['estado']}",
              ),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () => context.go("/entrega/${entrega['id']}/scan"),
            ),
          );
        },
      ),
    );
  }
}

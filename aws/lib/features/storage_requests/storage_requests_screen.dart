
import 'package:flutter/material.dart';

class StorageRequestsScreen extends StatelessWidget {
  const StorageRequestsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final items = List.generate(5, (i)=> {'folio':'ALM-${3000+i}','cliente':'Cliente ${(i+1)}','estado': i%2==0?'Pendiente':'Asignado'});
    return Scaffold(
      appBar: AppBar(title: const Text('Solicitudes de Almacenaje')),
      body: ListView.separated(
        itemCount: items.length,
        separatorBuilder: (_, __)=>const Divider(height: 1),
        itemBuilder: (_, i){
          final it = items[i];
          return ListTile(
            title: Text(it['folio']!),
            subtitle: Text(it['cliente']!),
            trailing: Chip(label: Text(it['estado']!)),
          );
        },
      ),
    );
  }
}

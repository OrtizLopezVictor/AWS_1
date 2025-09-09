import 'package:flutter/material.dart';

class EntregaTarimaPage extends StatelessWidget {
  final String entregaId;
  const EntregaTarimaPage({super.key, required this.entregaId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Tarimas Entrega $entregaId")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(Icons.layers, size: 100, color: Colors.purple),
            SizedBox(height: 20),
            Text("Escaneo de tarimas en la entrega"),
          ],
        ),
      ),
    );
  }
}

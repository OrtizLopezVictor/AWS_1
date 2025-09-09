import 'package:flutter/material.dart';

class TarimaPage extends StatelessWidget {
  final String pedidoId;
  const TarimaPage({super.key, required this.pedidoId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Generar Tarima - Pedido $pedidoId")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(Icons.layers, size: 100, color: Colors.green),
            SizedBox(height: 20),
            Text("Generación de etiqueta de tarima máster"),
          ],
        ),
      ),
    );
  }
}

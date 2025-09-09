import 'package:flutter/material.dart';

class EscaneoPage extends StatelessWidget {
  final String pedidoId;
  const EscaneoPage({super.key, required this.pedidoId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Escaneo Pedido $pedidoId")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(Icons.qr_code_scanner, size: 100, color: Colors.blue),
            SizedBox(height: 20),
            Text("Aquí se mostrará el escaneo de cajas"),
          ],
        ),
      ),
    );
  }
}

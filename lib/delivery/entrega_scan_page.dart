import 'package:flutter/material.dart';

class EntregaScanPage extends StatelessWidget {
  final String entregaId;
  const EntregaScanPage({super.key, required this.entregaId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Escaneo Entrega $entregaId")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(Icons.qr_code_scanner, size: 100, color: Colors.orange),
            SizedBox(height: 20),
            Text("Escaneo de cajas para la entrega"),
          ],
        ),
      ),
    );
  }
}

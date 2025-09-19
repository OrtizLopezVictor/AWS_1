
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ReceptionDetailScreen extends StatelessWidget {
  final String orderId;
  const ReceptionDetailScreen({super.key, required this.orderId});

  @override
  Widget build(BuildContext context) {
    final editable = !orderId.endsWith('5'); // demo: algunos finalizados
    return Scaffold(
      appBar: AppBar(title: Text('Pedido $orderId')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Proveedor: ACME SA de CV'),
            const SizedBox(height: 4),
            Text('Fecha: 2025-09-12'),
            const SizedBox(height: 8),
            const Text('Productos:'),
            const SizedBox(height: 6),
            Expanded(
              child: ListView(
                children: const [
                  ListTile(title: Text('SKU-001'), subtitle: Text('Esperado: 10 • Recibido: 4')),
                  ListTile(title: Text('SKU-002'), subtitle: Text('Esperado: 5 • Recibido: 5')),
                ],
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(child: ElevatedButton.icon(
                  onPressed: editable ? ()=>context.push('/recepcion/$orderId/scan') : null,
                  icon: const Icon(Icons.qr_code_scanner),
                  label: const Text('Escanear cajas'),
                )),
                const SizedBox(width: 8),
                Expanded(child: OutlinedButton.icon(
                  onPressed: editable ? ()=>context.push('/recepcion/$orderId/manual') : null,
                  icon: const Icon(Icons.edit),
                  label: const Text('Entrada manual'),
                )),
              ],
            ),
            const SizedBox(height: 8),
            ElevatedButton.icon(
              onPressed: editable ? ()=>context.push('/recepcion/$orderId/tarima') : null,
              icon: const Icon(Icons.inventory_2),
              label: const Text('Generar etiqueta tarima máster'),
            ),
            const SizedBox(height: 8),
            FilledButton.icon(
              onPressed: editable ? (){
                // TODO(API): confirmar recepción
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Recepción confirmada (demo)')));
              } : null,
              icon: const Icon(Icons.check_circle),
              label: const Text('Confirmar recepción'),
            )
          ],
        ),
      ),
    );
  }
}

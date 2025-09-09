import 'package:flutter/material.dart';
import '../../models/order_model.dart';

class ReceptionDetailPage extends StatelessWidget {
  const ReceptionDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Buscar pedido',
                    prefixIcon: const Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              ElevatedButton(onPressed: () {}, child: const Text('Filtrar')),
            ],
          ),
          const SizedBox(height: 16),
          const Text(
            'Selecciona el pedido para ver el detalle',
            style: TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 16),
          ...mockOrders.map((order) => _buildOrderCard(order)),
        ],
      ),
    );
  }

  Widget _buildOrderCard(Order order) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Pedido: ${order.orderNumber}',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                Chip(
                  label: Text(order.status),
                  backgroundColor: order.status == 'Finalizado'
                      ? Colors.green[100]
                      : Colors.orange[100],
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text('Proveedor: ${order.supplier}'),
            Text('Fecha: ${order.date}'),
            const SizedBox(height: 8),
            const Text(
              'Producto    |    SKU    |    Cantidad    |    UOM',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            ...order.products
                .map(
                  (product) => Padding(
                    padding: const EdgeInsets.only(top: 4.0),
                    child: Text(
                      '${product.name}  ${product.sku}  ${product.quantity}  ${product.uom}',
                    ),
                  ),
                )
                ,
          ],
        ),
      ),
    );
  }
}

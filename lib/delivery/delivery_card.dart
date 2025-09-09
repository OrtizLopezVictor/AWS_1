import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/delivery_model.dart';

class DeliveryCard extends StatelessWidget {
  final DeliveryOrder order;
  final Function(DeliveryStatus) onStatusChanged;

  const DeliveryCard({
    super.key,
    required this.order,
    required this.onStatusChanged,
  });

  @override
  Widget build(BuildContext context) {
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
                  order.orderNumber,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                Chip(
                  label: Text(
                    order.statusText,
                    style: const TextStyle(color: Colors.white),
                  ),
                  backgroundColor: order.statusColor,
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              'Cliente: ${order.client}',
              style: const TextStyle(fontSize: 16),
            ),
            Text(
              'Fecha: ${order.date.day}/${order.date.month}/${order.date.year}',
            ),
            const SizedBox(height: 12),
            const Text(
              'Productos:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            ...order.products.map((product) => Text('- $product')).toList(),
            const SizedBox(height: 16),
            if (order.status != DeliveryStatus.delivered &&
                order.status != DeliveryStatus.cancelled)
              DropdownButton<DeliveryStatus>(
                value: order.status,
                items: DeliveryStatus.values
                    .where(
                      (status) =>
                          status != DeliveryStatus.delivered &&
                          status != DeliveryStatus.cancelled,
                    )
                    .map((status) {
                      return DropdownMenuItem(
                        value: status,
                        child: Text(status.name),
                      );
                    })
                    .toList(),
                onChanged: (newStatus) {
                  if (newStatus != null) {
                    onStatusChanged(newStatus);
                  }
                },
              ),
            if (order.status == DeliveryStatus.onTheWay)
              ElevatedButton(
                onPressed: () {
                  onStatusChanged(DeliveryStatus.delivered);
                },
                child: const Text('Marcar como entregado'),
              ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_application_1/reception/reception_page.dart';

class OperationsPage extends StatelessWidget {
  const OperationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Operaciones',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          const Text(
            'Selecciona el tipo de operación que deseas hacer',
            style: TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 20),
          GridView.count(
            shrinkWrap: true,
            crossAxisCount: 2,
            childAspectRatio: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            children: [
              _buildOperationCard(context, 'Recibir', '3', Icons.inbox),
              _buildOperationCard(
                context,
                'Entregar',
                '4',
                Icons.local_shipping,
              ),
              _buildOperationCard(
                context,
                'Traslados Internos',
                '0',
                Icons.move_to_inbox,
              ),
              _buildOperationCard(context, 'Fabricación', '0', Icons.build),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildOperationCard(
    BuildContext context,
    String title,
    String count,
    IconData icon,
  ) {
    return Card(
      elevation: 3,
      child: InkWell(
        onTap: () {
          if (title == 'Recibir') {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ReceptionPage()),
            );
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    title,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    count,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Icon(icon, size: 30),
            ],
          ),
        ),
      ),
    );
  }
}

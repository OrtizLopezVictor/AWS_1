import 'package:flutter/material.dart';

class ReceptionSummaryPage extends StatelessWidget {
  const ReceptionSummaryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          _buildProgressCard('Avance 28%', 'Tienes orden COMPLETADA'),
          _buildProgressCard('Asignadas 4/13', 'Tienes orden COMPLETADA'),
          const SizedBox(height: 20),
          _buildStatusItem('Atrasado', '5 >'),
          _buildStatusItem('Por Procesar', '3 >'),
          _buildStatusItem('Ordenes parciales', '3 >'),
          _buildStatusItem('Completadas', '1 >'),
          _buildStatusItem('Total', '4 >'),
        ],
      ),
    );
  }

  Widget _buildProgressCard(String title, String subtitle) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 8),
            Text(subtitle),
            const SizedBox(height: 8),
            const LinearProgressIndicator(
              value: 0.28,
              backgroundColor: Colors.grey,
              valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusItem(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label),
          Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}


import 'package:flutter/material.dart';

class WeighScreen extends StatefulWidget {
  const WeighScreen({super.key});

  @override
  State<WeighScreen> createState() => _WeighScreenState();
}

class _WeighScreenState extends State<WeighScreen> {
  final _code = TextEditingController();
  final _weight = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Pesaje de producto')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(controller: _code, decoration: const InputDecoration(labelText: 'Código / SKU')),
            const SizedBox(height: 8),
            TextField(controller: _weight, decoration: const InputDecoration(labelText: 'Peso (kg)'), keyboardType: TextInputType.number),
            const SizedBox(height: 12),
            ElevatedButton.icon(
              onPressed: (){
                // TODO(API): POST /api/pesaje
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Peso registrado (demo)')));
              },
              icon: const Icon(Icons.scale),
              label: const Text('Registrar peso'),
            )
          ],
        ),
      ),
    );
  }
}

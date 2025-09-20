
import 'package:flutter/material.dart';

class MasterPalletScreen extends StatefulWidget {
  final String orderId;
  const MasterPalletScreen({super.key, required this.orderId});

  @override
  State<MasterPalletScreen> createState() => _MasterPalletScreenState();
}

class _MasterPalletScreenState extends State<MasterPalletScreen> {
  int cajas = 0;
  double peso = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Tarima máster • ${widget.orderId}')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Cajas escaneadas: $cajas'),
            Text('Peso total: ${peso.toStringAsFixed(2)} kg'),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: (){
                setState(() { cajas = 12; peso = 87.5; });
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Etiqueta generada y guardada (demo)')));
              },
              icon: const Icon(Icons.qr_code_2),
              label: const Text('Generar etiqueta'),
            ),
            const SizedBox(height: 8),
            OutlinedButton.icon(
              onPressed: (){
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Reimpresión enviada (demo)')));
              },
              icon: const Icon(Icons.print),
              label: const Text('Reimprimir'),
            )
          ],
        ),
      ),
    );
  }
}

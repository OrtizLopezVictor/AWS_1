
import 'package:flutter/material.dart';
import '../../common/widgets/barcode_scan_preview.dart';
import 'package:go_router/go_router.dart';

class DeliveryScanScreen extends StatefulWidget {
  final String deliveryId;
  const DeliveryScanScreen({super.key, required this.deliveryId});

  @override
  State<DeliveryScanScreen> createState() => _DeliveryScanScreenState();
}

class _DeliveryScanScreenState extends State<DeliveryScanScreen> {
  final codes = <String>[];
  double total = 0;

  void _onScan(String c){
    if (codes.contains(c)) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Código duplicado.')));
      return;
    }
    codes.add(c);
    total += 1.0; // demo
    setState((){});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Entrega ${widget.deliveryId}'),
        actions: [
          TextButton.icon(onPressed: ()=> context.push('/entregas/${widget.deliveryId}/tarimas'), icon: const Icon(Icons.inventory_2), label: const Text('Tarimas'))
        ],
      ),
      body: Column(
        children: [
          Expanded(child: BarcodeScanPreview(onDetect: _onScan)),
          const Divider(height: 1),
          ListTile(title: const Text('Total acumulado'), trailing: Text('$total kg')),
          Expanded(
            child: ListView.builder(
              itemCount: codes.length,
              itemBuilder: (_, i)=> ListTile(title: Text(codes[i])),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton.icon(
              onPressed: codes.isEmpty ? null : (){
                // 
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Entrega confirmada (demo)')));
              },
              icon: const Icon(Icons.check),
              label: const Text('Entregar'),
            ),
          )
        ],
      ),
    );
  }
}

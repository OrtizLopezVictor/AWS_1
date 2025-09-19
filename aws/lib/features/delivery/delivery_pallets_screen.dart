
import 'package:flutter/material.dart';
import '../../common/widgets/barcode_scan_preview.dart';

class DeliveryPalletsScreen extends StatefulWidget {
  final String deliveryId;
  const DeliveryPalletsScreen({super.key, required this.deliveryId});

  @override
  State<DeliveryPalletsScreen> createState() => _DeliveryPalletsScreenState();
}

class _DeliveryPalletsScreenState extends State<DeliveryPalletsScreen> {
  final pallets = <String, double>{};
  double get total => pallets.values.fold(0, (a,b)=>a+b);

  void _onScan(String code){
    if (pallets.containsKey(code)) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Tarima duplicada.')));
      return;
    }
    pallets[code] = 10.0; // demo
    setState((){});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Tarimas • ${widget.deliveryId}')),
      body: Column(
        children: [
          Expanded(child: BarcodeScanPreview(onDetect: _onScan)),
          ListTile(title: const Text('Total acumulado'), trailing: Text('$total kg')),
          Expanded(
            child: ListView(
              children: pallets.entries.map((e)=> ListTile(title: Text(e.key), trailing: Text('${e.value} kg'))).toList(),
            ),
          ),
        ],
      ),
    );
  }
}


import 'package:flutter/material.dart';
import '../../common/widgets/barcode_scan_preview.dart';

class ScanBoxesScreen extends StatefulWidget {
  final String orderId;
  const ScanBoxesScreen({super.key, required this.orderId});

  @override
  State<ScanBoxesScreen> createState() => _ScanBoxesScreenState();
}

class _ScanBoxesScreenState extends State<ScanBoxesScreen> {
  int mode = 1; // 1: fecha en etiqueta, 2: fecha hoy, 3: manual
  final List<Map<String, dynamic>> scans = [];

  void _addScan(String code) {
    if (scans.any((e)=> e['code']==code)) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Código duplicado.')));
      return;
    }
    scans.add({'code': code, 'weight': 1.0, 'date': DateTime.now()});
    setState((){});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Escanear cajas • ${widget.orderId}')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SegmentedButton<int>(
              segments: const [
                ButtonSegment(value: 1, label: Text('Modo 1')),
                ButtonSegment(value: 2, label: Text('Modo 2')),
                ButtonSegment(value: 3, label: Text('Manual')),
              ],
              selected: {mode},
              onSelectionChanged: (s)=> setState(()=> mode = s.first),
            ),
          ),
          Expanded(
            child: mode==3 
              ? Center(child: ElevatedButton.icon(
                  onPressed: () async {
                    final code = await showDialog<String>(context: context, builder: (ctx){
                      final c = TextEditingController();
                      return AlertDialog(
                        title: const Text('Captura manual'),
                        content: TextField(controller: c, decoration: const InputDecoration(labelText: 'Código')),
                        actions: [
                          TextButton(onPressed: ()=>Navigator.pop(ctx), child: const Text('Cancelar')),
                          ElevatedButton(onPressed: ()=>Navigator.pop(ctx, c.text), child: const Text('Agregar')),
                        ],
                      );
                    });
                    if (code!=null && code.isNotEmpty) _addScan(code);
                  },
                  icon: const Icon(Icons.add),
                  label: const Text('Agregar código')))
              : BarcodeScanPreview(onDetect: _addScan),
          ),
          const Divider(height: 1),
          Expanded(
            child: ListView.builder(
              itemCount: scans.length,
              itemBuilder: (_, i){
                final it = scans[i];
                return ListTile(
                  title: Text(it['code']),
                  subtitle: Text('Peso: ${it['weight']} • Fecha: ${it['date']}'),
                  trailing: IconButton(icon: const Icon(Icons.delete_outline), onPressed: (){
                    setState(()=> scans.removeAt(i));
                  }),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(child: ElevatedButton.icon(
                  onPressed: scans.isEmpty ? null : (){
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Enviadas ${scans.length} cajas (demo)')));
                  },
                  icon: const Icon(Icons.cloud_upload),
                  label: const Text('Enviar'),
                )),
              ],
            ),
          )
        ],
      ),
    );
  }
}

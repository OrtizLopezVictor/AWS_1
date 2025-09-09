import 'package:flutter/material.dart';

class ManualEntryPage extends StatefulWidget {
  final String pedidoId;
  const ManualEntryPage({super.key, required this.pedidoId});

  @override
  State<ManualEntryPage> createState() => _ManualEntryPageState();
}

class _ManualEntryPageState extends State<ManualEntryPage> {
  final TextEditingController codeCtrl = TextEditingController();
  final TextEditingController qtyCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Entrada Manual - Pedido ${widget.pedidoId}")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: codeCtrl,
              decoration: const InputDecoration(
                labelText: "Código de caja",
                prefixIcon: Icon(Icons.qr_code),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: qtyCtrl,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: "Cantidad",
                prefixIcon: Icon(Icons.format_list_numbered),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      "Caja ${codeCtrl.text} x${qtyCtrl.text} guardada",
                    ),
                  ),
                );
              },
              child: const Text("Guardar"),
            ),
          ],
        ),
      ),
    );
  }
}


import 'package:flutter/material.dart';

class ManualEntryScreen extends StatefulWidget {
  final String orderId;
  const ManualEntryScreen({super.key, required this.orderId});

  @override
  State<ManualEntryScreen> createState() => _ManualEntryScreenState();
}

class _ManualEntryScreenState extends State<ManualEntryScreen> {
  final _formKey = GlobalKey<FormState>();
  final _code = TextEditingController();
  final _date = TextEditingController();
  final _weight = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Entrada manual • ${widget.orderId}')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(controller: _code, decoration: const InputDecoration(labelText: 'Código'), validator: (v)=> v==null||v.isEmpty ? 'Requerido' : null),
              const SizedBox(height: 8),
              TextFormField(controller: _date, decoration: const InputDecoration(labelText: 'Fecha (YYYY-MM-DD)'), validator: (v)=> v==null||v.isEmpty ? 'Requerido' : null),
              const SizedBox(height: 8),
              TextFormField(controller: _weight, decoration: const InputDecoration(labelText: 'Peso (kg)'), keyboardType: TextInputType.number),
              const SizedBox(height: 16),
              ElevatedButton.icon(
                onPressed: (){
                  if (!_formKey.currentState!.validate()) return;
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Caja registrada (demo)')));
                },
                icon: const Icon(Icons.save),
                label: const Text('Guardar'),
              )
            ],
          ),
        ),
      ),
    );
  }
}


import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../common/widgets/filter_chips.dart';

class DeliveryListScreen extends StatefulWidget {
  const DeliveryListScreen({super.key});

  @override
  State<DeliveryListScreen> createState() => _DeliveryListScreenState();
}

class _DeliveryListScreenState extends State<DeliveryListScreen> {
  String filter = 'Por procesar';
  final items = List.generate(6, (i)=> {'id':'ENT-${2000+i}','cliente':'Cliente ${i+1}','fecha':'2025-09-13','estado': i%3==0? 'Entregados':'Por procesar'});

  @override
  Widget build(BuildContext context) {
    final filtered = items.where((e)=> filter=='Todos' ? true : e['estado']==filter).toList();
    return Scaffold(
      appBar: AppBar(title: const Text('Entregas')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: FilterChips(options: const ['Atrasados','Por procesar','Entregados','Todos'], selected: filter, onSelected: (s)=>setState(()=>filter=s)),
          ),
          Expanded(
            child: ListView.separated(
              itemCount: filtered.length,
              separatorBuilder: (_, __)=>const Divider(height: 1),
              itemBuilder: (_, i){
                final it = filtered[i];
                return ListTile(
                  title: Text(it['id']!),
                  subtitle: Text('${it['cliente']} • ${it['fecha']}'),
                  trailing: Chip(label: Text(it['estado']!)),
                  onTap: ()=> context.push('/entregas/${it['id']}/scan'),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}

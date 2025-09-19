
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../common/widgets/filter_chips.dart';

class ReceptionListScreen extends ConsumerStatefulWidget {
  const ReceptionListScreen({super.key});
  @override
  ConsumerState<ReceptionListScreen> createState() => _ReceptionListScreenState();
}

class _ReceptionListScreenState extends ConsumerState<ReceptionListScreen> {
  String _filter = 'En espera';
  final _searchCtrl = TextEditingController();
  final _items = List.generate(8, (i)=> {'id':'RCP-${1000+i}','proveedor':'Proveedor ${i+1}','fecha':'2025-09-10','status': i%3==0? 'Finalizado':'En espera'});

  @override
  Widget build(BuildContext context) {
    final filtered = _items.where((e)=> _filter=='Todos' ? true : e['status']==_filter).where((e){
      final q=_searchCtrl.text.trim();
      return q.isEmpty || (e['id'] as String).toLowerCase().contains(q.toLowerCase());
    }).toList();

    return Scaffold(
      appBar: AppBar(title: const Text('Recepción - Pedidos')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: _searchCtrl,
                  decoration: const InputDecoration(labelText: 'Buscar por número de pedido'),
                  onChanged: (_)=>setState((){}),
                ),
                const SizedBox(height: 8),
                FilterChips(options: const ['En espera','Finalizado','Todos'], selected: _filter, onSelected: (s)=>setState(()=>_filter=s)),
              ],
            ),
          ),
          const Divider(height: 1),
          Expanded(
            child: filtered.isEmpty
            ? const Center(child: Text('Sin resultados'))
            : ListView.separated(
              itemCount: filtered.length,
              separatorBuilder: (_, __)=>const Divider(height: 1),
              itemBuilder: (_, i){
                final it = filtered[i];
                return ListTile(
                  title: Text(it['id']!),
                  subtitle: Text('${it['proveedor']} • ${it['fecha']}'),
                  trailing: Chip(label: Text(it['status']!)),
                  onTap: ()=>context.push('/recepcion/${it['id']}'),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}

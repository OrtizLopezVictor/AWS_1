
import 'package:flutter/material.dart';

class SyncScreen extends StatefulWidget {
  const SyncScreen({super.key});

  @override
  State<SyncScreen> createState() => _SyncScreenState();
}

class _SyncScreenState extends State<SyncScreen> {
  bool online = false;
  final logs = <String>[];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sincronización Offline')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SwitchListTile(
              value: online,
              onChanged: (v)=> setState(()=> online = v),
              title: Text(online ? 'Conectado' : 'Sin conexión'),
              subtitle: const Text('La app guarda movimientos localmente y sube la cola al reconectar.'),
            ),
            const SizedBox(height: 8),
            ElevatedButton.icon(
              onPressed: (){
                // TODO(OFFLINE): disparar Workmanager para subir cola
                setState(()=> logs.add('${DateTime.now()} → Intentando sincronizar cola...'));
              },
              icon: const Icon(Icons.sync),
              label: const Text('Forzar sincronización'),
            ),
            const SizedBox(height: 12),
            const Text('Bitácora de sincronización:'),
            const SizedBox(height: 6),
            Expanded(
              child: ListView.builder(
                itemCount: logs.length,
                itemBuilder: (_, i)=> ListTile(leading: const Icon(Icons.article), title: Text(logs[i])),
              ),
            )
          ],
        ),
      ),
    );
  }
}

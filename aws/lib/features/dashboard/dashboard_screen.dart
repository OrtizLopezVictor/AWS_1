
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../state/providers.dart';

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(usernameProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('Dashboard')),
      body: Center(child: Text('Hola ${user ?? 'Operador'}')),
    );
  }
}

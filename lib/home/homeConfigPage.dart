// File: lib/home/homeConfigPage.dart
import 'package:flutter/material.dart';

class HomeConfigPage extends StatelessWidget {
  const HomeConfigPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Configuración')),
      body: const Center(child: Text('Página de configuración')),
    );
  }
}

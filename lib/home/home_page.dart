import 'package:flutter_application_1/profile/settings_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/operation/operation.dart';
import 'package:flutter_application_1/reception/reception_page.dart';
import 'package:flutter_application_1/profile/profile_page.dart'; // Nueva importación
import 'package:flutter_application_1/widgets/bottom_nav_bar.dart';

class HomePage extends StatefulWidget {
  final String usuario;

  const HomePage({super.key, required this.usuario});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const OperationsPage(),
    const ReceptionPage(),
    const ProfilePage(), // Actualizado a ProfilePage
    const SettingsPage(), // Nueva página de configuración
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('App WMS'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SettingsPage()),
              );
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: CircleAvatar(child: Text(widget.usuario[0].toUpperCase())),
          ),
        ],
      ),
      body: _pages[_currentIndex],
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Configuración')),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          const Text(
            'Preferencias',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          _buildSettingSwitch('Notificaciones', true),
          _buildSettingSwitch('Modo oscuro', false),
          _buildSettingSwitch('Sonidos', true),
          const Divider(height: 40),
          const Text(
            'Seguridad',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          _buildSettingOption(Icons.lock, 'Cambiar contraseña'),
          _buildSettingOption(Icons.fingerprint, 'Autenticación biométrica'),
          _buildSettingOption(Icons.security, 'Privacidad'),
          const Divider(height: 40),
          const Text(
            'Acerca de',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          _buildSettingOption(Icons.info, 'Versión de la app'),
          _buildSettingOption(Icons.help, 'Ayuda y soporte'),
          _buildSettingOption(Icons.description, 'Términos y condiciones'),
        ],
      ),
    );
  }

  Widget _buildSettingSwitch(String title, bool value) {
    return SwitchListTile(
      title: Text(title),
      value: value,
      onChanged: (bool newValue) {
        // Lógica para cambiar el valor
      },
    );
  }

  Widget _buildSettingOption(IconData icon, String title) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      trailing: const Icon(Icons.chevron_right),
      onTap: () {
        // Navegar a la pantalla correspondiente
      },
    );
  }
}

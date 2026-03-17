import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: ListView(
        children: const [
          ListTile(leading: Icon(Icons.security), title: Text('Rate limiting and abuse prevention enabled')),
          ListTile(leading: Icon(Icons.notifications_active), title: Text('Push notifications configured via Firebase')),
          ListTile(leading: Icon(Icons.privacy_tip), title: Text('API protection through tokenized signaling endpoints')),
        ],
      ),
    );
  }
}

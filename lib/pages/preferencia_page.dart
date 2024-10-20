// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/auditoria.dart';
import 'package:flutter_application_1/utils/database_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PreferenciaPage extends StatefulWidget {
  const PreferenciaPage({super.key});

  @override
  State<PreferenciaPage> createState() => _PreferenciaPageState();
}

class _PreferenciaPageState extends State<PreferenciaPage> {
  String _userName = '';
  int _counter = 0;

  // Método para cargar preferencias desde SharedPreferences
  Future<void> _loadPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _userName = prefs.getString('userName') ?? '';
      _counter = prefs.getInt('counter') ?? 0;
      print('Counter value $_counter is loaded');
      print('Username value $_userName is loaded');
    });
  }

  // Método para guardar preferencias en SharedPreferences
  Future<void> _savePreferences() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('userName', _userName);
    await prefs.setInt('counter', _counter);

    // Insertar en la base de datos
    await DatabaseHelper()
        .insertAuditoria(Auditoria(action: 'Actualizó preferencias'));
  }

  @override
  void initState() {
    super.initState();
    _loadPreferences(); // Cargar las preferencias al iniciar
  }

  void _updateUserName(String newName) {
    setState(() {
      _userName = newName;
    });
    _savePreferences(); // Guardar preferencias cada vez que se actualiza el nombre
  }

  void _updateCounter(double newValue) {
    setState(() {
      _counter = newValue.toInt();
    });
    _savePreferences(); // Guardar preferencias cada vez que se actualiza el contador
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Preferencias'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextFormField(
              initialValue: _userName,
              decoration: const InputDecoration(labelText: 'Nombre de usuario'),
              onChanged: _updateUserName,
            ),
            const SizedBox(height: 20),
            Text('Valor del contador: $_counter'),
            Slider(
              value: _counter.toDouble(),
              min: 0,
              max: 100,
              divisions: 100,
              onChanged: _updateCounter,
            ),
          ],
        ),
      ),
    );
  }
}

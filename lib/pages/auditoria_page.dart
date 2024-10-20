import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/auditoria.dart';
import 'package:flutter_application_1/utils/database_helper.dart';

class AuditoriaPage extends StatefulWidget {
  const AuditoriaPage({super.key});

  @override
  State<AuditoriaPage> createState() => _AuditoriaPageState();
}

class _AuditoriaPageState extends State<AuditoriaPage> {
  List<Auditoria> _auditorias = [];

  @override
  void initState() {
    super.initState();
    _loadAuditorias();
  }

  Future<void> _loadAuditorias() async {
    final auditorias = await DatabaseHelper().getAllAuditorias();
    setState(() {
      _auditorias = auditorias;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Auditoría'),
      ),
      body: ListView.builder(
        itemCount: _auditorias.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(_auditorias[index].action),
          );
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_application_1/models/app_data.dart';

class AuditoriaPage extends StatelessWidget {
  const AuditoriaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Auditoría'),
      ),
      body: Consumer<AppData>(
        builder: (context, appData, child) {
          return ListView.builder(
            itemCount: appData.actions.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(appData.actions[index]),
              );
            },
          );
        },
      ),
    );
  }
}

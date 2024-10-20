import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/auditoria.dart';
import 'package:flutter_application_1/pages/about_page.dart';
import 'package:flutter_application_1/models/app_data.dart';
import 'package:flutter_application_1/pages/preferencia_page.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'detail_page.dart';
import 'package:flutter_application_1/pages/auditoria_page.dart';
import 'package:flutter_application_1/utils/database_helper.dart';

final logger = Logger();

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  // ignore: no_logic_in_create_state
  State<MyHomePage> createState() {
    logger.i("createState called");
    return _MyHomePageState();
  }
}

class _MyHomePageState extends State<MyHomePage> {
  bool _hasLogged = false;
  String _userName = '';
  int _counter = 0;

  // Método para cargar preferencias desde SharedPreferences
  Future<void> _loadPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _userName = prefs.getString('userName') ?? '';
      _counter = prefs.getInt('counter') ?? 0;
      logger.i('Counter value $_counter is loaded');
      logger.i('Username value $_userName is loaded');
    });
  }

  @override
  void initState() {
    super.initState();
    logger
        .i("initState called: Widget inserted in the tree for the first time.");
  }

  Widget _getGameStatus() {
    String message;
    Widget icon;

    if (_counter == 10) {
      message = "¡Victoria!";
      icon = SvgPicture.asset(
        'assets/icons/8664871_thumbs_up_icon.svg',
        width: 100,
        height: 100,
        semanticsLabel: 'Victoria Icon',
      );
    } else if (_counter == 5) {
      message = "Derrota";
      icon = SvgPicture.asset(
        'assets/icons/8666595_x_icon.svg',
        width: 100,
        height: 100,
        semanticsLabel: 'Derrota Icon',
      );
    } else {
      message = "¡Sigue jugando!";
      icon = SvgPicture.asset(
        'assets/icons/8674409_ic_fluent_bot_regular_icon.svg',
        width: 100,
        height: 100,
        semanticsLabel: 'bot_icon',
      );
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        icon,
        const SizedBox(height: 16),
        Text(
          message,
          style: const TextStyle(
            fontSize: 24,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 16),
        if (_userName.isNotEmpty)
          Text(
            'Hola $_userName',
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    if (!_hasLogged) {
      logger.i("build called: Building/rebuilding the widget.");
      _hasLogged = true;
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: Text(widget.title),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.deepPurple,
              ),
              child: Text(
                'Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.countertops),
              title: const Text('Contador'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.details),
              title: const Text('Detalle'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const DetailPage()),
                );
                context.read<AppData>().addAction("Acceso a 'Detalle'");
              },
            ),
            ListTile(
              leading: const Icon(Icons.info),
              title: const Text('Sobre'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AboutPage()),
                );
                context.read<AppData>().addAction("Acceso a 'Sobre'");
              },
            ),
            ListTile(
              leading: const Icon(Icons.history),
              title: const Text('Auditoría'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const AuditoriaPage()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Preferencias'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const PreferenciaPage()),
                ).then((_) async {
                  await _loadPreferences();
                  await DatabaseHelper().insertAuditoria(
                      Auditoria(action: 'Acceso a Preferencias'));
                });
              },
            ),
          ],
        ),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Card(
              color: const Color.fromARGB(0, 0, 0, 0),
              elevation: 1,
              margin: const EdgeInsets.all(16),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    _getGameStatus(),
                    const SizedBox(height: 16),
                    Text(
                      '$_counter',
                      style: const TextStyle(
                        fontSize: 40,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          onPressed: () async {
                            setState(() {
                              _counter--;
                            });
                            await DatabaseHelper().insertAuditoria(
                                Auditoria(action: 'Disminuyó el contador'));
                          },
                          icon: const Icon(Icons.arrow_downward),
                        ),
                        IconButton(
                          onPressed: () async {
                            setState(() {
                              _counter = 0;
                            });
                            await DatabaseHelper().insertAuditoria(
                                Auditoria(action: 'Reinició el contador'));
                          },
                          icon: const Icon(Icons.refresh),
                        ),
                        IconButton(
                          onPressed: () async {
                            setState(() {
                              _counter++;
                            });
                            await DatabaseHelper().insertAuditoria(
                                Auditoria(action: 'Incrementó el contador'));
                          },
                          icon: const Icon(Icons.arrow_upward),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

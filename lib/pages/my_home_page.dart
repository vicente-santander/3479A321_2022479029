import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/about_page.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:logger/logger.dart';
import 'detail_page.dart'; // Importar DetailPage

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
  int _counter = 0;
  bool _hasLogged = false;

  @override
  void initState() {
    super.initState();
    logger.i("initState called: Widget inserted in the tree for the first time.");
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    logger.i("didChangeDependencies called: Widget dependencies changed or initialized.");
  }

  @override
  void setState(VoidCallback fn) {
    if (mounted) {
      super.setState(fn);
      logger.i("setState called: Triggered a rebuild due to state change.");
    } 
  }

  @override
  void didUpdateWidget(covariant MyHomePage oldWidget) {
    super.didUpdateWidget(oldWidget);
    logger.i("didUpdateWidget called: Widget properties updated from ${oldWidget.title} to ${widget.title}.");
  }

  @override
  void deactivate() {
    logger.i("deactivate called: Widget is about to be removed from the tree.");
    super.deactivate();
  }

  @override
  void dispose() {
    logger.i("dispose called: Widget is permanently removed.");
    super.dispose();
  }

  @override
  void reassemble() {
    super.reassemble();
    logger.i("reassemble called: Application reassembled, usually due to hot reload.");
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
              Navigator.pop(context); // Close the drawer
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
            },
          ),
          ListTile(
            leading: const Icon(Icons.info),
            title: const Text('Sobre'),
            onTap: () {
              // Navigate to Sobre screen
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AboutPage()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.history),
            title: const Text('Auditoría'),
            onTap: () {
             /* Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AuditoriaPage()),
              );*/
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
                        onPressed: _decrementCounter,
                        icon: const Icon(Icons.arrow_downward),
                      ),
                      IconButton(
                        onPressed: _resetCounter,
                        icon: const Icon(Icons.refresh),
                      ),
                      IconButton(
                        onPressed: _incrementCounter,
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


  void _incrementCounter() {
    if (mounted) {
      setState(() {
        _counter++;
        logger.d("Counter incremented to $_counter");
      });
    }
  }

  void _decrementCounter() {
    if (mounted) {
      setState(() {
        if (_counter > 0) _counter--;
        logger.d("Counter decremented to $_counter");
      });
    }
  }

  void _resetCounter() {
    if (mounted) {
      setState(() {
        _counter = 0;
        logger.d("Counter reset to $_counter");
      });
    }
  }
}

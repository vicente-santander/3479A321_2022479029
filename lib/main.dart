import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:logger/logger.dart';
import 'package:flutter_application_1/models/app_data.dart';
import 'package:flutter_application_1/pages/my_home_page.dart';

final logger = Logger();

void main() {
  logger.d("Logger is working!");
  runApp(
    ChangeNotifierProvider(
      create: (context) => AppData(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    logger.i("Building MyApp");
    return MaterialApp(
      title: 'Lab Vicente Santander',
      theme: ThemeData(
        fontFamily: 'CHOWFUN_',
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Home'),
    );
  }
}

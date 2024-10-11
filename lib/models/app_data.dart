import 'package:flutter/material.dart';

class AppData extends ChangeNotifier {
  int counter = 0;
  List<String> actions = [];

  void incrementCounter() {
    counter++;
    addAction("Incrementó el contador a $counter");
    notifyListeners();
  }

  void decrementCounter() {
    counter--;
    addAction("Decrementó el contador a $counter");
    notifyListeners();
  }

  void resetCounter() {
    counter = 0;
    addAction("Reinició el contador");
    notifyListeners();
  }

  void addAction(String action) {
    actions.add(action);
    notifyListeners(); // Notifica a los listeners cuando hay una nueva acción
  }
}

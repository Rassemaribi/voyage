import 'package:flutter/material.dart';

class MonTheme extends ChangeNotifier {
  static String _mode = "Jour";

  String getMode() {
    return _mode;
  }

  void setMode(String newMode) {
    _mode = newMode;
    notifyListeners(); // Informer tous les abonnés du changement de mode
  }
}

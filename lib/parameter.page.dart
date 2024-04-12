import 'package:flutter/material.dart';


class ParameterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("parameter"),
        backgroundColor: Colors.green, // Couleur de l'AppBar
      ),
      body: Center(
        child: Text(
          "Contenu de la page de parameter",
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}

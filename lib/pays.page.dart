import 'package:flutter/material.dart';


class paysPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("pays"),
        backgroundColor: Colors.green, // Couleur de l'AppBar
      ),
      body: Center(
        child: Text(
          "Contenu de la page de pays",
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}

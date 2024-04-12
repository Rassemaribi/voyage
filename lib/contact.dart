import 'package:flutter/material.dart';


class ContactPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Contact"),
        backgroundColor: Colors.green, // Couleur de l'AppBar
      ),
      body: Center(
        child: Text(
          "Contenu de la page de contact",
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}

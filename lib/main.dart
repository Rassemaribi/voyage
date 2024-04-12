import 'package:flutter/material.dart';
import 'package:repository/Authentification.dart';
import 'package:repository/Home.dart';
import 'package:repository/contact.dart';
import 'package:repository/gallerie.dart';
import 'package:repository/inscritionPage.dart';
import 'package:repository/meteo.dart';
import 'package:repository/parameter.page.dart';
import 'package:repository/pays.page.dart';
import 'package:shared_preferences/shared_preferences.dart'; // Ajout de l'import pour SharedPreferences

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final routes = {
    '/inscription': (context) => InscriptionPage(),
    '/Auth': (context) => AuthentificationPage(),
    '/contact': (context) => ContactPage(),
    '/gallerie': (context) => GalleriePage(),
    '/parameter': (context) => ParameterPage(),
    '/meteo': (context) => MeteoPage(),
    '/pays': (context) => paysPage(),
    '/home': (context) => Home(),
  };

  // Ceci est la racine de votre application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: routes,
      debugShowCheckedModeBanner: false,
      home: FutureBuilder(
        future: SharedPreferences.getInstance(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            bool conn = snapshot.data?.getBool('connecte') ?? false;
            if (conn)
              return Home();
            else
              return AuthentificationPage();
          }
          // Retourne une page de chargement ou une autre indication de chargement
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(), // Indicateur de chargement
            ),
          );
        },
      ),
    );
  }
}

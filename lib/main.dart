import 'package:flutter/material.dart';
import 'package:repository/Authentification.dart';
import 'package:repository/Home.dart';
import 'package:repository/contact.dart';
import 'package:repository/gallerie.dart';
import 'package:repository/inscritionPage.dart'; // Assurez-vous d'importer correctement le fichier InscriptionPage.dart
import 'package:repository/meteo.dart';
import 'package:repository/parameter.page.dart';
import 'package:repository/pays.page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  // Récupérer le mode à partir de Firebase
  final DatabaseReference modeRef = FirebaseDatabase.instance.reference().child('mode');
  String mode = 'Jour'; // Valeur par défaut

  try {
    DataSnapshot snapshot = await modeRef.once() as DataSnapshot;
    if (snapshot.value != null) {
      mode = snapshot.value.toString();
    } else {
      print('La valeur récupérée de Firebase est nulle.');
      // Vous pouvez attribuer une valeur par défaut différente ici si nécessaire
    }
  } catch (e) {
    print('Erreur lors de la récupération du mode : $e');
  }

  // Passer le mode à l'application MyApp
  runApp(MyApp(mode: mode));
}

class MyApp extends StatelessWidget {
  final String mode;

  MyApp({required this.mode});

  final routes = {
    '/inscription': (context) => InscriptionPage(),
    '/Auth': (context) => AuthentificationPage(),
    '/contact': (context) => ContactPage(),
    '/gallerie': (context) => GalleriePage(),
    '/parameter': (context) => ParameterPage(),
    '/meteo': (context) => MeteoPage(),
    '/pays': (context) => PaysPage(),
    '/home': (context) => Home(),
  };

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: routes,
      debugShowCheckedModeBanner: false,
      theme: mode == 'Jour' ? ThemeData.light() : ThemeData.dark(),
      home: AuthentificationPage(),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'mydawer/MyDrawer.dart'; // Assurez-vous que le chemin vers MyDrawer est correct

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawer(),
      appBar: AppBar(
        title: Text(
          "Accueil",
          style: TextStyle(fontWeight: FontWeight.w800, color: Colors.white),
        ),
        centerTitle: true, // Centrer le titre
        backgroundColor: Colors.green,
      ),
      body: Container( // Container pour ajouter un arrière-plan
        decoration: BoxDecoration( // Décoration pour l'arrière-plan
          image: DecorationImage(
            image: AssetImage('image/background.jpg'), // Image d'arrière-plan
            fit: BoxFit.cover, // Ajuster l'image pour remplir tout l'espace disponible
            colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.2), BlendMode.dstATop), // Rendre l'image transparente
          ),
        ),
        child: Center(
          child: Wrap(
            spacing: 20, // Espacement horizontal entre les éléments
            runSpacing: 20, // Espacement vertical entre les éléments
            children: [
              InkWell(
                child: Ink.image(
                  height: 180,
                  width: 180,
                  image: AssetImage('image/meteo.png'),
                ),
                onTap: () {
                  Navigator.pushNamed(context, '/meteo');
                },
              ),
              InkWell(
                child: Ink.image(
                  height: 180,
                  width: 180,
                  image: AssetImage('image/gallerie.png'),
                ),
                onTap: () {
                  Navigator.pushNamed(context, '/gallerie');
                },
              ),
              InkWell(
                child: Ink.image(
                  height: 180,
                  width: 180,
                  image: AssetImage('image/pays.png'),
                ),
                onTap: () {
                  Navigator.pushNamed(context, '/pays');
                },
              ),
              InkWell(
                child: Ink.image(
                  height: 180,
                  width: 180,
                  image: AssetImage('image/contact.png'),
                ),
                onTap: () {
                  Navigator.pushNamed(context, '/contact');
                },
              ),
              InkWell(
                child: Ink.image(
                  height: 180,
                  width: 180,
                  image: AssetImage('image/parametres.png'),
                ),
                onTap: () {
                  Navigator.pushNamed(context, '/parameter');
                },
              ),
              InkWell(
                child: Ink.image(
                  height: 180,
                  width: 180,
                  image: AssetImage('image/deconnexion.png'),
                ),
                onTap: () {
                  Navigator.pushNamed(context, '/inscription');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

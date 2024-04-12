import 'package:flutter/material.dart';

import 'meteo-details.page.dart';
import 'mydawer/MyDrawer.dart';

class MeteoPage extends StatelessWidget {
  final TextEditingController txt_ville = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawer(),
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text("Météo",style: TextStyle(fontWeight: FontWeight.w800, color: Colors.white),),
        backgroundColor: Colors.green,
      ),
      body: Container(
        decoration: BoxDecoration( // Décoration pour l'arrière-plan
          image: DecorationImage(
            image: AssetImage('image/background.jpg'), // Image d'arrière-plan
            fit: BoxFit.cover, // Ajuster l'image pour remplir tout l'espace disponible
            colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.2), BlendMode.dstATop), // Rendre l'image transparente
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Champ de texte avec icône de ville
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: TextField(
                  controller: txt_ville,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.location_city),
                    hintText: "Entrez le nom de la ville",
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              SizedBox(height: 30),
              // Bouton de recherche
              ElevatedButton(
                onPressed: () {
                  _onGetMeteoDetails(context);
                },
                child: Text("Rechercher",style: TextStyle(fontWeight:FontWeight.w800,color: Colors.green,),),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 15, horizontal: 100),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onGetMeteoDetails(BuildContext context) {
    String ville = txt_ville.text;
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MeteoDetailsPage(ville),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:repository/Page%20Gallerie-Details.dart';

import 'mydawer/MyDrawer.dart';

class GalleriePage extends StatelessWidget {
  final TextEditingController txt_image = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Gallerie",style: TextStyle(fontWeight: FontWeight.w800, color: Colors.white),),
        backgroundColor: Colors.green, // Couleur de l'AppBar
      ),
      drawer: MyDrawer(),
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
                  controller: txt_image,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.photo),
                    hintText: "Entrez le nom de l'image",
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              SizedBox(height: 30),
              // Bouton de recherche
              ElevatedButton(
                onPressed: () {
                  _onGetImageDetails(context);
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

  void _onGetImageDetails(BuildContext context) {
    String image = txt_image.text;
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => GallerieDetailsPage(image),
      ),
    );
  }
}
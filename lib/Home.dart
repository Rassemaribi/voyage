import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'mydawer/MyDrawer.dart'; // Assurez-vous que le chemin vers MyDrawer est correct

class Home extends StatelessWidget {
  Future<String?> getEmail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('email');
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String?>(
      future: getEmail(),
      builder: (BuildContext context, AsyncSnapshot<String?> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Erreur: ${snapshot.error}'));
        } else {
          String? userEmail = snapshot.data;
          return Scaffold(
            drawer: MyDrawer(),
            appBar: AppBar(
              title: Text(
                "Accueil",
                style: TextStyle(fontWeight: FontWeight.w800, color: Colors.white),
              ),
              centerTitle: true,
              backgroundColor: Colors.green,

            ),
            body: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('image/background.jpg'),
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(
                      Colors.black.withOpacity(0.2), BlendMode.dstATop),
                ),
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Email: ${userEmail ?? ''}',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 20),
                    Wrap(
                      spacing: 20,
                      runSpacing: 20,
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
                            Navigator.pushNamed(context, '/Auth');
                          },
                        ),
                      ],
                    ),
                    // Ajoutez les autres InkWell pour les fonctionnalités supplémentaires...
                  ],
                ),
              ),
            ),
          );
        }
      },
    );
  }
}
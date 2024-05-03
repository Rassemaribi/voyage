import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthentificationPage extends StatelessWidget {
  TextEditingController txt_login = TextEditingController();
  TextEditingController txt_password = TextEditingController();

  Future<void> _onAuthentifier(BuildContext context) async {
    try {
      // Authentification de l'utilisateur avec Firebase
      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: txt_login.text,
        password: txt_password.text,
      );

      // Vérification de la connexion réussie
      if (userCredential.user != null) {
        // Récupération de l'e-mail de l'utilisateur
        String email = userCredential.user!.email ?? '';

        // Enregistrement de l'e-mail dans les SharedPreferences
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('email', email);

        // Redirection vers la page Home avec l'e-mail de l'utilisateur
        Navigator.pushReplacementNamed(context, '/home', arguments: {'email': email});
      } else {
        // Gestion des erreurs si l'utilisateur n'est pas connecté
        print("Utilisateur non connecté");
      }
    } catch (e) {
      // Gestion des erreurs d'authentification
      print("Erreur lors de l'authentification : $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Veuillez vérifier votre identifiant et mot de passe'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            "Authentification",
            style: TextStyle(fontWeight: FontWeight.w800, color: Colors.white),
          ),
        ),
        backgroundColor: Colors.green,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: EdgeInsets.symmetric(vertical: 20),
              decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.ad_units_outlined,
                    size: 80,
                    color: Colors.white,
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Login",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            TextFormField(
              controller: txt_login,
              decoration: InputDecoration(
                labelText: "Identifiant",
                prefixIcon: Icon(Icons.person),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            SizedBox(height: 20),
            TextFormField(
              controller: txt_password,
              obscureText: true,
              decoration: InputDecoration(
                labelText: "Mot de passe",
                prefixIcon: Icon(Icons.lock),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _onAuthentifier(context);
              },
              child: Text(
                "Connexion",
                style: TextStyle(fontWeight: FontWeight.w800, color: Colors.green),
              ),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            SizedBox(height: 10),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/inscription');
              },
              child: Text(
                "Nouvel Utilisateur",
                style: TextStyle(fontWeight: FontWeight.w800, color: Colors.green),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

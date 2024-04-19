import 'package:flutter/material.dart';
import 'meteo-details.page.dart';
import 'mydawer/MyDrawer.dart';


class MeteoPage extends StatelessWidget {
  final TextEditingController txtVille = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawer(),
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(
          "Météo",
          style: TextStyle(fontWeight: FontWeight.w800, color: Colors.white),
        ),
        backgroundColor: Colors.green,
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('image/background.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              Colors.black.withOpacity(0.2),
              BlendMode.dstATop,
            ),
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Column(
                  children: [
                    Icon(
                      Icons.maps_home_work_outlined,
                      size: 80,
                      color: Colors.grey,
                    ),
                    SizedBox(height: 10),
                    Text(
                      "Rechercher Une Ville",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                      ),
                    ),
                    SizedBox(height: 10),
                    TextField(
                      controller: txtVille,
                      style: TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                        labelText: "Entrez le nom de la ville",
                        prefixIcon: Icon(
                          Icons.location_city,
                          color: Colors.grey,
                        ),
                        hintStyle: TextStyle(color: Colors.grey),
                        border: OutlineInputBorder(),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.green),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  _onGetMeteoDetails(context);
                },
                child: Text(
                  "Rechercher",
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                    color: Colors.green,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
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
    String ville = txtVille.text;
    if (ville.isNotEmpty) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => MeteoDetailsPage(ville),
        ),
      );
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Error"),
            content: Text("entre le nom de la ville"),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("OK"),
              ),
            ],
          );
        },
      );
    }
  }
}

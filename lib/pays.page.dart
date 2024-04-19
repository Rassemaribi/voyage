import 'package:flutter/material.dart';
import 'package:repository/pays-details.page.dart';

class PaysPage extends StatelessWidget {
  final TextEditingController txt_nomPays = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Pays",
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
                Colors.black.withOpacity(0.2), BlendMode.dstATop),
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    SizedBox(height: 20),
                    Icon(
                      Icons.flag,
                      size: 80,
                      color: Colors.grey,
                    ),
                    SizedBox(height: 10),
                    Text(
                      "Rechercher un Pays",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: txt_nomPays,
                style: TextStyle(color: Colors.black),
                decoration: InputDecoration(
                  labelText: "Entrez le nom du pays",
                  prefixIcon: Icon(Icons.location_on, color: Colors.grey),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  labelStyle: TextStyle(color: Colors.green),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  _onGetPaysDetails(context);
                },
                child: Text(
                  "Rechercher",
                  style: TextStyle(
                      fontWeight: FontWeight.w800, color: Colors.green),
                ),
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

  void _onGetPaysDetails(BuildContext context) {
    String nomPays = txt_nomPays.text;
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>PaysDetailsPage(nomPays),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Page Gallerie-Details.dart';
import 'mydawer/MyDrawer.dart';

class GalleriePage extends StatelessWidget {
  final TextEditingController txt_ville = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Gallerie",
          style: TextStyle(fontWeight: FontWeight.w800, color: Colors.white),
        ),
        backgroundColor: Colors.green,
      ),
      drawer: MyDrawer(),
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
                      Icons.image_search,
                      size: 80,
                      color: Colors.grey,
                    ),
                    SizedBox(height: 10),
                    Text(
                      "Rechercher Une Image",
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
                controller: txt_ville,
                style: TextStyle(color: Colors.black),
                decoration: InputDecoration(
                  labelText: "Entrez le nom de la ville",
                  prefixIcon: Icon(Icons.photo, color: Colors.grey),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  labelStyle: TextStyle(color: Colors.green),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  _onGetImageDetails(context);
                },
                child: Text(
                  "Rechercher",
                  style: TextStyle(fontWeight: FontWeight.w800, color: Colors.green),
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

  void _onGetImageDetails(BuildContext context) {
    String image = txt_ville.text;
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => GallerieDetailsPage(image),
      ),
    );
  }
}

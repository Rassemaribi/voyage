import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'dart:convert';

import 'mydawer/MyDrawer.dart';

class MeteoDetailsPage extends StatefulWidget {
  final String ville;

  MeteoDetailsPage(this.ville);

  @override
  _MeteoDetailsPageState createState() => _MeteoDetailsPageState();
}

class _MeteoDetailsPageState extends State<MeteoDetailsPage> {
  var meteoData;

  @override
  void initState() {
    super.initState();
    getMeteoData(widget.ville);
  }

  void getMeteoData(String ville) {
    String apiKey = 'c109c07bc4df77a88c923e6407aef864';
    String apiUrl = 'https://api.openweathermap.org/data/2.5/forecast?q=$ville&appid=$apiKey';

    http.get(Uri.parse(apiUrl)).then((response) {
      setState(() {
        meteoData = json.decode(response.body);
      });
      print(meteoData);
    }).catchError((error) {
      print('Erreur lors de la récupération des données météorologiques: $error');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawer(),
      appBar: AppBar(
        title: Text("Détails de la météo pour ${widget.ville}",style: TextStyle(fontWeight: FontWeight.w800, color: Colors.white),),
        backgroundColor: Colors.green,
      ),
      body: meteoData == null?
      Center (
          child: CircularProgressIndicator()):
        ListView.builder(
        itemCount: meteoData['list'].length,
        itemBuilder: (context, index) {
          var forecast = meteoData['list'][index];
          var date = DateTime.fromMillisecondsSinceEpoch(forecast['dt'] * 1000);
          var temperature = forecast['main']['temp'];
          var weatherDescription = forecast['weather'][0]['main'].toString().toLowerCase();
          var time = DateFormat.jm().format(date);

          return Card(
            color: Colors.green,
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.white, Colors.green],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              child: ListTile(
                leading: CircleAvatar(
                  backgroundImage: AssetImage("image/$weatherDescription.png"),
                ),
                title: Text(
                  "Date: ${DateFormat('E-dd/MM/yyyy').format(date)}",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Heure: $time",
                      style: TextStyle(
                        fontSize: 18,fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "Température: ${(temperature -273).toStringAsFixed(1)} °C",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "État: $weatherDescription",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.lightBlue[50],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      )

    );
  }
}

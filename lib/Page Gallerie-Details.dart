import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class GallerieDetailsPage extends StatefulWidget {
  final String keyword;

  GallerieDetailsPage(this.keyword);

  @override
  _GallerieDetailsPageState createState() => _GallerieDetailsPageState();
}

class _GallerieDetailsPageState extends State<GallerieDetailsPage> {
  int currentPage = 1;
  int size = 10;
  int totalPages = 0; 
  late ScrollController _scrollController;
  List<dynamic> hits = [];
  var galleryData;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    getGalleryData(widget.keyword);
    _scrollController.addListener(() {
      if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
        if (currentPage < totalPages) {
          currentPage++;
          getGalleryData(widget.keyword);
        }
      }
    });
  }

  void getGalleryData(String keyword) async {
    String apiKey = '15646595-375eb91b3408e352760ee72c8';
    String url = "https://pixabay.com/api/?key=$apiKey&q=$keyword&page=$currentPage&per_page=$size";

    http.Response response = await http.get(Uri.parse(url));

    setState(() {
      galleryData = json.decode(response.body);
      hits.addAll(galleryData['hits']);
      totalPages = (galleryData['totalHits'] / size).ceil();
    });
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(totalPages == 0 ? 'Pas de résultats' : '${widget.keyword}, Page $currentPage / $totalPages', style: TextStyle(fontWeight: FontWeight.w800, color: Colors.white),),
        backgroundColor: Colors.green,
      ),
      backgroundColor: Colors.green[50],
      body: galleryData == null
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
        itemCount: hits.length,
        controller: _scrollController,
        itemBuilder: (context, index) {
          return Column(
            children: [
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                margin: EdgeInsets.symmetric(vertical: 6, horizontal: 10),
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Text(
                  hits[index]['tags'],
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Container(
                child: Card(
                  child: Image.network(
                    hits[index]['webformatURL'],
                    fit: BoxFit.fitWidth,
                  ),
                ),
                padding: EdgeInsets.all(10),
              ),
              SizedBox(height: 10),
            ],
          );
        },
      ),
    );
  }
}

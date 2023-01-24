import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:my_new_app_01/models/Gif.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late Future<List<Gif>> _listadoGifs;

  Future<List<Gif>> _getGifs() async {
    final response = await http.get(Uri.parse(
        "https://api.giphy.com/v1/gifs/trending?api_key=lIFGqBwUHdNuoaP7aMpPyGHKH9CCcUvW&limit=10&rating=g"));

    List<Gif> gifs = [];
    if (response.statusCode == 200) {
      String body = utf8.decode(response.bodyBytes);
      final jsonData = jsonDecode(body);

      for (var item in jsonData["data"]) {
        gifs.add(Gif(item["title"], item["images"]["original"]["url"]));
      }
      //print(gifs);
      return gifs;
    } else {
      throw Exception("Fallo");
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _listadoGifs = _getGifs();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Material App",
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Material App Bar'),
        ),
        body: FutureBuilder(
          future: _listadoGifs,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              //print(snapshot.data);
              return GridView.count(
                crossAxisCount: 2,
                children: _listGifs(snapshot.data!),
              );
            } else if (snapshot.hasError) {
              //print("error");
              //print(snapshot.error);
              return Text("error");
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }

  List<Widget> _listGifs(List<Gif> data) {
    List<Widget> gifs = [];

    for (var gif in data) {
      gifs.add(Card(
          child: Column(
        children: [
          Expanded(
            child: Image.network(
              gif.url,
              fit: BoxFit.fill,
            ),
          ),
        ],
      )));
    }

    return gifs;
  }
}

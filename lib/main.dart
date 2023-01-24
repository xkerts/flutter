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
  
  Future<List<Gif>> _listadoGifs = [];

  Future<List<Gif>> _getGifs() async{
    final response = await http.get("https://api.giphy.com/v1/gifs/trending?api_key=lIFGqBwUHdNuoaP7aMpPyGHKH9CCcUvW&limit=10&rating=g");
    
    if (response.statusCode == 200){
      print(response.body);
    } else{
      throw Exception("Fallo");
    }
    
  }

  @override
  Widget build(BuildContext context){
    return MaterialApp(
      title: "Material App",
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Material App Bar'),
        ),
        body: Center(
          child: Container(
            child: const Text('Hola mi perro'),
          )
        ),
      ),
    );
  }
}

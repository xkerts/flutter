import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:my_new_app_01/models/Gif.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var userController = TextEditingController();
  var pwdController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  controller: userController,
                  decoration: InputDecoration(labelText: "Username", border: OutlineInputBorder(),suffixIcon: Icon(Icons.person)),
                ),
                SizedBox(height: 15,),
                TextFormField(
                  controller: pwdController,
                  obscureText: true,
                  decoration: InputDecoration(labelText: "Password", border: OutlineInputBorder(),suffixIcon: Icon(Icons.lock)),
                ),
                SizedBox(height: 45,),
                OutlinedButton.icon(onPressed: (){login();}, icon: Icon(Icons.login, size: 18,), label: Text("Login"))
              ],
            )
          )
        ),
      ),
    );
  }

  //Creamos funcion para hacer login 
  Future<void> login() async{
    await http.post(Uri.parse("https://apiadmin.dts-ec.com/api/Auth/Login"), body: ({}));
  }
}
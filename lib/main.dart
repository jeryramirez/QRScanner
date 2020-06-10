import 'package:flutter/material.dart';
import 'package:qrapp/src/pages/home_page.dart';
import 'package:qrapp/src/pages/map_display.dart';
 
void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'QR APP',
      initialRoute: 'home',
      routes: {
        'home' : (BuildContext context) => HomePage(),
        'map' : (BuildContext context) => MapPage()
      },
      theme: ThemeData(
        primaryColor: Colors.cyan
      ),
    );
  }
}
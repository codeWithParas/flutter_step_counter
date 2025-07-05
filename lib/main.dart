import 'package:flutter/material.dart';
import 'package:flutter_ws_tb/LoginScreen.dart';

void main() {
  //runApp(const MyApp());
  runApp(FlutterTbWs());
}

class FlutterTbWs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Online Workshop",
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightBlue),
        useMaterial3: true,
        appBarTheme: AppBarTheme(
          centerTitle: true,
          elevation: 3,
          backgroundColor: Colors.lightBlue
        )
      ),
      home: LoginScreen(),
    );
  }
}

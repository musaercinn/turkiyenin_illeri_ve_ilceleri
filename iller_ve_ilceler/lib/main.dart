import 'package:flutter/material.dart';
import 'package:iller_ve_ilceler/AnaSayfa.dart';

void main() {
  runApp( AnaUygulama());
}
class AnaUygulama extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: AnaSayfa( ),

    );
  }
}


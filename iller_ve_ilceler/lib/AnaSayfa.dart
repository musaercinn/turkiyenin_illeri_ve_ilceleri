import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iller_ve_ilceler/ilce.dart';
import 'package:iller_ve_ilceler/il.dart';

class AnaSayfa extends StatefulWidget {
  @override
  State<AnaSayfa> createState() => _AnaSayfaState();
}

class _AnaSayfaState extends State<AnaSayfa> {
  List<il> iller = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _jsonCozumle();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("İller ve İlçeler",
          style: TextStyle(fontSize: 20),
        ),
        backgroundColor: Colors.red,
      ),
      body: ListView.builder(
        itemBuilder: _listeOgesiniOlustur,
        itemCount: iller.length,),

    );
  }

  void _jsonCozumle() async {
    String jsonString = await rootBundle.loadString(
        "assets/iller_ilceler.json");
    Map<String, dynamic> illerMap = jsonDecode(jsonString);

    for (String plakaKodu in illerMap.keys) {
      Map<String, dynamic> ilMap = illerMap[plakaKodu];
      String ilIsmi = ilMap["name"];
      Map<String, dynamic> ilcelerMap = ilMap["districts"];

      List<ilce> tumIlceler = [];
      for (String ilceKodu in ilcelerMap.keys) {
        Map<String, dynamic> ilcemap = ilcelerMap[ilceKodu];
        String ilceIsmi = ilcemap["name"];
        ilce Ilce = ilce(ilceIsmi);
        tumIlceler.add(Ilce);
      }
      il Il = il(ilIsmi, plakaKodu, tumIlceler);
      iller.add(Il);
    }
    setState(() {

    });
  }

  Widget _listeOgesiniOlustur(BuildContext context, int index) {
    return Card(
      child: ExpansionTile(
        title: Text(iller[index].isim),
        leading: Icon(Icons.location_city),
        trailing: Text(iller[index].plakaKodu),
        children: iller[index].ilceler.map((ilce) {
          return ListTile(
            title: Text(ilce.isim),
          );
        }).toList(),

      ),
    );
  }
}

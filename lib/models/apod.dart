import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

const TextStyle titleStyle = TextStyle(
    fontFamily: 'Play',
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: Colors.white);

const TextStyle autorStyle =
    TextStyle(fontFamily: 'Sometype_Mono', fontSize: 16, color: Colors.white70);

const TextStyle infoStyle = TextStyle(fontFamily: 'Inter', color: Colors.white);

class APOD {
  String title;
  String url;
  String explanation;
  String type;
  String date;
  String? thumbs;
  String? copyright;

  APOD.fromJson(Map<String, dynamic> json)
      : title = json["title"],
        url = json["url"],
        explanation = json["explanation"],
        type = json["media_type"],
        date = json["date"],
        thumbs = json["thumbs"],
        copyright = json["copyright"];
}

Future<APOD> loadAPOD(String? date) async {
  final response = await http.get(Uri.parse(
      "https://api.nasa.gov/planetary/apod?api_key=TTuFJw8ydRLpqdI02MWSXGy2Xe25vg4IWdtkMRmm&date=$date"));
  final json = jsonDecode(response.body);
  APOD day = APOD.fromJson(json);

  return day;
}

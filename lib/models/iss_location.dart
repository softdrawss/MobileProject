import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

const TextStyle titleStyle = TextStyle(
    fontFamily: 'Play',
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: Colors.white);

const TextStyle infoStyle = TextStyle(
    fontFamily: 'Inter',
    fontStyle: FontStyle.italic,
    color: Colors.white,
    fontWeight: FontWeight.w600);

class ISSLocation {
  num timestamp;
  String longitude;
  String latitude;

  ISSLocation.fromJson(Map<String, dynamic> json)
      : timestamp = json["timestamp"],
        longitude = json["iss_position"]["longitude"],
        latitude = json["iss_position"]["latitude"];
}

Future<ISSLocation> loadISSLocation() async {
  final response = await http.get(
    Uri.parse("http://api.open-notify.org/iss-now.json"),
  );
  final json = jsonDecode(response.body);
  ISSLocation issLocation = ISSLocation.fromJson(json);
  return issLocation;
}

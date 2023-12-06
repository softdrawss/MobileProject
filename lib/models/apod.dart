import 'dart:convert';

import 'package:http/http.dart' as http;

class APOD {
  String title;
  String url;
  String explanation;
  String type;
  String? copyright;

  APOD.fromJson(Map<String, dynamic> json)
  : title = json["title"],
  url = json["url"],
  explanation = json["explanation"],
  type = json["media_type"],
  copyright = json["copyright"];
}

Future<APOD> loadAPOD() async {
  final response = await http.get(
    Uri.parse("https://api.nasa.gov/planetary/apod?api_key=TTuFJw8ydRLpqdI02MWSXGy2Xe25vg4IWdtkMRmm"),
  );
  final json = jsonDecode(response.body);
  APOD today = APOD.fromJson(json);

  return today;
}
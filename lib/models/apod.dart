import 'dart:convert';

import 'package:http/http.dart' as http;

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

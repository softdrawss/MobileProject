import 'dart:convert';
import 'package:http/http.dart' as http;

class Body {
  String id;
  String name;
  String bodyType;
  num gravity;
  num semimajorAxis;
  num inclination;
  num massValue, volValue;
  num massExponent, volExponent;
  num density;
  num meanRadius;
  num sideralOrbit;
  num sideralRotation;
  num axialTilt;
  num avgTemp;
  String? discoveredBy;
  String? discoveryDate;
  String? alternativeName;

  Body.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        name = json["englishName"],
        bodyType = json["bodyType"],
        gravity = json["gravity"],
        semimajorAxis = json["semimajorAxis"],
        inclination = json["inclination"],

        massValue = json["mass"]["massValue"],
        massExponent = json["mass"]["massExponent"],
        volValue = json["vol"]["volValue"],
        volExponent = json["vol"]["volExponent"],
        
        density = json["density"],
        meanRadius = json["meanRadius"],
        sideralOrbit = json["sideralOrbit"],
        sideralRotation = json["sideralRotation"],
        axialTilt = json["axialTilt"],
        avgTemp = json["avgTemp"],
        discoveredBy = json["discoveredBy"],
        discoveryDate = json["discoveryDate"],
        alternativeName = json["alternativeName"];
}


Future<Body> loadBody(String id) async {
  final response = await http.get(
    Uri.parse("https://api.le-systeme-solaire.net/rest/bodies/$id"),
  );
  final json = jsonDecode(response.body);
  /*
  final jsonUserList = json["results"];
  List<Body> userList = [];
  for (final jsonUser in jsonUserList) {
    userList.add(Body.fromJson(jsonUser));
  }*/

  Body body = Body.fromJson(json);
  return body;
}

Future<Body> loadBodyURL(String url) async {
  final response = await http.get(
    Uri.parse(url),
  );
  final json = jsonDecode(response.body);
  /*
  final jsonUserList = json["results"];
  List<Body> userList = [];
  for (final jsonUser in jsonUserList) {
    userList.add(Body.fromJson(jsonUser));
  }*/

  Body body = Body.fromJson(json);
  return body;
}
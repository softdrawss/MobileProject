import 'dart:convert';
import 'package:http/http.dart' as http;

class Moon {
  String id;
  String url;

  Moon.fromJson(Map<String, dynamic> json)
      : id = json["moon"],
        url = json["rel"];
}

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

  List<Moon> moons;

  Body.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        name = json["englishName"],
        bodyType = json["bodyType"],
        gravity = json["gravity"],
        semimajorAxis = json["semimajorAxis"],
        inclination = json["inclination"],

        // Check if "mass" and "volume" are not null before accessing its properties
        massValue = json["mass"] != null ? json["mass"]["massValue"] : 0,
        massExponent = json["mass"] != null ? json["mass"]["massExponent"] : 0,
        volValue = json["vol"] != null ? json["vol"]["volValue"] : 0,
        volExponent = json["vol"] != null ? json["vol"]["volExponent"] : 0,

        density = json["density"],
        meanRadius = json["meanRadius"],
        sideralOrbit = json["sideralOrbit"],
        sideralRotation = json["sideralRotation"],
        axialTilt = json["axialTilt"],
        avgTemp = json["avgTemp"],
        discoveredBy = json["discoveredBy"],
        discoveryDate = json["discoveryDate"],
        alternativeName = json["alternativeName"],

        moons = List<Moon>.from((json["moons"] ?? [])
            .map((moonJson) => Moon.fromJson(moonJson)));
}

Future<Body> loadBody(String id) async {
  final response = await http.get(
    Uri.parse("https://api.le-systeme-solaire.net/rest/bodies/$id"),
  );
  final json = jsonDecode(response.body);

  Body body = Body.fromJson(json);
  return body;
}

Future<Body> loadBodyURL(String url) async {
  final response = await http.get(
    Uri.parse(url),
  );
  final json = jsonDecode(response.body);

  Body body = Body.fromJson(json);
  return body;
}
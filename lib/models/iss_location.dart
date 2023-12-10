import 'dart:convert';
import 'package:http/http.dart' as http;

class ISSLocation {
  String longitude;
  String latitude;

  ISSLocation.fromJson(Map<String, dynamic> json)
      : longitude = json["iss_position"]["longitude"],
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

import 'dart:convert';
import 'package:http/http.dart' as http;

class ListedBody {
  String id;
  String name;
  String? aroundPlanet;
  ListedBody({required this.id, required this.name});
}

Future<List<ListedBody>> loadList(String url) async {
  final response = await http.get(Uri.parse(url));
  final jsonBodyList = jsonDecode(response.body)["bodies"];

  List<ListedBody> bodyList = [];

  for (final jsonBody in jsonBodyList) {
    bodyList.add(ListedBody(id: jsonBody["id"], name: jsonBody["englishName"]));
  }

  return bodyList;
}

Future<List<ListedBody>> loadMoonList(String url, String planetID) async {
  final response = await http.get(Uri.parse(url));
  final jsonBodyList = jsonDecode(response.body)["bodies"];

  List<ListedBody> bodyList = [];

  for (final jsonBody in jsonBodyList) {
    if ((jsonBody["aroundPlanet"]["planet"]) == planetID) {
      bodyList
          .add(ListedBody(id: jsonBody["id"], name: jsonBody["englishName"]));
    }
  }
  return bodyList;
}

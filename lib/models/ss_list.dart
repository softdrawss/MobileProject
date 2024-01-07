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

Future<List<ListedBody>> loadMoonList(String planetID) async {
  final response = await http.get(Uri.parse("https://api.le-systeme-solaire.net/rest.php/bodies?data=id%2CenglishName%2CaroundPlanet%2Cplanet&filter%5B%5D=bodyType%2Ceq%2CMoon"));
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

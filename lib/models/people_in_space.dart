import 'dart:convert';

import 'package:http/http.dart' as http;

class PeopleInSpace {
  String craft;
  String name;

  PeopleInSpace.fromJson(Map<String, dynamic> json)
  : craft = json["craft"],
  name = json["name"];
}

Future<List<PeopleInSpace>> loadPeopleInSpace() async {
  final response = await http.get(
    Uri.parse("http://api.open-notify.org/astros.json"),
  );
    final json = jsonDecode(response.body);
  final jsonPeopleList = json["people"];
  List<PeopleInSpace> peopleList = [];

    for (final jsonPeopleInSpace in jsonPeopleList) {
    peopleList.add(PeopleInSpace.fromJson(jsonPeopleInSpace));
  }
  return peopleList;
}
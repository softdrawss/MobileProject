import 'dart:convert';
import 'package:http/http.dart' as http;

/*
class ListedBody{
  String id;
  String name;
  String url;
  //List.fromJson(Map<String, dynamic> json)
}


Future<Element> loadList(String url) async {
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

  List body = List.fromJson(json);
  return body;
}*/
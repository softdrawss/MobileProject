import 'dart:convert';

import 'package:http/http.dart' as http;

class EPICDates {
  String date;

  EPICDates.fromJson(Map<String, dynamic> json) : date = json["date"];
}

Future<List<EPICDates>> loadEPICDates() async {
  final response = await http.get(
    Uri.parse("https://epic.gsfc.nasa.gov/api/natural/all"),
  );
  final json = jsonDecode(response.body);
  final jsonEPICDatesList = json;
  List<EPICDates> epicDatesList = [];

  for (final jsonEPICDate in jsonEPICDatesList) {
    epicDatesList.add(EPICDates.fromJson(jsonEPICDate));
  }
  return epicDatesList;
}

class EPICData {
  String imageCode;
  String caption;
  double lat;
  double lon;
  double dscovrX, dscovrY, dscovrZ;
  double lunarX, lunarY, lunarZ;
  double sunX, sunY, sunZ;
  String date;
  String image = "";

  EPICData.fromJson(Map<String, dynamic> json)
      : imageCode = json["image"],
        caption = json["caption"],
        lat = json["centroid_coordinates"]["lat"],
        lon = json["centroid_coordinates"]["lon"],
        dscovrX = json["dscovr_j2000_position"]["x"],
        dscovrY = json["dscovr_j2000_position"]["y"],
        dscovrZ = json["dscovr_j2000_position"]["z"],
        lunarX = json["lunar_j2000_position"]["x"],
        lunarY = json["lunar_j2000_position"]["y"],
        lunarZ = json["lunar_j2000_position"]["z"],
        sunX = json["sun_j2000_position"]["x"],
        sunY = json["sun_j2000_position"]["y"],
        sunZ = json["sun_j2000_position"]["z"],
        date = json["date"]{
           String year = date.substring(0, 4);
 String month = date.substring(5, 7);
 String day = date.substring(8, 10); 

 image = "https://epic.gsfc.nasa.gov/archive/natural/$year/$month/$day/png/$imageCode.png";
        }
}

Future<List<EPICData>> loadEPICData(String date) async {
  final response = await http.get(
    Uri.parse("https://epic.gsfc.nasa.gov/api/natural/date/$date"),
  );
  final json = jsonDecode(response.body);

  final jsonEPICDataList = json;
  List<EPICData> epicDataList = [];

  for (final jsonEPICData in jsonEPICDataList) {
    epicDataList.add(EPICData.fromJson(jsonEPICData));
  }
  return epicDataList;
}



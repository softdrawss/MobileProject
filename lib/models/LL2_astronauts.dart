import 'dart:convert';
import 'package:http/http.dart' as http;


class Astronaut {
  final int id;
  final String url;
  final String name;
  final Status status;
  final Type type;
  final bool inSpace;
  final String timeInSpace;
  final String evaTime;
  final int age;
  final String dateOfBirth;
  final String dateOfDeath;
  final String nationality;
  final String bio;
  final String twitter;
  final String instagram;
  final String wiki;
  final Agency agency;
  final String profileImage;
  final String profileImageThumbnail;
  final int flightsCount;
  final int landingsCount;
  final int spacewalksCount;
  final String lastFlight;
  final String firstFlight;

  Astronaut({
    required this.id,
    required this.url,
    required this.name,
    required this.status,
    required this.type,
    required this.inSpace,
    required this.timeInSpace,
    required this.evaTime,
    required this.age,
    required this.dateOfBirth,
    required this.dateOfDeath,
    required this.nationality,
    required this.bio,
    required this.twitter,
    required this.instagram,
    required this.wiki,
    required this.agency,
    required this.profileImage,
    required this.profileImageThumbnail,
    required this.flightsCount,
    required this.landingsCount,
    required this.spacewalksCount,
    required this.lastFlight,
    required this.firstFlight,
  });

  factory Astronaut.fromJson(Map<String, dynamic> json) {
    return Astronaut(
      id: json['id'] ?? 0,
      url: json['url'] ?? '',
      name: json['name'] ?? '',
      status: Status.fromJson(json['status'] ?? {}),
      type: Type.fromJson(json['type'] ?? {}),
      inSpace: json['in_space'] ?? false,
      timeInSpace: json['time_in_space'] ?? '',
      evaTime: json['eva_time'] ?? '',
      age: json['age'] ?? 0,
      dateOfBirth: json['date_of_birth'] ?? '',
      dateOfDeath: json['date_of_death'] ?? '',
      nationality: json['nationality'] ?? '',
      bio: json['bio'] ?? '',
      twitter: json['twitter'] ?? '',
      instagram: json['instagram'] ?? '',
      wiki: json['wiki'] ?? '',
      agency: Agency.fromJson(json['agency'] ?? {}),
      profileImage: json['profile_image'] ?? '',
      profileImageThumbnail: json['profile_image_thumbnail'] ?? '',
      flightsCount: json['flights_count'] ?? 0,
      landingsCount: json['landings_count'] ?? 0,
      spacewalksCount: json['spacewalks_count'] ?? 0,
      lastFlight: json['last_flight'] ?? '',
      firstFlight: json['first_flight'] ?? '',
    );
  }
}

class Status {
  final int id;
  final String name;

  Status({required this.id, required this.name});

  factory Status.fromJson(Map<String, dynamic> json) {
    return Status(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
    );
  }
}

class Type {
  final int id;
  final String name;

  Type({required this.id, required this.name});

  factory Type.fromJson(Map<String, dynamic> json) {
    return Type(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
    );
  }
}

class Agency {
  final int id;
  final String url;
  final String name;
  final bool featured;
  final String type;
  final String countryCode;
  final String abbrev;
  final String description;
  final String administrator;
  final String foundingYear;
  final String launchers;
  final String spacecraft;
  final String parent;
  final String imageUrl;
  final String logoUrl;

  Agency({
    required this.id,
    required this.url,
    required this.name,
    required this.featured,
    required this.type,
    required this.countryCode,
    required this.abbrev,
    required this.description,
    required this.administrator,
    required this.foundingYear,
    required this.launchers,
    required this.spacecraft,
    required this.parent,
    required this.imageUrl,
    required this.logoUrl,
  });

  factory Agency.fromJson(Map<String, dynamic> json) {
    return Agency(
      id: json['id'] ?? 0,
      url: json['url'] ?? '',
      name: json['name'] ?? '',
      featured: json['featured'] ?? false,
      type: json['type'] ?? '',
      countryCode: json['country_code'] ?? '',
      abbrev: json['abbrev'] ?? '',
      description: json['description'] ?? '',
      administrator: json['administrator'] ?? '',
      foundingYear: json['founding_year'] ?? '',
      launchers: json['launchers'] ?? '',
      spacecraft: json['spacecraft'] ?? '',
      parent: json['parent'] ?? '',
      imageUrl: json['image_url'] ?? '',
      logoUrl: json['logo_url'] ?? '',
    );
  }
}

class AstronautResponse {
  final int count;
  final String next;
  final String previous;
  final List<Astronaut> results;

  AstronautResponse({
    required this.count,
    required this.next,
    required this.previous,
    required this.results,
  });

  factory AstronautResponse.fromJson(Map<String, dynamic> json) {
    return AstronautResponse(
      count: json['count'] ?? 0,
      next: json['next'] ?? '',
      previous: json['previous'] ?? '',
      results: (json['results'] as List<dynamic>?)?.map((result) {
        return Astronaut.fromJson(result as Map<String, dynamic>);
      }).toList() ?? [],
    );
  }
}

Future<AstronautResponse> loadAstronauts() async {
  final response = await http.get(
    Uri.parse("https://lldev.thespacedevs.com/2.2.0/astronaut/?limit=200"),
  );

  final json = jsonDecode(response.body);

  return AstronautResponse.fromJson({
    "count": json["count"],
    "next": json["next"],
    "previous": json["previous"],
    "results": json["results"],
  });
}
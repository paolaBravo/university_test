import 'package:university_test/features/domain/entities/university_entity.dart';

class UniversityModel extends UniversityEntity {
  UniversityModel({
    required String alphaTwoCode,
    required List<String> domains,
    required String country,
    required String stateProvince,
    required List<String> webPages,
    required String name,
  }) : super(
            alphaTwoCode: alphaTwoCode,
            domains: domains,
            country: country,
            stateProvince: stateProvince,
            webPages: webPages,
            name: name,
            image: "",
            numberOfStudents: 0);

  factory UniversityModel.fromJson(Map<String, dynamic> json) {
    return UniversityModel(
      alphaTwoCode: json["alpha_two_code"],
      domains: List<String>.from(json["domains"].map((x) => x)),
      country: json["country"],
      stateProvince: json["state-province"] ?? "",
      webPages: List<String>.from(json["web_pages"].map((x) => x)),
      name: json["name"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "alpha_two_code": alphaTwoCode,
      "domains": List<dynamic>.from(domains.map((x) => x)),
      "country": country,
      "state-province": stateProvince,
      "web_pages": List<dynamic>.from(webPages.map((x) => x)),
      "name": name,
    };
  }
}

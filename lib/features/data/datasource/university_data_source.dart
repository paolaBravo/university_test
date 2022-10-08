import 'dart:convert';

import 'package:university_test/core/error/failures.dart';
import 'package:university_test/features/data/models/university_model.dart';
import 'package:http/http.dart' as http;

abstract class UniversityDataSource {
  Future<List<UniversityModel>> getUniversitiesInformation();
}

class UniversityDataSourceImpl implements UniversityDataSource {
  final http.Client client = http.Client();

  @override
  Future<List<UniversityModel>> getUniversitiesInformation() async {
    Uri requestPath = Uri.parse(
        "https://tyba-assets.s3.amazonaws.com/FE-Engineer-test/universities.json");
    final response = await http.get(requestPath);
    List jsonResponse = json.decode(response.body);
    if (response.statusCode == 200) {
      var result =
          jsonResponse.map((coin) => UniversityModel.fromJson(coin)).toList();
      return result;
    } else {
      throw GeneralFailure(jsonResponse.toString());
    }
  }
}

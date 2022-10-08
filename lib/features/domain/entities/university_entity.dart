import 'package:equatable/equatable.dart';

class UniversityEntity extends Equatable {
  final String alphaTwoCode;
  final List<String> domains;
  final String country;
  final String stateProvince;
  final List<String> webPages;
  final String name;
  String image;
  int numberOfStudents;

  UniversityEntity(
      {required this.alphaTwoCode,
      required this.domains,
      required this.country,
      required this.stateProvince,
      required this.webPages,
      required this.name,
      required this.image,
      required this.numberOfStudents});

  @override
  List<Object?> get props => [
        alphaTwoCode,
        domains,
        country,
        stateProvince,
        webPages,
        name,
        image,
        numberOfStudents
      ];
}

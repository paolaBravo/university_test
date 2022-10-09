import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:university_test/dependency_injection/injector.dart';
import 'package:university_test/features/domain/entities/university_entity.dart';
import 'package:university_test/features/domain/usecases/get_universities_information.dart';
import 'dart:io';

enum ViewType { list, grid }

class UniversitiesController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController numOfStudentsController = TextEditingController();
  var type = ViewType.list.obs;
  final getUniversities = Injector.resolve<GetUniversitiesInformation>();
  RxList<UniversityEntity> universities = <UniversityEntity>[].obs;
  Rx<File> image = File("").obs;

  @override
  void onInit() {
    getAllUniversities();
    super.onInit();
  }

  void getAllUniversities() async {
    var response = await getUniversities.call();
    response.fold((l) => null, (r) => universities.assignAll(r));
  }

  void logOut() async {
    await _auth.signOut();
    Get.offAllNamed('/home');
  }

  initNumberOfStudents(UniversityEntity university) {
    if (university.numberOfStudents != 0) {
      numOfStudentsController.text = university.numberOfStudents.toString();
    } else {
      numOfStudentsController.text = "";
    }
  }
}

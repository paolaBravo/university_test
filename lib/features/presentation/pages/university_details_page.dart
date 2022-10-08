import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:university_test/features/domain/entities/university_entity.dart';
import 'package:university_test/features/presentation/controllers/universities_controller.dart';
import 'package:university_test/features/presentation/widgets/button_widget.dart';
import 'package:university_test/features/presentation/widgets/snackbar_error_widget.dart';

class UniversityDetailsPage extends StatelessWidget {
  UniversityDetailsPage({Key? key, required this.university}) : super(key: key);
  final UniversityEntity university;
  final UniversitiesController _controller = Get.put(UniversitiesController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(university.name),
        leading: IconButton(
          icon: GetPlatform.isAndroid
              ? const Icon(Icons.arrow_back)
              : const Icon(Icons.arrow_back_ios),
          onPressed: () {
            _controller.numOfStudentsController.clear();
            Get.back();
          },
        ),
        actions: [
          InkWell(
            child: const Padding(
              padding: EdgeInsets.only(right: 15),
              child: Icon(Icons.logout),
            ),
            onTap: () {
              _controller.logOut();
            },
          ),
        ],
      ),
      body: Container(
        padding:
            const EdgeInsets.only(bottom: 20, left: 20, right: 20, top: 20),
        child: Column(
          children: [
            information(context, "University Name: ", university.name),
            university.stateProvince != ""
                ? information(
                    context, "State or Province: ", university.stateProvince)
                : const SizedBox(),
            information(context, "Country: ",
                university.country + " (${university.alphaTwoCode})"),
            numOfStudens(context),
            saveButton(context)
          ],
        ),
      ),
    );
  }

  Widget information(
      BuildContext context, String informationText1, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Text.rich(
        TextSpan(
          text: informationText1,
          style: Theme.of(context).textTheme.bodyText1,
          children: <TextSpan>[
            TextSpan(
              text: value,
              style: Theme.of(context).textTheme.bodyText2,
            ),
          ],
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget numOfStudens(BuildContext context) {
    if (university.numberOfStudents == 0) {
      return Column(
        children: [
          Text(
            "Enter the number of students at the university",
            style: Theme.of(context).textTheme.bodyText1,
          ),
          TextField(
            style: Theme.of(context).textTheme.caption,
            controller: _controller.numOfStudentsController,
            keyboardType: TextInputType.number,
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.digitsOnly
            ],
          )
        ],
      );
    } else {
      return information(context, "Number of students at the university: ",
          university.numberOfStudents.toString());
    }
  }

  Widget saveButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: ButtonWidget(
        text: "SAVE INFORMATION",
        onTap: () {
          if (_controller.numOfStudentsController.text != "") {
            if (_controller.numOfStudentsController.text == "0") {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  behavior: SnackBarBehavior.floating,
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  content: SnackbarErrorWidget(
                      textError:
                          "The number of students must be greater than zero"),
                ),
              );
            } else {
              university.numberOfStudents =
                  int.parse(_controller.numOfStudentsController.text);
              _controller.numOfStudentsController.clear();
              Get.back();
            }
          } else {
            Get.back();
          }
        },
      ),
    );
  }
}

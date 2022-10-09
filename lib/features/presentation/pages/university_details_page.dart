import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
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
    _controller.initNumberOfStudents(university);
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
            showImage(),
            information(context, "University Name: ", university.name),
            university.stateProvince != ""
                ? information(
                    context, "State or Province: ", university.stateProvince)
                : const SizedBox(),
            information(context, "Country: ",
                university.country + " (${university.alphaTwoCode})"),
            numOfStudens(context),
            imageButtons(context),
          ],
        ),
      ),
    );
  }

  Widget showImage() {
    return Obx(
      () {
        return _controller.image.value.path != "" && university.image != ""
            ? SizedBox(
                height: Get.height * 0.2,
                width: Get.width * 0.5,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(100.0),
                  child: Image.file(
                    File(university.image),
                    fit: BoxFit.fill,
                  ),
                ),
              )
            : const SizedBox();
      },
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
          onSubmitted: (val) {
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
              }
            }
          },
        )
      ],
    );
  }

  Widget imageFromGalleryButton(BuildContext context) {
    return ButtonWidget(
        onTap: () {
          pickImage(context, ImageSource.gallery);
        },
        text: "UPLOAD IMAGE FROM GALLERY");
  }

  Widget imageFromCameraButton(BuildContext context) {
    return ButtonWidget(
        onTap: () {
          pickImage(context, ImageSource.camera);
        },
        text: "UPLOAD IMAGE FROM CAMERA");
  }

  pickImage(BuildContext context, ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);

      if (image != null) {
        university.image = image.path;
        _controller.image.value = File(university.image);
      }

      _controller.universities.refresh();
    } on PlatformException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.transparent,
          elevation: 0,
          content: SnackbarErrorWidget(textError: "Failed to pick image"),
        ),
      );
    }
  }

  Widget imageButtons(BuildContext context) {
    return Column(
      children: [
        imageFromGalleryButton(context),
        imageFromCameraButton(context)
      ],
    );
  }
}

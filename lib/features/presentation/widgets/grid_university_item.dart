import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:university_test/features/domain/entities/university_entity.dart';
import 'package:university_test/features/presentation/pages/university_details_page.dart';

class GridUniversityItem extends StatelessWidget {
  const GridUniversityItem({Key? key, required this.university})
      : super(key: key);
  final UniversityEntity university;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Get.to(
        () => UniversityDetailsPage(
          university: university,
        ),
      ),
      child: Card(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                university.name,
                style: Theme.of(context).textTheme.bodyText1,
                textAlign: TextAlign.center,
              ),
              Text(
                university.country,
                style: Theme.of(context).textTheme.bodyText2,
              )
            ],
          ),
        ),
      ),
    );
  }
}

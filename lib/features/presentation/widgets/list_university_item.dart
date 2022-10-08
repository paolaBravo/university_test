import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:university_test/features/domain/entities/university_entity.dart';
import 'package:university_test/features/presentation/pages/university_details_page.dart';

class ListUniversityItem extends StatelessWidget {
  const ListUniversityItem({Key? key, required this.university})
      : super(key: key);
  final UniversityEntity university;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: ListTile(
        onTap: () => Get.to(
          () => UniversityDetailsPage(
            university: university,
          ),
        ),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 10,
        ),
        title: Row(
          children: [
            Flexible(
              child: Text(
                university.name,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.bodyText1,
              ),
            ),
          ],
        ),
        subtitle: Text(
          university.country,
        ),
      ),
    );
  }
}

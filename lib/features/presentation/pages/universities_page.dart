import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:university_test/features/presentation/controllers/universities_controller.dart';
import 'package:university_test/features/presentation/widgets/grid_university_item.dart';
import 'package:university_test/features/presentation/widgets/list_university_item.dart';

class UniversitiesPage extends StatelessWidget {
  final UniversitiesController _controller = Get.put(UniversitiesController());
  UniversitiesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('UNIVERSITIES'),
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
        padding: const EdgeInsets.only(bottom: 20, left: 20, right: 20),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Universities info",
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                Obx(
                  () => IconButton(
                    onPressed: () {
                      if (_controller.type.value == ViewType.list) {
                        _controller.type.value = ViewType.grid;
                      } else {
                        _controller.type.value = ViewType.list;
                      }
                    },
                    icon: Icon(_controller.type.value == ViewType.list
                        ? Icons.view_list_rounded
                        : Icons.grid_on),
                  ),
                ),
              ],
            ),
            viewBuilder()
          ],
        ),
      ),
    );
  }

  Widget viewBuilder() {
    return Obx(
      (() {
        if (_controller.type.value == ViewType.list) {
          return listViewUniversities();
        } else {
          return gridViewUniversities();
        }
      }),
    );
  }

  Widget gridViewUniversities() {
    return Expanded(
      child: GridView.builder(
        gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemCount: _controller.universities.length,
        itemBuilder: (context, index) {
          return GridUniversityItem(
            university: _controller.universities[index],
          );
        },
      ),
    );
  }

  Widget listViewUniversities() {
    return Expanded(
      child: ListView.builder(
        itemCount: _controller.universities.length,
        itemBuilder: (context, index) {
          return ListUniversityItem(
            university: _controller.universities[index],
          );
        },
      ),
    );
  }
}

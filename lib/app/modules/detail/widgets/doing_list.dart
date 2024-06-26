import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:task_app/app/core/utils/extensions.dart';
import 'package:task_app/app/modules/home/controller.dart';

class DoingList extends StatelessWidget {
  final homeCtrl = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() => homeCtrl.doingTodos.isEmpty && homeCtrl.doneTodos.isEmpty
        ? Column(
            children: [
              Image.asset(
                'assets/images/task.png',
                fit: BoxFit.cover,
                width: 65.0.wp,
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                'Add Task',
                style:
                    TextStyle(fontWeight: FontWeight.bold, fontSize: 14.0.sp),
              )
            ],
          )
        : ListView(
            shrinkWrap: true,
            physics: const ClampingScrollPhysics(),
            children: [
              ...homeCtrl.doingTodos
                  .map((element) => Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: 3.0.wp, horizontal: 7.0.wp),
                        child: Row(
                          children: [
                            SizedBox(
                              width: 20,
                              height: 20,
                              child: Checkbox(
                                value: element['done'],
                                fillColor: MaterialStateProperty.resolveWith(
                                  (states) => Colors.grey[400],
                                ),
                                onChanged: (value) {
                                  homeCtrl.doneTodo(element['title']);
                                },
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 4.0.wp),
                              child: Text(
                                element['title'],
                                overflow: TextOverflow.ellipsis,
                              ),
                            )
                          ],
                        ),
                      ))
                  .toList(),
              if (homeCtrl.doingTodos.isNotEmpty)
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5.0.wp),
                  child: Divider(
                    thickness: 2,
                  ),
                )
            ],
          ));
  }
}

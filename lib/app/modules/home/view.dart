import 'dart:html';
import 'dart:js_interop';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:task_app/app/data/models/task.dart';
import 'package:task_app/app/modules/home/controller.dart';
import 'package:task_app/app/core/utils/extensions.dart';
import 'package:task_app/app/widgets/add_card.dart';
import 'package:task_app/app/widgets/task_card.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: ListView(
        children: [
          Padding(
            padding: EdgeInsets.all(4.0.wp),
            child: Text(
              'My list',
              style: TextStyle(fontSize: 24.0.sp, fontWeight: FontWeight.bold),
            ),
          ),
          Obx(
            () => GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: const ClampingScrollPhysics(),
              children: [
                ...controller.tasks
                    .map((element) => LongPressDraggable(
                        data: element,
                        onDragStarted: () => controller.ChangeDeleting(true),
                        onDraggableCanceled: (_, __) =>
                            controller.ChangeDeleting(false),
                        onDragEnd: (_) => controller.ChangeDeleting(false),
                        feedback: Opacity(
                          opacity: 0.8,
                          child: TaskCard(task: element),
                        ),
                        child: TaskCard(task: element)))
                    .toList(),
                AddCard(),
              ],
            ),
          )
        ],
      )),
      floatingActionButton: DragTarget<Task>(
        builder: (_, __, ___) {
          return Obx(
            () => FloatingActionButton(
              backgroundColor:
                  controller.deleting.value ? Colors.red : Colors.blue,
              onPressed: () {},
              child: Icon(controller.deleting.value ? Icons.delete : Icons.add),
            ),
          );
        },
        onAccept: (Task task) {
          controller.deletTask(task);
          EasyLoading.showSuccess('Deleted Successfully');
        },
      ),
    );
  }
}

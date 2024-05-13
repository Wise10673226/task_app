import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:task_app/app/data/models/task.dart';
import 'package:task_app/app/modules/home/controller.dart';
import 'package:task_app/app/core/utils/extensions.dart';
import 'package:task_app/app/modules/report/view.dart';
import 'package:task_app/app/widgets/add_card.dart';
import 'package:task_app/app/widgets/add_dialog.dart';
import 'package:intl/intl.dart';
import 'package:task_app/app/widgets/task_card.dart';

class HomePage extends GetView<HomeController> {
  bool isSwitched = false;
  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('kk:mm:ss \n EEE d MMM').format(now);
    return Scaffold(
      body: Obx(
        () => IndexedStack(
          index: controller.tabIndex.value,
          children: [
            SafeArea(
                child: ListView(
              children: [
                Padding(
                    padding: EdgeInsets.all(4.0.wp),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'My Tasks',
                          style: TextStyle(
                              fontSize: 24.0.sp, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          formattedDate,
                          style: TextStyle(
                              fontSize: 10.0.sp, fontWeight: FontWeight.bold),
                        ),
                        IconButton(
                            onPressed: () {
                              Get.changeTheme(Get.isDarkMode
                                  ? ThemeData.light()
                                  : ThemeData.dark());
                            },
                            icon: Icon(Icons.brightness_2))
                      ],
                    )),
                Obx(
                  () => GridView.count(
                    crossAxisCount: 2,
                    shrinkWrap: true,
                    physics: const ClampingScrollPhysics(),
                    children: [
                      ...controller.tasks
                          .map((element) => LongPressDraggable(
                              data: element,
                              onDragStarted: () =>
                                  controller.ChangeDeleting(true),
                              onDraggableCanceled: (_, __) =>
                                  controller.ChangeDeleting(false),
                              onDragEnd: (_) =>
                                  controller.ChangeDeleting(false),
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
            ReportPage()
          ],
        ),
      ),
      floatingActionButton: DragTarget<Task>(
        builder: (_, __, ___) {
          return Obx(
            () => FloatingActionButton(
              backgroundColor:
                  controller.deleting.value ? Colors.red : Colors.blue,
              onPressed: () {
                if (controller.tasks.isNotEmpty) {
                  Get.to(AddDialog(), transition: Transition.downToUp);
                } else {
                  EasyLoading.showInfo("Please create your task type");
                }

                // Get.to(AddDialog(), transition: Transition.downToUp);
              },
              child: Icon(controller.deleting.value ? Icons.delete : Icons.add),
            ),
          );
        },
        onAccept: (Task task) {
          controller.deleteTask(task);
          EasyLoading.showSuccess('Deleted Successfully');
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: Theme(
        data: ThemeData(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent),
        child: Obx(
          () => BottomNavigationBar(
            onTap: (int index) => controller.changeTabIndex(index),
            currentIndex: controller.tabIndex.value,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            items: [
              BottomNavigationBarItem(
                  icon: Padding(
                    padding: EdgeInsets.only(right: 15.0.wp),
                    child: Icon(Icons.apps),
                  ),
                  label: "Home"),
              BottomNavigationBarItem(
                  icon: Padding(
                    padding: EdgeInsets.only(left: 15.0.wp),
                    child: Icon(Icons.data_usage),
                  ),
                  label: "Report"),
            ],
          ),
        ),
      ),
    );
  }
}

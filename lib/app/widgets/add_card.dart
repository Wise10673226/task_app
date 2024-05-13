import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:task_app/app/core/utils/extensions.dart';
import 'package:task_app/app/data/models/task.dart';
import 'package:task_app/app/modules/detail/view.dart';
import 'package:task_app/app/modules/home/controller.dart';
import 'package:task_app/app/widgets/icons.dart';

class AddCard extends StatefulWidget {
  const AddCard({super.key});

  @override
  State<AddCard> createState() => _AddCardState();
}

class _AddCardState extends State<AddCard> {
  final homeCtrl = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    final icons = getIcons();
    var squarewidth = Get.width - 12.0.wp;

    return Container(
      width: squarewidth / 2,
      height: squarewidth / 2,
      margin: EdgeInsets.all(3.0.wp),
      child: InkWell(
        onTap: () async {
          await Get.defaultDialog(
              titlePadding: EdgeInsets.symmetric(vertical: 5.0.wp),
              radius: 5,
              title: 'Task Type',
              content: Form(
                  key: homeCtrl.formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: homeCtrl.editCtrl,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Title',
                        ),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Please enter your task title';
                          }
                          return null;
                        },
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 5.0.wp),
                        child: Wrap(
                          spacing: 2.0.wp,
                          children: icons
                              .map((e) => Obx(() {
                                    final index = icons.indexOf(e);
                                    return ChoiceChip(
                                      selectedColor: Colors.grey[200],
                                      pressElevation: 0,
                                      backgroundColor: Colors.white,
                                      label: e,
                                      selected:
                                          homeCtrl.chipIndex.value == index,
                                      onSelected: (bool selected) {
                                        homeCtrl.chipIndex.value =
                                            selected ? index : 0;
                                      },
                                    );
                                  }))
                              .toList(),
                        ),
                      ),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              minimumSize: Size(150, 40)),
                          onPressed: () {
                            setState(() {
                              if (homeCtrl.formKey.currentState!.validate()) {
                                int icon = icons[homeCtrl.chipIndex.value]
                                    .icon!
                                    .codePoint;
                                String color = icons[homeCtrl.chipIndex.value]
                                    .color!
                                    .toHex();
                                var task = Task(
                                  title: homeCtrl.editCtrl.text,
                                  icon: icon,
                                  color: color,
                                );
                                Get.back();
                                homeCtrl.addTask(task)
                                    ? EasyLoading.showSuccess(
                                        'Created Successfully')
                                    : EasyLoading.showError('Duplicated Task');
                              }
                            });
                          },
                          child: Text('Confirm'))
                    ],
                  )));
          //the two lines of code below terminates the dialog box when an empty space is clicked
          homeCtrl.editCtrl.clear();
          homeCtrl.changeChipIndex(0);
        },
        child: DottedBorder(
          borderType: BorderType.RRect,
          radius: Radius.circular(20),
          color: Colors.grey[400]!,
          dashPattern: [8, 4],
          child: Center(
            child: Icon(
              Icons.add,
              size: 10.0.wp,
              color: Colors.grey,
            ),
          ),
        ),
      ),
    );
  }
}

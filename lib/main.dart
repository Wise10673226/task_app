import 'package:flutter/material.dart';
import 'package:task_app/app/data/storage/services.dart';
import 'package:task_app/app/modules/home/binding.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:get/get.dart';
import 'dart:html';
import 'package:get_storage/get_storage.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:task_app/app/modules/home/view.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

void main() async {
  await GetStorage.init();
  await Get.putAsync(() => StorageService().init());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Task App',
      theme: ThemeData(useMaterial3: false),
      home: HomePage(),
      initialBinding: HomeBinding(),
      builder: EasyLoading.init(),
    );
  }
}

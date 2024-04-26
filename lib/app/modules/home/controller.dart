import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_app/app/data/models/task.dart';
import 'package:task_app/app/data/storage/repository.dart';

class HomeController extends GetxController {
  TaskRepository taskRepository;
  HomeController({required this.taskRepository});
  final editCtrl = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final deleting = false.obs;
  final chipIndex = 0.obs;
  final tasks = <Task>[].obs;
  @override
  void onInit() {
    super.onInit();
    tasks.assignAll(taskRepository.readTasks());
    ever(tasks, (_) => taskRepository.writeTasks(tasks));
  }

  void onClose() {
    editCtrl.dispose();
    super.onClose();
  }

  // this method below deletes tht task
  void ChangeDeleting(bool value) {
    deleting.value = value;
  }

  void changeChipIndex(int value) {
    chipIndex.value = value;
  }

// this method is for adding tasks
  bool addTask(Task task) {
    if (tasks.contains(task)) {
      return false;
    }
    tasks.add(task);
    return true;
  }

  void deletTask(Task task) {
    tasks.remove(task);
  }
}

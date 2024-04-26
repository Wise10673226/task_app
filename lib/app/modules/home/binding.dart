import 'package:get/get.dart';
import 'package:task_app/app/data/providers/provider.dart';
import 'package:task_app/app/data/storage/repository.dart';
import 'package:task_app/app/modules/home/controller.dart';

class HomeBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HomeController(
        taskRepository: TaskRepository(taskProvider: TaskProvider())));
  }
}

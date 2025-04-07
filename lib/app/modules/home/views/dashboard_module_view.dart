import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:pro_collision/app/assets/models/apiservices.dart';
import 'package:pro_collision/app/modules/home/controllers/home_controller.dart';

class DashboardModuleView extends GetView<HomeController> {

  const DashboardModuleView({super.key});
  @override
  Widget build(BuildContext context) {
    final ApiService apiService = Get.find<ApiService>();

    return Scaffold(
      appBar: AppBar(
        title: Obx(() => Text('Dashboard de ${controller.user.value}')),
      ),
      body: Obx((){
        return Container(
          color: Colors.amber,
          alignment: Alignment.center,
          child:Text("data${controller.user.value}")) ;



      }));
    
}
}
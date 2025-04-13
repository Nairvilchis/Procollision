import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:pro_collision/app/modules/home/controllers/home_controller.dart';

class ProcessesModuleView extends GetView<HomeController> {
  const ProcessesModuleView({super.key});
  @override
  Widget build(BuildContext context) {
   return Scaffold(
      appBar: AppBar(
        title: Obx(() => Text('Dashboard de ${controller.user.value}')),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 5,
            childAspectRatio: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
          children: [
            // Botón para "Administración" (visible solo si 'admin' es true)
            Obx(() {
              if (controller.workpermits().admin ?? false) {
                return ElevatedButton(
                  onPressed: () {
                    Get.snackbar('Acceso', 'Entrando al panel de administración');
                  },
                  child: Text('Administración'),
                );
              } else {
                return SizedBox.shrink(); // No muestra nada
              }
            }),

            // Botón para "Crear Orden" (visible solo si 'createOrder' es true)
            Obx(() {
              if (controller.workpermits().admin ?? false) {
                return ElevatedButton(
                  onPressed: () {
                    Get.snackbar('Acceso', 'Entrando al módulo de creación de órdenes',snackPosition: SnackPosition.BOTTOM);
                    Get.toNamed("/order",arguments: {"numOrder": null});
                  },
                  child: Text('Crear Orden'),
                );
              } else {
                return SizedBox.shrink(); // No muestra nada
              }
            }),

            // Botón para "Ver Reportes" (visible solo si 'viewReports' es true)
            Obx(() {
              if (controller.workpermits().admin ?? false) {
                return ElevatedButton(
                  onPressed: () {
                    Get.snackbar('Acceso', 'Mostrando reportes');
                  },
                  child: Text('Ver Reportes'),
                );
              } else {
                return SizedBox.shrink(); // No muestra nada
              }
            }),

            // Botón para "Gestionar Usuarios" (visible solo si 'manageUsers' es true)
            Obx(() {
              if (controller.workpermits().admin ?? false) {
                return ElevatedButton(
                  onPressed: () {
                    Get.snackbar('Acceso', 'Entrando a la gestión de usuarios');
                  },
                  child: Text('Gestionar Usuarios'),
                );
              } else {
                return SizedBox.shrink(); // No muestra nada
              }
            }),
          ],
        ),
      ),
    );
  }
}

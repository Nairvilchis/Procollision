import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:pro_collision/app/modules/home/views/dashboard_module_view.dart';
import 'package:pro_collision/app/modules/home/views/processes_module_view.dart';
import 'package:pro_collision/app/modules/home/views/reports_module_view.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Obx(() => Text('Dashboard de ${controller.user.value}')),
        actions: [
          SizedBox(
            width: 250,
            child: SearchBar(
              elevation: WidgetStateProperty.all(1),
              leading: Icon(Icons.search),
              hintText: "Busqueda De Orden",
              backgroundColor: WidgetStateProperty.all(Colors.white70),
              onSubmitted: (value) {
                if (value != "") {
                  Get.toNamed("/order", arguments: {"numOrder": value});
                }
              },
            ),
          )
        ],
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          if (GetPlatform.isMobile) {
            // Diseño para pantallas pequeñas: BottomNavigationBar.
            return Column(
              children: [
                Expanded(
                  child: GetBuilder<HomeController>(
                    builder: (controller) {
                      return IndexedStack(
                        index: controller.currentIndex.value,
                        children: [
                          DashboardModuleView(),
                          ProcessesModuleView(),
                          ReportsModuleView(),
                        ],
                      );
                    },
                  ),
                ),
                GetBuilder<HomeController>(
                  builder: (controller) {
                    return BottomNavigationBar(
                      currentIndex: controller.currentIndex.value,
                      onTap: (index) => controller.changePage(index),
                      items: const [
                        BottomNavigationBarItem(
                          icon: Icon(Icons.home),
                          label: 'Inicio',
                        ),
                        BottomNavigationBarItem(
                          icon: Icon(Icons.search),
                          label: 'Buscar',
                        ),
                        BottomNavigationBarItem(
                          icon: Icon(Icons.settings),
                          label: 'Configuración',
                        ),
                      ],
                    );
                  },
                ),
              ],
            );
          } else {
            // Diseño para pantallas grandes: NavigationRail.
            return Row(
              children: [
                GetBuilder<HomeController>(
                  builder: (controller) {
                    return NavigationRail(
                      selectedIndex: controller.currentIndex.value,
                      useIndicator: true,
                      selectedLabelTextStyle: TextStyle(
                          color: const Color.fromARGB(255, 41, 40, 40)),
                      onDestinationSelected: (index) {
                        controller.changePage(index);
                      },
                      labelType: NavigationRailLabelType.selected,
                      destinations: const [
                        NavigationRailDestination(
                          icon: Icon(Icons.home),
                          label: Text('Inicio'),
                        ),
                        NavigationRailDestination(
                          icon: Icon(Icons.search),
                          label: Text('Procesos'),
                        ),
                        NavigationRailDestination(
                          icon: Icon(Icons.settings),
                          label: Text('Configuración'),
                        ),
                      ],
                    );
                  },
                ),
                const VerticalDivider(thickness: 1, width: 1),
                Expanded(
                  child: GetBuilder<HomeController>(
                    builder: (controller) {
                      switch (controller.currentIndex.value) {
                        case 0:
                          return DashboardModuleView();
                        case 1:
                          return ProcessesModuleView();

                        case 2:
                          return ReportsModuleView();

                        default:
                          return Text("data");
                      }
                    },
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}

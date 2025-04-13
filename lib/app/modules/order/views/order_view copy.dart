import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/order_controller.dart';

class OrderView extends GetView<OrderController> {
  const OrderView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Orden'),
        actions: [
          ElevatedButton.icon(
            onPressed: () {
              Get.snackbar("Aviso", "Crear Nueva orden");
            },
            icon: const Icon(Icons.add_box),
            label: const Text("Nueva Orden"),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Form(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Sección: Datos de la Orden
                _buildCard(
                  title: "Datos de Orden",
                  children: [
                    Wrap(
                      direction: Axis.horizontal,
                      children: [
                        Obx(() => SizedBox(
                            width: 200,
                            child: TextFormField(
                              onChanged: (value) =>
                                  controller.orderId.value = value,
                              decoration: const InputDecoration(
                                labelText: 'Número de Orden',
                                border: OutlineInputBorder(),
                              ),
                              initialValue: controller.orderId.value,
                            ))),
                        Obx(() => SizedBox(
                            width: 200,
                            child: TextFormField(
                              onChanged: (value) =>
                                  controller.folio.value = value,
                              decoration: const InputDecoration(
                                labelText: 'Folio',
                                border: OutlineInputBorder(),
                              ),
                              initialValue: controller.folio.value,
                            ))),
                        Obx(() => SizedBox(
                            width: 200,
                            child: TextFormField(
                              onChanged: (value) =>
                                  controller.policy.value = value,
                              decoration: const InputDecoration(
                                labelText: 'Poliza',
                                border: OutlineInputBorder(),
                              ),
                              initialValue: controller.policy.value,
                            ))),
                        Obx(() => DropdownMenu(
                              width: 200,
                              onSelected: (value) {
                                controller.getAdjustersByInsurer(value);
                                controller.insurerId.value = value.toString();
                              },
                              label: const Text('Aseguradora'),
                              dropdownMenuEntries:
                                  controller.insurers.map((insurer) {
                                return DropdownMenuEntry(
                                  value: insurer['_id'],
                                  label: insurer['insurer'],
                                );
                              }).toList(),
                            )),
                        Obx(() => DropdownMenu(
                              width: 200,
                              onSelected: (value) {
                                controller.adjusterId.value = value.toString();
                              },
                              label: const Text('Ajustador'),
                              dropdownMenuEntries:
                                  controller.adjuster.map((insurer) {
                                return DropdownMenuEntry(
                                  value: insurer['_id'],
                                  label: insurer['adjusterName'],
                                );
                              }).toList(),
                            )),
                        Obx(() => SizedBox(
                              width: 200,
                              child: TextFormField(
                                onChanged: (value) {},
                                decoration: const InputDecoration(
                                  labelText: 'Reclamo',
                                  border: OutlineInputBorder(),
                                ),
                                initialValue: controller.report.value,
                              ),
                            )),
                      ],
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                _buildCard(title: "Datos de la Unidad", children: [
                  Wrap(
                    direction: Axis.horizontal,
                    children: [
                      Obx(() => DropdownMenu(
                            enableSearch: true,
                            width: 200,
                            onSelected: (value) {
                              controller.makeId.value = value.toString();
                              controller.getModelsByMake(value.toString());
                            },
                            label: const Text('Marca'),
                            dropdownMenuEntries: controller.makes.map((make) {
                              return DropdownMenuEntry(
                                value: make['_id'],
                                label: make['Nombre'].toString(),
                              );
                            }).toList(),
                          )),
                      Obx(() => DropdownMenu(
                            width: 200,
                            onSelected: (value) =>
                                controller.modelId.value = value.toString(),
                            label: const Text('Modelo'),
                            dropdownMenuEntries: controller.model.map((model) {
                              return DropdownMenuEntry(
                                value: model['_id'],
                                label: model['model'].toString(),
                              );
                            }).toList(),
                          )),
                      Obx(() => DropdownMenu(
                            width: 200,
                            onSelected: (value) =>
                                controller.year.value = value.toString(),
                            label: const Text('Año'),
                            dropdownMenuEntries: controller.years.map((year) {
                              return DropdownMenuEntry(
                                value: year['_id'],
                                label: year['year'].toString(),
                              );
                            }).toList(),
                          )),
                      Obx(() => SizedBox(
                            width: 200,
                            child: TextFormField(
                              onChanged: (value) =>
                                  controller.licensePlates.value = value,
                              decoration: const InputDecoration(
                                labelText: 'Placas',
                                border: OutlineInputBorder(),
                              ),
                              initialValue: controller.licensePlates.value,
                            ),
                          )),
                      Obx(() => SizedBox(
                            width: 300,
                            child: TextFormField(
                              onChanged: (value) =>
                                  controller.vin.value = value,
                              decoration: const InputDecoration(
                                labelText: 'VIN',
                                border: OutlineInputBorder(),
                              ),
                              initialValue: controller.vin.value,
                            ),
                          )),
                      Obx(() => SizedBox(
                            width: 200,
                            child: TextFormField(
                              onChanged: (value) =>
                                  controller.mileage.value = value,
                              decoration: const InputDecoration(
                                labelText: 'Kilometraje',
                                border: OutlineInputBorder(),
                              ),
                              initialValue: controller.mileage.value,
                            ),
                          )),
                      Obx(() => SizedBox(
                            width: 200,
                            child: TextFormField(
                              onChanged: (value) =>
                                  controller.colorCar.value = value,
                              decoration: const InputDecoration(
                                labelText: 'Color',
                                border: OutlineInputBorder(),
                              ),
                              initialValue: controller.colorCar.value,
                            ),
                          )),
                    ],
                  )
                ]),
                const SizedBox(height: 20),

                // Sección: Datos del Cliente
                _buildCard(
                  title: "Datos del Cliente",
                  children: [
                    Obx(() => SizedBox(
                          width: 600,
                          child: TextFormField(
                            onChanged: (value) =>
                                controller.clientName.value = value,
                            decoration: const InputDecoration(
                              labelText: 'Nombre del Cliente',
                              border: OutlineInputBorder(),
                            ),
                            initialValue: controller.policy.value,
                          ),
                        )),
                    Obx(() => Wrap(
                          children: [
                            SizedBox(
                              width: 600,
                              child: TextFormField(
                                onChanged: (value) =>
                                    controller.clientPhone.value = value,
                                decoration: const InputDecoration(
                                  labelText: 'Telefono',
                                  border: OutlineInputBorder(),
                                ),
                                initialValue: controller.clientPhone.value,
                              ),
                            ),
                            ElevatedButton.icon(
                              icon: const Icon(Icons.send),
                              onPressed: () => {
                                controller.btnWhatsapp.value
                                    ? controller.sendWatsapp()
                                    : Get.snackbar(
                                        "Aviso", "ya se envio el mensaje"),
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.green,
                                foregroundColor: Colors.white,
                              ),
                              label: const Text('Enviar WhatsApp'),
                            ),
                          ],
                        )),
                    Obx(() => SizedBox(
                          width: 600,
                          child: TextFormField(
                            onChanged: (value) =>
                                controller.clientEmail.value = value,
                            decoration: const InputDecoration(
                              labelText: 'email',
                              border: OutlineInputBorder(),
                            ),
                            initialValue: controller.clientEmail.value,
                          ),
                        )),
                  ],
                ),

                const SizedBox(height: 20),

                // Botón para crear la orden
                Center(
                  child: ElevatedButton(
                    onPressed: controller.createOrder,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 15),
                    ),
                    child: const Text('Crear Orden'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Método para construir tarjetas uniformes
  Widget _buildCard({required String title, required List<Widget> children}) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.blueAccent,
              ),
            ),
            const SizedBox(height: 20),
            ...children,
          ],
        ),
      ),
    );
  }
}

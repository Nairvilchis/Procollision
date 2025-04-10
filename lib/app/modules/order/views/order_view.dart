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
              controller.clearForm();
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
                              enabled: controller.canEdit.value,
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
                              enabled: controller.canEdit.value,
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
                              enabled: controller.canEdit.value,
                              onChanged: (value) =>
                                  controller.policy.value = value,
                              decoration: const InputDecoration(
                                labelText: 'Poliza',
                                border: OutlineInputBorder(),
                              ),
                              initialValue: controller.policy.value,
                            ))),
                        Obx(() => DropdownMenu(
                              enabled: controller.canEdit.value,
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
                              enabled: controller.canEdit.value,
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
                        Obx(() => DropdownMenu(
                              enabled: controller.canEdit.value,
                              width: 200,
                              onSelected: (value) {
                                controller.insuredOrThirdPartyvalue.value = value.toString();
                              },
                              label: const Text('asegurado o tercero'),
                              dropdownMenuEntries:
                                  controller.insuredOrThirdParty.map((insuOrThirt) {
                                return DropdownMenuEntry(
                                  value: insuOrThirt['_id'],
                                  label: insuOrThirt['type'].toString(),
                                );
                              }).toList(),
                            )),
                        Obx(() => SizedBox(
                              width: 200,
                              child: TextFormField(
                                enabled: controller.canEdit.value,
                                onChanged: (value) =>
                                    controller.claim.value = value,
                                decoration: const InputDecoration(
                                  labelText: 'Reclamo',
                                  border: OutlineInputBorder(),
                                ),
                                initialValue: controller.claim.value,
                              ),
                            )),
                        Obx(() => _buildCheckbox(
                            title: "En piso",
                            value: controller.onFloor.value,
                            onChanged: (value) {
                              controller.onFloor.value = value!;
                            })),
                        Obx(() => _buildCheckbox(
                            title: "Se uso grua",
                            value: controller.crane.value,
                            onChanged: (value) {
                              controller.crane.value = value!;
                            })),
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
                            enabled: controller.canEdit.value,
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
                            enabled: controller.canEdit.value,
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
                            enabled: controller.canEdit.value,
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
                              enabled: controller.canEdit.value,
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
                              enabled: controller.canEdit.value,
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
                              enabled: controller.canEdit.value,
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
                              enabled: controller.canEdit.value,
                              onChanged: (value) =>
                                  controller.color.value = value,
                              decoration: const InputDecoration(
                                labelText: 'Color',
                                border: OutlineInputBorder(),
                              ),
                              initialValue: controller.color.value,
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
                            enabled: controller.canEdit.value,
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
                                enabled: controller.canEdit.value,
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
                              onPressed: controller.canEdit.value
                                  ? () => {
                                        controller.btnWhatsapp.value
                                            ? controller.sendWatsapp()
                                            : Get.snackbar("Aviso",
                                                "ya se envio el mensaje"),
                                      }
                                  : null,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: controller.canEdit.value
                                    ? Colors.green
                                    : Colors.grey,
                                foregroundColor: Colors.white,
                              ),
                              label: const Text('Enviar WhatsApp'),
                            ),
                          ],
                        )),
                    Obx(() => SizedBox(
                          width: 600,
                          child: TextFormField(
                            enabled: controller.canEdit.value,
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
                    onPressed: controller.btnCreate.value
                        ? controller.createOrder
                        : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: controller.btnWhatsapp.value
                          ? Colors.green
                          : Colors.grey,
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
    return Container(
      width: double.infinity,
      child: Card(
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
              const SizedBox(height: 10),
              ...children,
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCheckbox(
      {required String title,
      required bool value,
      required Function(dynamic) onChanged}) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(5),
      ),
      child: SizedBox(
        width: 200,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start, // Espaciado uniforme
          children: [
            // Checkbox dentro de un SizedBox con tamaño fijo
            SizedBox(
              width: 50, // Tamaño fijo para el Checkbox
              height: 50, // Tamaño fijo para mantener proporción
              child: Checkbox(
                value: value,
                onChanged: controller.canEdit.value ? onChanged : null,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20), // Bordes redondeados
                ),
              ),
            ),

            // Texto dentro de un SizedBox con tamaño fijo
            SizedBox(
              width: 100,
              height: 50,
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey[800], // Color gris para el texto
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDropMenu(
      {required String title,
      required Function(dynamic) onSelected,
      required List<DropdownMenuEntry<dynamic>> entries}) {
    return DropdownMenu(
      width: 200,
      onSelected: onSelected,
      label: Text(title),
      dropdownMenuEntries: entries,
    );
  }
}

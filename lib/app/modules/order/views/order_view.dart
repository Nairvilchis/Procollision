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
                        SizedBox(
                            width: 200,
                            child: Obx(
                              () => TextFormField(
                                enabled: controller.canEdit.value,
                                controller: controller.orderIdController,
                                onChanged: (value) =>
                                    controller.orderId.value = value,
                                decoration: const InputDecoration(
                                  labelText: 'Número de Orden',
                                  border: OutlineInputBorder(),
                                ),
                              ),
                            )),
                        SizedBox(
                            width: 200,
                            child: Obx(() => TextFormField(
                                  controller: controller.folioController,
                                  enabled: controller.canEdit.value,
                                  onChanged: (value) =>
                                      controller.folio.value = value,
                                  decoration: const InputDecoration(
                                    labelText: 'Folio',
                                    border: OutlineInputBorder(),
                                  ),
                                  
                                ))),
                        SizedBox(
                            width: 200,
                            child: Obx(() => TextFormField(
                                  controller: controller.policyController,
                                  enabled: controller.canEdit.value,
                                  onChanged: (value) =>
                                      controller.policy.value = value,
                                  decoration: const InputDecoration(
                                    labelText: 'Poliza',
                                    border: OutlineInputBorder(),
                                  ),
                                 
                                ))),
                        Obx(() => DropdownMenu(
                              controller: controller.insurerIdController,
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
                              initialSelection:
                                  controller.adjusterIdController.text,
                              controller: controller.adjusterIdController,
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
                             
                              controller:
                                  controller.insuredOrThirdPartyvalueController,
                              enabled: controller.canEdit.value,
                              width: 200,
                              onSelected: (value) {
                                controller.insuredOrThirdPartyvalue.value =
                                    value.toString();
                              },
                              label: const Text('asegurado o tercero'),
                              dropdownMenuEntries: controller
                                  .insuredOrThirdParty
                                  .map((insuOrThirt) {
                                return DropdownMenuEntry(
                                  value: insuOrThirt['_id'],
                                  label: insuOrThirt['type'].toString(),
                                );
                              }).toList(),
                            )),
                        SizedBox(
                          width: 200,
                          child: Obx(() => TextFormField(
                                controller: controller.reportController,
                                enabled: controller.canEdit.value,
                                onChanged: (value) =>
                                    controller.report.value = value,
                                decoration: const InputDecoration(
                                  labelText: 'Reclamo',
                                  border: OutlineInputBorder(),
                                ),
                               
                              )),
                        ),
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
                        Obx(() => DropdownMenu(
                            
                              controller: controller.statusProgressController,
                              enabled: controller.canEdit.value,
                              width: 200,
                              onSelected: (value) {
                                controller.statusProgress.value =
                                    value.toString();
                              },
                              label: const Text('Status'),
                              dropdownMenuEntries:
                                  controller.status.map((status) {
                                return DropdownMenuEntry(
                                  value: status['_id'],
                                  label: status['status'].toString(),
                                );
                              }).toList(),
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
                          
                            controller: controller.makeIdController,
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
                          
                            controller: controller.modelIdController,
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
                            
                            controller: controller.yearIdController,
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
                      SizedBox(
                        width: 200,
                        child: Obx(() => TextFormField(
                              controller: controller.licensePlatesController,
                              enabled: controller.canEdit.value,
                              onChanged: (value) =>
                                  controller.licensePlates.value = value,
                              decoration: const InputDecoration(
                                labelText: 'Placas',
                                border: OutlineInputBorder(),
                              ),
                              
                            )),
                      ),
                      SizedBox(
                        width: 300,
                        child: Obx(() => TextFormField(
                              controller: controller.vinController,
                              enabled: controller.canEdit.value,
                              onChanged: (value) =>
                                  controller.vin.value = value,
                              decoration: const InputDecoration(
                                labelText: 'VIN',
                                border: OutlineInputBorder(),
                              ),
                             
                            )),
                      ),
                      SizedBox(
                        width: 200,
                        child: Obx(() => TextFormField(
                              controller: controller.mileageController,
                              enabled: controller.canEdit.value,
                              onChanged: (value) =>
                                  controller.mileage.value = value,
                              decoration: const InputDecoration(
                                labelText: 'Kilometraje',
                                border: OutlineInputBorder(),
                              ),
                              
                            )),
                      ),
                      Obx(() => DropdownMenu(
                           
                            controller: controller.colorCarController,
                            enabled: controller.canEdit.value,
                            width: 200,
                            onSelected: (value) =>
                                controller.colorCar.value = value.toString(),
                            label: const Text('Color'),
                            dropdownMenuEntries:
                                controller.colorsCars.map((year) {
                              return DropdownMenuEntry(
                                value: year['_id'],
                                label: year['color'].toString(),
                              );
                            }).toList(),
                          )),
                    ],
                  )
                ]),
                const SizedBox(height: 20),

                // Sección: Datos del Cliente
                _buildCard(
                  title: "Datos del Cliente",
                  children: [
                    SizedBox(
                      width: 600,
                      child: Obx(() => TextFormField(
                            controller: controller.clientNameController,
                            enabled: controller.canEdit.value,
                            onChanged: (value) =>
                                controller.clientName.value = value,
                            decoration: const InputDecoration(
                              labelText: 'Nombre del Cliente',
                              border: OutlineInputBorder(),
                            ),
                         
                          )),
                    ),
                    Obx(() => Wrap(
                          children: [
                            SizedBox(
                              width: 600,
                              child: Obx(() => TextFormField(
                                    controller:
                                        controller.clientPhoneController,
                                    enabled: controller.canEdit.value,
                                    onChanged: (value) =>
                                        controller.clientPhone.value = value,
                                    decoration: const InputDecoration(
                                      labelText: 'Telefono',
                                      border: OutlineInputBorder(),
                                    ),
                                   
                                  )),
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
                    SizedBox(
                      width: 600,
                      child: Obx(() => TextFormField(
                            controller: controller.clientEmailController,
                            enabled: controller.canEdit.value,
                            onChanged: (value) =>
                                controller.clientEmail.value = value,
                            decoration: const InputDecoration(
                              labelText: 'email',
                              border: OutlineInputBorder(),
                            ),
                           
                          )),
                    ),
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

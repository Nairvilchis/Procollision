import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pro_collision/app/assets/models/apiservices.dart';

class OrderController extends GetxController {
  //TODO: Implement OrderController

  @override
  void onInit() {
    super.onInit();
    getMakes();
  }

  ApiService apiService = Get.find<ApiService>(); // Configura tu baseUrl.

  // Variables observables para los campos del formulario
  final adjuster = ''.obs;
  final orderId = ''.obs;
  final folio = ''.obs;
  final vin = ''.obs;
  final mileage = ''.obs;
  final claim = ''.obs;
  final policy = ''.obs;
  final clientId = ''.obs;
  final clientName = ''.obs;
  final clientPhone = ''.obs;
  final clientEmail = ''.obs;
  final client = ''.obs;
  final modelId = 0.obs;
  final makeId = 0.obs;
  final year="".obs;
  final licensePlates = ''.obs;
  final color = ''.obs;
  final deductible = ''.obs;
  final onFloor = false.obs;
  final crane = false.obs;
  final now = DateTime.now();
  final makes = [].obs;
  final model = [].obs;

  final years = [{
"_id": "2023",
"year": "2023"
}, {
"_id": "2022",
"year": "2022"
}, {
"_id": "2021",
"year": "2021"
}, {
"_id": "2020",
"year": "2020"
}, {
"_id": "2019",
"year": "2019"
}, {
"_id": "2018",
"year": "2018"
}, {
"_id": "2017",
"year": "2017"
}, {
"_id": "2016",
"year": "2016"
}, {
"_id": "2015",
"year": "2015"
}, {
"_id": "2014",
"year": "2014"
}, {
"_id": "2013",
"year": "2013"
}].obs;
  // Método para obtener la lista de marcas
final box = GetStorage();


  Future<void> getMakes() async {
    try {
      final response = await apiService.getMakes();
      makes.value = response;
    } catch (error) {
      Get.snackbar(
        'Error',
        'No se pudieron obtener las marcas: $error',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  // Método para obtener la lista de modelos por marca
  Future<void> getModelsByMake(int make) async {
    try {
      final response = await apiService.getModelsByMake(make);
      model.value = response;
    } catch (error) {
      Get.snackbar(
        'Error',
        'No se pudieron obtener los modelos: $error',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  // Método para crear una nueva orden
  Future<void> createOrder() async {
    try {
      final newClient = {
        "name": clientName.value,
        "phone": clientPhone.value,
        "email": clientEmail.value
      };

      final responseClient = await apiService.addClient(newClient);

      final newOrder = {
        "orderId": orderId.value,
        "folio": folio.value,
        "vin": vin.value,
        "clientId": responseClient['_id'],
        "ThirdPartyInsured": "",
        "fileURL": "",
        "modelId": modelId.value,
        "makeId": makeId.value,
        "CreationDate": "${now.year}-${now.month}-${now.day}",
        "returnDate": "",
        "deliveryDate": "",
        "promiseDate": "",
        "appraiserId": 1,
        "advisorId": 1,
        "sheetmetalId": 1,
        "mileage": mileage.value,
        "painterId": 1,
        "budgetId": 1,
        "registration": "",
        "process": "",
        "adjuster": adjuster.value,
        "claim": claim.value,
        "onfloor": onFloor.value,
        "policy": policy.value,
        "year": year.value,
        "licenseplates": licensePlates.value,
        "color": color.value,
        "deductible": deductible.value,
        "crane": crane.value,
      };
      final responseOrder = await apiService.addOrder(newOrder);

      Get.snackbar(
        'Éxito',
        'Orden creada con éxito: ${responseOrder['_id']} Cliente creado con exito:${responseClient['_id']}',
        snackPosition: SnackPosition.BOTTOM,
      );
      clearForm();
    } catch (error) {
      Get.snackbar(
        'Error',
        'No se pudo crear la orden: $error',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

void sendWatsapp()async{
  String message = box.read("whatsapp_fst_msg");
  String number = clientPhone.value;

  await apiService.sendWhatsapp({"number":number,message:message});
  Get.snackbar(
    'Éxito',
    'Mensaje enviado por WhatsApp a $number',
    snackPosition: SnackPosition.BOTTOM,
  );

  
}




  // Método para limpiar el formulario
  void clearForm() {
    claim.value = '';
    policy.value = '';

    licensePlates.value = '';
    color.value = '';
    deductible.value = '';
    onFloor.value = false;
    crane.value = false;
  }
}

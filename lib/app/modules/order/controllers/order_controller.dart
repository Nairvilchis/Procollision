import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart';
import 'package:pro_collision/app/assets/models/apiservices.dart';

class OrderController extends GetxController {
  var order = null;

  // Variables observables para los campos del formulario
  final canEdit = true.obs;
  final btnCreate = true.obs;
  final btnWhatsapp = true.obs;
  final insurers = [].obs;
  final insurerId = "".obs;
  final adjusterId = "".obs;
  final adjuster = [].obs;
  final orderId = ''.obs;
  final folio = ''.obs;
  final vin = ''.obs;
  final mileage = ''.obs;
  final report = ''.obs;
  final policy = ''.obs;
  final clientId = ''.obs;
  final clientName = ''.obs;
  final clientPhone = ''.obs;
  final clientEmail = ''.obs;
  final modelId = "".obs;
  final makeId = "".obs;
  final makes = [].obs;
  final model = [].obs;
  final year = "".obs;
  final licensePlates = ''.obs;

  final deductible = ''.obs;
  final onFloor = true.obs;
  final crane = false.obs;
  final now = DateTime.now();
  final insuredOrThirdPartyvalue = "".obs;
  final urlData = "".obs;
  final dateCreated = "".obs;
  final dateDelivery = "".obs;
  final datePromise = "".obs;
  final dateReturn = "".obs;
  final statusProgress = "".obs;
  final colorCar = "".obs;
  late TextEditingController colorCarController;
  late TextEditingController statusProgressController;
  late TextEditingController insuredOrThirdPartyvalueController;
  late TextEditingController deductibleController;
  late TextEditingController licensePlatesController;
  late TextEditingController makeIdController;
  late TextEditingController modelIdController;
  late TextEditingController clientEmailController;
  late TextEditingController clientPhoneController;
  late TextEditingController clientNameController;
  late TextEditingController policyController;
  late TextEditingController reportController;
  late TextEditingController mileageController;
  late TextEditingController vinController;
  late TextEditingController folioController;
  late TextEditingController orderIdController;
  late TextEditingController adjusterIdController;
  late TextEditingController insurerIdController;
  late TextEditingController yearIdController;

  final status = [
    {"_id": "Valuacion", "status": "Valuacion"},
    {"_id": "Hojalateria", "status": "Hojalateria"},
    {"_id": "Pintura", "status": "Pintura"},
    {"_id": "Armado", "status": "Armado"},
    {"_id": "Entregado", "status": "Entregado"},
    {"_id": "Finalizado", "status": "Finalizado"},
    {"_id": "Cancelado", "status": "Cancelado"},
    {"_id": "Refaciones", "status": "Refaciones"},
    {"_id": "Perdida Total", "status": "Perdida Total"},
  ].obs;

  final years = [
    {"_id": "2026", "year": "2026"},
    {"_id": "2025", "year": "2025"},
    {"_id": "2024", "year": "2024"},
    {"_id": "2023", "year": "2023"},
    {"_id": "2022", "year": "2022"},
    {"_id": "2021", "year": "2021"},
    {"_id": "2020", "year": "2020"},
    {"_id": "2019", "year": "2019"},
    {"_id": "2018", "year": "2018"},
    {"_id": "2017", "year": "2017"},
    {"_id": "2016", "year": "2016"},
    {"_id": "2015", "year": "2015"},
    {"_id": "2014", "year": "2014"},
    {"_id": "2013", "year": "2013"}
  ].obs;

  final colorsCars = [
    {"_id": "NEGRO", "color": "NEGRO"},
    {"_id": "BLANCO", "color": "BLANCO"},
    {"_id": "ROJO", "color": "ROJO"},
    {"_id": "AZUL", "color": "AZUL"},
    {"_id": "VERDE", "color": "VERDE"},
    {"_id": "AMARILLO", "color": "AMARILLO"},
    {"_id": "GRIS", "color": "GRIS"},
    {"_id": "MARRON", "color": "MARRON"},
    {"_id": "NARANJA", "color": "NARANJA"},
    {"_id": "PLATEADO", "color": "PLATEADO"},
    {"_id": "DORADO", "color": "DORADO"},
    {"_id": "VIOLETA", "color": "VIOLETA"},
  ].obs;

  final insuredOrThirdParty = [
    {"_id": "Asegurado", "type": "Asegurado"},
    {"_id": "Tercero", "type": "Tercero"}
  ].obs;
  // Método para obtener la lista de marcas

  final box = GetStorage();

  //TODO: Implement OrderController
  ApiService apiService = Get.find<ApiService>();
  @override
  void onInit() async {
    super.onInit();
    start();
  }

  @override
  void onReady() async {
    super.onReady();
    getMakes();
    getInsurers();

    try {
      if (Get.arguments['numOrder'] != null) {
        order = await apiService.getOrderById(Get.arguments['numOrder']);
        print(
            "order:::::::::::::::::::::::::::::::::::::::::::::::::::::::::: $order");
        fillOrder(order);
      }
    } catch (error) {
      print(error);

      Get.offNamed("/home", arguments: {"error": "error"});
    }
  }

  void fillOrder(Map<String, dynamic> order) async {
    canEdit.value = false;
    orderId.value = order['order_id'];
    folio.value = order['folio'];
    policy.value = order['policy'];
    insuredOrThirdPartyvalue.value = order['insurerOrThirdParty'];
    report.value = order['report'];
    onFloor.value = order['onFloor'];
    crane.value = order['crane'];
    statusProgress.value = order['status'];
    deductible.value = order['deductible'];
    dateCreated.value = order['dateCreated'];
    dateDelivery.value = order['dateDelivery'];
    datePromise.value = order['datePromise'];
    dateReturn.value = order['dateReturn'];
    urlData.value = order['urlData'];
    year.value = order['year'];
    licensePlates.value = order['plate'];
    vin.value = order['vin'];
    mileage.value = order['mileage'];
    colorCar.value = order['color'];
    clientId.value = order['client_id'];
    final makeTemp = await apiService.getMakeById(order['make']);
    makeId.value = makeTemp["Nombre"];
    final modelTemp = await apiService.getModelById(order['model']);
    modelId.value = modelTemp["model"];
    final insurerTemp = await apiService.getInsurerById(order["insurer"]);
    insurerId.value = insurerTemp['insurer'];
    final adjusterTemp = await apiService.getAdjusterById(order["adjuster"]);
    adjusterId.value = adjusterTemp["adjusterName"];
    final clientTemp = await apiService.getClientById(order["client_id"]);
    clientName.value = clientTemp["name"];
    clientPhone.value = clientTemp["phone"];
    clientEmail.value = clientTemp["email"];
  }

  void start() {
    insurerIdController = TextEditingController(text: insurerId.value);
    adjusterIdController = TextEditingController(text: adjusterId.value);
    makeIdController = TextEditingController(text: makeId.value);
    modelIdController = TextEditingController(text: modelId.value);
    orderIdController = TextEditingController(text: orderId.value);
    folioController = TextEditingController(text: folio.value);
    vinController = TextEditingController(text: vin.value);
    mileageController = TextEditingController(text: mileage.value);
    reportController = TextEditingController(text: report.value);
    policyController = TextEditingController(text: policy.value);
    clientNameController = TextEditingController(text: clientName.value);
    clientPhoneController = TextEditingController(text: clientPhone.value);
    clientEmailController = TextEditingController(text: clientEmail.value);
    licensePlatesController = TextEditingController(text: licensePlates.value);
    deductibleController = TextEditingController(text: deductible.value);
    colorCarController = TextEditingController(text: colorCar.value);
    statusProgressController =
        TextEditingController(text: statusProgress.value);
    insuredOrThirdPartyvalueController =
        TextEditingController(text: insuredOrThirdPartyvalue.value);
    yearIdController = TextEditingController(text: year.value);

    insurerIdController.addListener(() {
      if (insurerId != insurerIdController.text) {
        insurerId.value = insurerIdController.text;
      }
    });
    adjusterIdController.addListener(() {
      if (adjusterId != adjusterIdController.text) {
        adjusterId.value = adjusterIdController.text;
      }
    });
    makeIdController.addListener(() {
      if (makeId != makeIdController.text) {
        makeId.value = makeIdController.text;
      }
    });
    modelIdController.addListener(() {
      if (modelId != modelIdController.text) {
        modelId.value = modelIdController.text;
      }
    });
    licensePlatesController.addListener(() {
      if (licensePlates != licensePlatesController.text) {
        licensePlates.value = licensePlatesController.text;
      }
    });
    deductibleController.addListener(() {
      if (deductible != deductibleController.text) {
        deductible.value = deductibleController.text;
      }
    });
    colorCarController.addListener(() {
      if (colorCar != colorCarController.text) {
        colorCar.value = colorCarController.text;
      }
    });
    statusProgressController.addListener(() {
      if (statusProgress != statusProgressController.text) {
        statusProgress.value = statusProgressController.text;
      }
    });
    insuredOrThirdPartyvalueController.addListener(() {
      if (insuredOrThirdPartyvalue != insuredOrThirdPartyvalueController.text) {
        insuredOrThirdPartyvalue.value =
            insuredOrThirdPartyvalueController.text;
      }
    });

    orderIdController.addListener(() {
      if (orderId != orderIdController.text) {
        orderId.value = orderIdController.text;
      }
    });

    folioController.addListener(() {
      if (folio != folioController.text) {
        folio.value = folioController.text;
      }
    });
    vinController.addListener(() {
      if (vin != vinController.text) {
        vin.value = vinController.text;
      }
    });
    mileageController.addListener(() {
      if (mileage != mileageController.text) {
        mileage.value = mileageController.text;
      }
    });
    reportController.addListener(() {
      if (report != reportController.text) {
        report.value = reportController.text;
      }
    });
    policyController.addListener(() {
      if (policy != policyController.text) {
        policy.value = policyController.text;
      }
    });
    clientNameController.addListener(() {
      if (clientName != clientNameController.text) {
        clientName.value = clientNameController.text;
      }
    });
    clientPhoneController.addListener(() {
      if (clientPhone != clientPhoneController.text) {
        clientPhone.value = clientPhoneController.text;
      }
    });
    clientEmailController.addListener(() {
      if (clientEmail != clientEmailController.text) {
        clientEmail.value = clientEmailController.text;
      }
    });
    yearIdController.addListener(() {
      if (year != yearIdController.text) {
        year.value = yearIdController.text;
      }
    });

    ever<String>(insurerId, (value) {
      if (insurerIdController.text != value) {
        insurerIdController.value = TextEditingValue(
            text: value,
            selection: TextSelection.collapsed(offset: value.length));
      }
    });

    ever<String>(adjusterId, (value) {
      if (adjusterIdController.text != value) {
        adjusterIdController.value = TextEditingValue(
            text: value,
            selection: TextSelection.collapsed(offset: value.length));
      }
    });
    ever<String>(makeId, (value) {
      if (makeIdController.text != value) {
        makeIdController.value = TextEditingValue(
            text: value,
            selection: TextSelection.collapsed(offset: value.length));
      }
    });
    ever<String>(modelId, (value) {
      if (modelIdController.text != value) {
        modelIdController.value = TextEditingValue(
            text: value,
            selection: TextSelection.collapsed(offset: value.length));
      }
    });
    ever<String>(licensePlates, (value) {
      if (licensePlatesController.text != value) {
        licensePlatesController.value = TextEditingValue(
            text: value,
            selection: TextSelection.collapsed(offset: value.length));
      }
    });
    ever<String>(deductible, (value) {
      if (deductibleController.text != value) {
        deductibleController.value = TextEditingValue(
            text: value,
            selection: TextSelection.collapsed(offset: value.length));
      }
    });
    ever<String>(colorCar, (value) {
      if (colorCarController.text != value) {
        colorCarController.value = TextEditingValue(
            text: value,
            selection: TextSelection.collapsed(offset: value.length));
      }
    });
    ever<String>(statusProgress, (value) {
      if (statusProgressController.text != value) {
        statusProgressController.value = TextEditingValue(
            text: value,
            selection: TextSelection.collapsed(offset: value.length));
      }
    });
    ever<String>(insuredOrThirdPartyvalue, (value) {
      if (insuredOrThirdPartyvalueController.text != value) {
        insuredOrThirdPartyvalueController.value = TextEditingValue(
            text: value,
            selection: TextSelection.collapsed(offset: value.length));
      }
    });
    ever<String>(orderId, (value) {
      if (orderIdController.text != value) {
        orderIdController.value = TextEditingValue(
            text: value,
            selection: TextSelection.collapsed(offset: value.length));
      }
    });
    ever<String>(folio, (value) {
      if (folioController.text != value) {
        folioController.value = TextEditingValue(
            text: value,
            selection: TextSelection.collapsed(offset: value.length));
      }
    });
    ever<String>(vin, (value) {
      if (vinController.text != value) {
        vinController.value = TextEditingValue(
            text: value,
            selection: TextSelection.collapsed(offset: value.length));
      }
    });
    ever<String>(mileage, (value) {
      if (mileageController.text != value) {
        mileageController.value = TextEditingValue(
            text: value,
            selection: TextSelection.collapsed(offset: value.length));
      }
    });
    ever<String>(report, (value) {
      if (reportController.text != value) {
        reportController.value = TextEditingValue(
            text: value,
            selection: TextSelection.collapsed(offset: value.length));
      }
    });
    ever<String>(policy, (value) {
      if (policyController.text != value) {
        policyController.value = TextEditingValue(
            text: value,
            selection: TextSelection.collapsed(offset: value.length));
      }
    });
    ever<String>(clientName, (value) {
      if (clientNameController.text != value) {
        clientNameController.value = TextEditingValue(
            text: value,
            selection: TextSelection.collapsed(offset: value.length));
      }
    });
    ever<String>(clientPhone, (value) {
      if (clientPhoneController.text != value) {
        clientPhoneController.value = TextEditingValue(
            text: value,
            selection: TextSelection.collapsed(offset: value.length));
      }
    });

    ever<String>(clientEmail, (value) {
      if (clientEmailController.text != value) {
        clientEmailController.value = TextEditingValue(
            text: value,
            selection: TextSelection.collapsed(offset: value.length));
      }
    });
    ever<String>(year, (value) {
      if (yearIdController.text != value) {
        yearIdController.value = TextEditingValue(
            text: value,
            selection: TextSelection.collapsed(offset: value.length));
      }
    });
  }

  // Configura tu baseUrl.

  Future<void> getInsurers() async {
    try {
      final response = await apiService.getInsurers();
      insurers.value = response;
    } catch (error) {
      Get.snackbar(
        'Error',
        'No se pudieron obtener las aseguradoras: $error',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  Future<void> getAdjustersByInsurer(String insurer) async {
    try {
      final response = await apiService.getAdjustersByInsurer(insurer);
      adjuster.value = response;
    } catch (error) {
      Get.snackbar(
        'Error',
        'No se pudieron obtener los modelos: $error',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

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
  Future<void> getModelsByMake(String make) async {
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
      print("responseClient: $responseClient[_id]");
      print("responseClient: $responseClient");
      final newOrder = {
        //////////////
        /// datos de la orden
        /////////////

        "order_id": orderId.value, //ya
        "folio": folio.value, //ya
        "policy": policy.value, //ya
        "insurer": insurerId.value, //ya
        "adjuster": adjusterId.value, //ya
        "insurerOrThirdParty": insuredOrThirdPartyvalue.value, //ya
        "report": report.value, //ya
        "onFloor": onFloor.value, //ya
        "crane": crane.value, //ya
        "status": statusProgress.value, //ya
        "deductible": deductible.value, //ya
        "dateCreated": now.toString(), //ya
        "dateDelivery": dateDelivery.value, //ya
        "datePromise": datePromise.value, //ya
        "dateReturn": dateReturn.value, //ya
        "urlData": urlData.value, //ya

        ////////////////
        ///datos de la unidad
        ///////////////
        "make": makeId.value, //ya
        "model": modelId.value, //ya
        "year": year.value, //ya
        "plate": licensePlates.value, //ya
        "vin": vin.value, //ya
        "mileage": mileage.value, //ya
        "color": colorCar.value, //ya

        //////////////
        ///datos del cliente
        /////////////
        "client_id": responseClient['client_id'], //ya
      };
      print("newOrder: $newOrder");
      final responseOrder = await apiService.addOrder(newOrder);

      Get.snackbar(
        'Éxito',
        'Orden creada con éxito: ${responseOrder['order_id']} Cliente creado con exito:${responseClient['client_id']}',
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (error) {
      Get.snackbar(
        'Error',
        'No se pudo crear la orden: $error',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  void sendWatsapp() async {
    String message = box.read("whatsapp_fst_msg");
    String number = "521${clientPhone.value}";
    var whats = {"number": number, "message": message};

    var response = await apiService.sendWhatsapp(whats);
    if (response["status"] == "ok") {
      btnWhatsapp.value = false;
      Get.snackbar(
        'Éxito',
        'Mensaje enviado por WhatsApp a $number',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  // Método para limpiar el formulario
}

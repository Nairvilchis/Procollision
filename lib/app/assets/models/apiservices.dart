import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl;

  ApiService(this.baseUrl);
   Future<ApiService> init() async {
    print('ApiService inicializado');
    return this;
  }

Future<Map<String, dynamic>> sendWhatsapp(Map<String, dynamic> whatsapp) async {
    final response = await http.post(
      Uri.parse('http://localhost:3008/v1/messages'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(whatsapp),
    );
    if (response.statusCode == 201) {
      return json.decode(response.body);
    } else {
      throw Exception('Error al agregar el trabajador: ${response.reasonPhrase}');
    }
  }


  // ---- MÉTODOS PARA WORKERS ----
  Future<List<dynamic>> getWorkers() async {
    final response = await http.get(Uri.parse('$baseUrl/workers'));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Error al obtener los trabajadores: ${response.reasonPhrase}');
    }
  }

  Future<Map<String, dynamic>> addWorker(Map<String, dynamic> worker) async {
    final response = await http.post(
      Uri.parse('$baseUrl/add_worker'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(worker),
    );
    if (response.statusCode == 201) {
      return json.decode(response.body);
    } else {
      throw Exception('Error al agregar el trabajador: ${response.reasonPhrase}');
    }
  }

  Future<Map<String, dynamic>> getWorkerByUser(String user) async {
    final response = await http.get(Uri.parse('$baseUrl/worker/$user'));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Trabajador no encontrado: ${response.reasonPhrase}');
    }
  }

  // ---- MÉTODOS PARA CLIENTS ----
  Future<List<dynamic>> getClients() async {
    final response = await http.get(Uri.parse('$baseUrl/clients'));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Error al obtener los clientes: ${response.reasonPhrase}');
    }
  }

  Future<Map<String, dynamic>> addClient(Map<String, dynamic> client) async {
    final response = await http.post(
      Uri.parse('$baseUrl/add_client'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(client),
    );
    if (response.statusCode == 201) {
      return json.decode(response.body);
    } else {
      throw Exception('Error al agregar el cliente: ${response.reasonPhrase}');
    }
  }

  Future<Map<String, dynamic>> getClientByName(String name) async {
    final response = await http.get(Uri.parse('$baseUrl/client/$name'));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Cliente no encontrado: ${response.reasonPhrase}');
    }
  }

  // ---- MÉTODOS PARA INSURERS ----
  Future<List<dynamic>> getInsurers() async {
    final response = await http.get(Uri.parse('$baseUrl/insurers'));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Error al obtener las aseguradoras: ${response.reasonPhrase}');
    }
  }

  Future<Map<String, dynamic>> addInsurer(Map<String, dynamic> insurer) async {
    final response = await http.post(
      Uri.parse('$baseUrl/add_insurer'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(insurer),
    );
    if (response.statusCode == 201) {
      return json.decode(response.body);
    } else {
      throw Exception('Error al agregar la aseguradora: ${response.reasonPhrase}');
    }
  }




  // ---- MÉTODOS PARA INSURERS ----
  Future<List<dynamic>> getAdjuster() async {
    final response = await http.get(Uri.parse('$baseUrl/adjusters'));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Error al obtener los ajustadores ${response.reasonPhrase}');
    }
  }

  Future<Map<String, dynamic>> addAdjuster(Map<String, dynamic> adjuster) async {
    final response = await http.post(
      Uri.parse('$baseUrl/add_adjuster'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(adjuster),
    );
    if (response.statusCode == 201) {
      return json.decode(response.body);
    } else {
      throw Exception('Error al agregar la aseguradora: ${response.reasonPhrase}');
    }
  }

Future<List<dynamic>> getAdjustersByInsurer(String insurerId) async {
  final response = await http.get(Uri.parse('$baseUrl/adjusters/$insurerId'));
  if (response.statusCode == 200) {
    return json.decode(response.body); // Devuelve la lista decodificada
  } else {
    throw Exception('Error al obtener los ajustadores: ${response.reasonPhrase}');
  }
}
  



  // ---- MÉTODOS PARA brandModels ----
  Future<List<dynamic>> getBrandModels() async {
    final response = await http.get(Uri.parse('$baseUrl/brandModels'));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Error al obtener las marcas-modelos: ${response.reasonPhrase}');
    }
  }

  Future<Map<String, dynamic>> addBrandModel(Map<String, dynamic> brandModel) async {
    final response = await http.post(
      Uri.parse('$baseUrl/add_brandModel'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(brandModel),
    );
    if (response.statusCode == 201) {
      return json.decode(response.body);
    } else {
      throw Exception('Error al agregar marca-modelo: ${response.reasonPhrase}');
    }
  }

  // ---- MÉTODOS PARA Budgets ----
  Future<List<dynamic>> getBudgets() async {
    final response = await http.get(Uri.parse('$baseUrl/budgets'));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Error al obtener los presupuestos: ${response.reasonPhrase}');
    }
  }

  Future<Map<String, dynamic>> addBudget(Map<String, dynamic> budget) async {
    final response = await http.post(
      Uri.parse('$baseUrl/add_budget'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(budget),
    );
    if (response.statusCode == 201) {
      return json.decode(response.body);
    } else {
      throw Exception('Error al agregar el presupuesto: ${response.reasonPhrase}');
    }
  }

  Future<Map<String, dynamic>> getBudgetByOrder(String orderId) async {
    final response = await http.get(Uri.parse('$baseUrl/budget_by_order/$orderId'));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Presupuesto no encontrado para esta orden: ${response.reasonPhrase}');
    }
  }

  // ---- MÉTODOS PARA Parts ----
  Future<List<dynamic>> getParts() async {
    final response = await http.get(Uri.parse('$baseUrl/parts'));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Error al obtener las partes: ${response.reasonPhrase}');
    }
  }

  Future<Map<String, dynamic>> addPart(Map<String, dynamic> part) async {
    final response = await http.post(
      Uri.parse('$baseUrl/add_part'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(part),
    );
    if (response.statusCode == 201) {
      return json.decode(response.body);
    } else {
      throw Exception('Error al agregar la parte: ${response.reasonPhrase}');
    }
  }

  Future<List<dynamic>> getPartsByOrder(String orderId) async {
    final response = await http.get(Uri.parse('$baseUrl/parts_by_order/$orderId'));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Partes no encontradas para esta orden: ${response.reasonPhrase}');
    }
  }

  // ---- MÉTODOS PARA ORDERS ----
  Future<List<dynamic>> getOrders() async {
    final response = await http.get(Uri.parse('$baseUrl/orders'));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Error al obtener las órdenes: ${response.reasonPhrase}');
    }
  }

  Future<Map<String, dynamic>> addOrder(Map<String, dynamic> order) async {
    final response = await http.post(
      Uri.parse('$baseUrl/add_order'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(order),
    );
    if (response.statusCode == 201) {
      return json.decode(response.body);
    } else {
      throw Exception('Error al agregar la orden: ${response.reasonPhrase}');
    }
  }

  Future<List<dynamic>> getOrdersByClient(String clientId) async {
    final response = await http.get(Uri.parse('$baseUrl/orders_by_client/$clientId'));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Órdenes no encontradas para este cliente: ${response.reasonPhrase}');
    }
  }

  Future<List<dynamic>> getOrdersWithInsurer(String insurerId) async {
    final response = await http.get(Uri.parse('$baseUrl/orders_with_insurer/$insurerId'));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('No se encontraron órdenes para esta aseguradora: ${response.reasonPhrase}');
    }
  }

// ---- MÉTODOS PARA MAKES ----
Future<List<dynamic>> getMakes() async {
  final response = await http.get(Uri.parse('$baseUrl/makes'));
  if (response.statusCode == 200) {
    return json.decode(response.body);
  } else {
    throw Exception('Error al obtener las marcas: ${response.reasonPhrase}');
  }
}

// ---- MÉTODOS PARA MODELS ----
Future<List<dynamic>> getModelsByMake(String make) async {
  final response = await http.get(Uri.parse('$baseUrl/models/$make'));
  if (response.statusCode == 200) {
    return json.decode(response.body);
  } else {
    throw Exception('Error al obtener los modelos de la marca $make: ${response.reasonPhrase}');
  }
}



  
}

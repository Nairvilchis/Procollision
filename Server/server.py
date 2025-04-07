from flask import Flask, request, jsonify
from flask_pymongo import PyMongo
from bson import ObjectId

app = Flask(__name__)

# Configuración de la conexión a MongoDB
app.config["MONGO_URI"] = "mongodb://localhost:27017/Procollision"
mongo = PyMongo(app)

# ---- FUNCIONALIDAD PARA WORKERS ----

# Ruta para agregar un nuevo trabajador
@app.route('/add_worker', methods=['POST'])
def add_worker():
    data = request.get_json()
    worker_document = {
        "id": data.get("id"),
        "name": data.get("name"),
        "cellphonenumber": data.get("cellphonenumber"),
        "workstation": data.get("workstation"),
        "password": data.get("password"),
        "user": data.get("user"),
        "startdate": data.get("startdate"),
        "workpermits": data.get("workpermits", {})
    }
    try:
        worker_collection = mongo.db.workers
        worker_id = worker_collection.insert_one(worker_document).inserted_id
        return jsonify({"message": "Worker agregado con éxito", "worker_id": str(worker_id)}), 201
    except Exception as e:
        return jsonify({"error": f"Error al agregar el worker: {str(e)}"}), 500

# Ruta para obtener todos los trabajadores
@app.route('/workers', methods=['GET'])
def get_workers():
    worker_collection = mongo.db.workers
    workers = worker_collection.find()
    workers_list = [
        {
            "_id": str(worker["_id"]),
            "id": worker.get("id"),
            "name": worker["name"],
            "cellphonenumber": worker["cellphonenumber"],
            "workstation": worker["workstation"],
            "password": worker["password"],
            "user": worker["user"],
            "startdate": worker["startdate"],
            "workpermits": worker["workpermits"]
        }
        for worker in workers
    ]
    print(workers_list)
    return jsonify(workers_list), 200

# Ruta para buscar un trabajador por su usuario
@app.route('/worker/<user>', methods=['GET'])
def get_worker_by_user(user):
    worker_collection = mongo.db.workers
    worker = worker_collection.find_one({"user": user})

    if worker:
        worker_data = {
            "_id": str(worker["_id"]),
            "id": worker.get("id"),
            "name": worker["name"],
            "cellphonenumber": worker["cellphonenumber"],
            "workstation": worker["workstation"],
            "password": worker["password"],
            "user": worker["user"],
            "startdate": worker["startdate"],
            "workpermits": worker["workpermits"]
        }
        return jsonify(worker_data), 200
    else:
        return jsonify({"error": "Worker no encontrado"}), 404

# ---- FUNCIONALIDAD PARA CLIENTS ----

# Ruta para agregar un cliente
@app.route('/add_client', methods=['POST'])
def add_client():
    data = request.get_json()
    client_document = {
        "client_id": data.get("client_id"),
        "name": data.get("name"),
        "phone": data.get("phone"),
        "email": data.get("email")
    }
    try:
        client_collection = mongo.db.clients
        client_id = client_collection.insert_one(client_document).inserted_id
        return jsonify({"message": "Cliente agregado con éxito", "client_id": str(client_id)}), 201
    except Exception as e:
        return jsonify({"error": f"Error al agregar el cliente: {str(e)}"}), 500

# Ruta para listar todos los clientes
@app.route('/clients', methods=['GET'])
def get_clients():
    client_collection = mongo.db.clients
    clients = client_collection.find()
    clients_list = [
        {
            "_id": str(client["_id"]),
            "client_id": client["client_id"],
            "name": client["name"],
            "phone": client["phone"],
            "email": client["email"]
        }
        for client in clients
    ]
    return jsonify(clients_list), 200

# Ruta para buscar un cliente por su nombre
@app.route('/client/<name>', methods=['GET'])
def get_client_by_name(name):
    client_collection = mongo.db.clients
    client = client_collection.find_one({"name": name})

    if client:
        client_data = {
            "_id": str(client["_id"]),
            "client_id": client["client_id"],
            "name": client["name"],
            "phone": client["phone"],
            "email": client["email"]
        }
        return jsonify(client_data), 200
    else:
        return jsonify({"error": "Cliente no encontrado"}), 404

# ---- FUNCIONALIDAD PARA INSURERS ----

# Ruta para agregar una aseguradora
@app.route('/add_insurer', methods=['POST'])
def add_insurer():
    data = request.get_json()
    insurer_document = {
        "insurer_id": data.get("insurer_id"),
        "insurer": data.get("insurer"),
        "adjusters": data.get("adjusters", [])
    }
    try:
        insurers_collection = mongo.db.insurers
        insurer_id = insurers_collection.insert_one(insurer_document).inserted_id
        return jsonify({"message": "Aseguradora agregada con éxito", "insurer_id": str(insurer_id)}), 201
    except Exception as e:
        return jsonify({"error": f"Error al agregar la aseguradora: {str(e)}"}), 500

# Ruta para listar todas las aseguradoras
@app.route('/insurers', methods=['GET'])
def get_insurers():
    insurers_collection = mongo.db.insurers
    insurers = insurers_collection.find()
    insurers_list = [
        {
            "_id": str(insurer["_id"]),
            "insurer_id": insurer["insurer_id"],
            "insurer": insurer["insurer"],
            "adjusters": insurer["adjusters"]
        }
        for insurer in insurers
    ]
    return jsonify(insurers_list), 200

# ---- FUNCIONALIDAD PARA brandModels ----

# Ruta para agregar una marca-modelo
@app.route('/add_brandModel', methods=['POST'])
def add_brandModel():
    data = request.get_json()
    brand_model_document = {
        "brandModel_id": data.get("brandModel_id"),
        "brand": data.get("brand"),
        "model": data.get("model")
    }
    try:
        brand_model_collection = mongo.db.brandModels
        brand_model_id = brand_model_collection.insert_one(brand_model_document).inserted_id
        return jsonify({"message": "BrandModel agregado con éxito", "brandModel_id": str(brand_model_id)}), 201
    except Exception as e:
        return jsonify({"error": f"Error al agregar BrandModel: {str(e)}"}), 500

# Ruta para listar todas las marcas-modelos
@app.route('/brandModels', methods=['GET'])
def get_brandModels():
    brand_model_collection = mongo.db.brandModels
    brand_models = brand_model_collection.find()
    brand_models_list = [
        {
            "_id": str(brand_model["_id"]),
            "brandModel_id": brand_model["brandModel_id"],
            "brand": brand_model["brand"],
            "model": brand_model["model"]
        }
        for brand_model in brand_models
    ]
    return jsonify(brand_models_list), 200

# Ruta para buscar marcas-modelos por marca
@app.route('/brandModels/brand/<brand>', methods=['GET'])
def get_brandModels_by_brand(brand):
    brand_model_collection = mongo.db.brandModels
    brand_models = brand_model_collection.find({"brand": brand})

    brand_models_list = [
        {
            "_id": str(brand_model["_id"]),
            "brandModel_id": brand_model["brandModel_id"],
            "brand": brand_model["brand"],
            "model": brand_model["model"]
        }
        for brand_model in brand_models
    ]

    if brand_models_list:
        return jsonify(brand_models_list), 200
    else:
        return jsonify({"error": "No se encontraron resultados para la marca especificada"}), 404

# ---- FUNCIONALIDAD PARA Budgets ----

# Ruta para agregar un presupuesto
@app.route('/add_budget', methods=['POST'])
def add_budget():
    data = request.get_json()
    budget_document = {
        "budget_id": data.get("budget_id"),
        "concepts": data.get("concepts", [])
    }
    try:
        budget_collection = mongo.db.budgets
        budget_id = budget_collection.insert_one(budget_document).inserted_id
        return jsonify({"message": "Budget agregado con éxito", "budget_id": str(budget_id)}), 201
    except Exception as e:
        return jsonify({"error": f"Error al agregar el budget: {str(e)}"}), 500

# Ruta para listar todos los presupuestos
@app.route('/budgets', methods=['GET'])
def get_budgets():
    budget_collection = mongo.db.budgets
    budgets = budget_collection.find()
    budgets_list = [
        {
            "_id": str(budget["_id"]),
            "budget_id": budget["budget_id"],
            "concepts": budget["concepts"]
        }
        for budget in budgets
    ]
    return jsonify(budgets_list), 200


# ---- CONSULTAS RELACIONADAS ----

# Consulta de órdenes relacionadas con un cliente
@app.route('/orders_by_client/<client_id>', methods=['GET'])
def get_orders_by_client(client_id):
    orders_collection = mongo.db.orders
    orders = orders_collection.find({"clientId": int(client_id)})

    orders_list = [
        {
            "_id": str(order["_id"]),
            "orderId": order["orderId"],
            "adjuster": order["adjuster"],
            "clientId": order["clientId"],
            "brandModelId": order["brandModelId"],
            "registrationDate": order["registrationDate"],
            "process": order["process"]
        }
        for order in orders
    ]

    if orders_list:
        return jsonify(orders_list), 200
    else:
        return jsonify({"error": "No se encontraron órdenes para este cliente"}), 404

# Consulta de piezas relacionadas con una orden
@app.route('/parts_by_order/<order_id>', methods=['GET'])
def get_parts_by_order(order_id):
    parts_collection = mongo.db.parts
    parts = parts_collection.find({"order_id": int(order_id)})

    parts_list = [
        {
            "_id": str(part["_id"]),
            "parts_id": part["parts_id"],
            "refaccion": part["refaccion"],
            "brandModel_id": part["brandModel_id"],
            "supplier": part["supplier"],
            "remarks": part["remarks"]
        }
        for part in parts
    ]

    if parts_list:
        return jsonify(parts_list), 200
    else:
        return jsonify({"error": "No se encontraron piezas para esta orden"}), 404

# Consulta de aseguradora y ajustadores por ID
@app.route('/insurer_by_id/<insurer_id>', methods=['GET'])
def get_insurer_by_id(insurer_id):
    insurers_collection = mongo.db.insurers
    insurer = insurers_collection.find_one({"insurer_id": insurer_id})

    if insurer:
        insurer_data = {
            "_id": str(insurer["_id"]),
            "insurer_id": insurer["insurer_id"],
            "insurer": insurer["insurer"],
            "adjusters": insurer["adjusters"]
        }
        return jsonify(insurer_data), 200
    else:
        return jsonify({"error": "Aseguradora no encontrada"}), 404

# Consulta de órdenes con datos de aseguradora asociada
@app.route('/orders_with_insurer/<insurer_id>', methods=['GET'])
def get_orders_with_insurer(insurer_id):
    orders_collection = mongo.db.orders
    insurers_collection = mongo.db.insurers

    orders = orders_collection.find({"insurerId": int(insurer_id)})
    insurer = insurers_collection.find_one({"insurer_id": insurer_id})

    if insurer and orders:
        orders_list = [
            {
                "orderId": order["orderId"],
                "adjuster": order["adjuster"],
                "claim": order["claim"],
                "registrationDate": order["registrationDate"],
                "process": order["process"]
            }
            for order in orders
        ]
        response = {
            "insurer": insurer["insurer"],
            "insurer_id": insurer["insurer_id"],
            "orders": orders_list
        }
        return jsonify(response), 200
    else:
        return jsonify({"error": "No se encontraron datos para esta aseguradora"}), 404

# Consulta de presupuesto asociado a una orden
@app.route('/budget_by_order/<order_id>', methods=['GET'])
def get_budget_by_order(order_id):
    orders_collection = mongo.db.orders
    budgets_collection = mongo.db.budgets

    order = orders_collection.find_one({"orderId": int(order_id)})

    if order and "budgetId" in order:
        budget = budgets_collection.find_one({"budget_id": order["budgetId"]})

        if budget:
            budget_data = {
                "budget_id": budget["budget_id"],
                "concepts": budget["concepts"]
            }
            return jsonify({"orderId": order_id, "budget": budget_data}), 200
        else:
            return jsonify({"error": "Presupuesto no encontrado para esta orden"}), 404
    else:
        return jsonify({"error": "Orden no encontrada o sin presupuesto asociado"}), 404


# ---- FUNCIONALIDAD PARA ORDERS ----

# Ruta para agregar una nueva orden
@app.route('/add_order', methods=['POST'])
def add_order():
    data = request.get_json()
    order_document = {
        "adjuster": data.get("adjuster"),
        "claim": data.get("claim"),
        "onFloor": data.get("onFloor"),
        "policy": data.get("policy"),
        "clientId": data.get("clientId"),
        "brandModelId": data.get("brandModelId"),
        "year": data.get("year"),
        "licensePlates": data.get("licensePlates"),
        "color": data.get("color"),
        "deductible": data.get("deductible"),
        "crane": data.get("crane")
    }
    try:
        order_collection = mongo.db.orders
        order_id = order_collection.insert_one(order_document).inserted_id
        return jsonify({"message": "Orden creada con éxito", "order_id": str(order_id)}), 201
    except Exception as e:
        return jsonify({"error": f"Error al agregar la orden: {str(e)}"}), 500

# Ruta para listar todas las órdenes
@app.route('/orders', methods=['GET'])
def get_orders():
    order_collection = mongo.db.orders
    orders = order_collection.find()
    orders_list = [
        {
            "_id": str(order["_id"]),
            "adjuster": order["adjuster"],
            "claim": order["claim"],
            "onFloor": order["onFloor"],
            "policy": order["policy"],
            "clientId": order["clientId"],
            "brandModelId": order["brandModelId"],
            "year": order["year"],
            "licensePlates": order["licensePlates"],
            "color": order["color"],
            "deductible": order["deductible"],
            "crane": order["crane"]
        }
        for order in orders
    ]
    return jsonify(orders_list), 200

# Ruta para eliminar una orden por ID
@app.route('/delete_order/<order_id>', methods=['DELETE'])
def delete_order(order_id):
    try:
        order_collection = mongo.db.orders
        result = order_collection.delete_one({"_id": ObjectId(order_id)})
        if result.deleted_count > 0:
            return jsonify({"message": "Orden eliminada con éxito"}), 200
        return jsonify({"error": "Orden no encontrada"}), 404
    except Exception as e:
        return jsonify({"error": f"Error al eliminar la orden: {str(e)}"}), 500



@app.route('/makes', methods=['GET'])
def get_makes():
     makes = list(mongo.db.make.find({}))  # Selecciona todo, excluyendo el campo '_id'
     return jsonify(makes)
 
 
@app.route('/models/<slug>', methods=['GET'])
def get_models_by_make(slug):
    try:
        # Filtrar los modelos por la marca (slug)
        print(type(slug))
        print(slug)
        models = list(mongo.db.model.find({"id_make": int(slug)}))  # Excluir el campo _id
        if models:
            return jsonify(models), 200
        else:
            return jsonify({"error": f"No se encontraron modelos para la marca: {slug}"}), 404
    except Exception as e:
        return jsonify({"error": f"Hubo un problema al procesar la solicitud: {str(e)}"}), 500






if __name__ == '__main__':
    app.run(debug=True)

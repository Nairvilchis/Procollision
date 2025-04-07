import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});
  @override
  Widget build(BuildContext context) {
   return Scaffold(
      appBar: AppBar(
        title: const Text('Inicio de Sesión'),
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(70, 50,50, 70),
              
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Campo de correo electrónico.
            TextField(
              onChanged: (value) => controller.user.value = value,
              decoration: const InputDecoration(
                labelText: 'USUARIO',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.name,
            ),
            const SizedBox(height: 16),

            // Campo de contraseña.
            TextField(
              onChanged: (value) => controller.password.value = value,
              decoration: const InputDecoration(
                labelText: 'Contraseña',
                border: OutlineInputBorder(),
              ),
              obscureText: true,
                          ),
            const SizedBox(height: 24),

            // Botón de inicio de sesión.
            ElevatedButton(
              onPressed: () => controller.login(),
              child: const Text('Iniciar Sesión'),
              autofocus: true,
            ),

            // Ejemplo de enlace para registrarse.
          
          ],
        ),
      ),
    );
  }
}


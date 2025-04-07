import 'package:flutter/material.dart';



import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pro_collision/app/assets/models/apiservices.dart';

import 'app/routes/app_pages.dart';

void main() async {
  await GetStorage.init();
  WidgetsFlutterBinding.ensureInitialized();
  await Get.putAsync(()=>ApiService("http://127.0.0.1:5000").init());

  runApp(

    GetMaterialApp(
      title: "Application",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      debugShowCheckedModeBanner: false, 
        
         
    ),
  );
}

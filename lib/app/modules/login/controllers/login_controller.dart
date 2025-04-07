import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pro_collision/app/assets/models/apiservices.dart';
import 'package:pro_collision/app/assets/models/woorker.dart';

class LoginController extends GetxController {
  ApiService apiService = Get.find<ApiService>();
 

  //TODO: Implement LoginController

  final count = 0.obs;
  var user ="".obs;
  var password="".obs;




  void login()async{
    if(user.value !="" && password.value != ""){
      try{
        Woorker worker = Woorker.fromJson(await apiService.getWorkerByUser(user.value));
     
        if(user.value == worker.user && password.value ==worker.password ){
        GetStorage box = GetStorage();
        box.write("user", worker.user);
        box.write("workpermits", worker.workpermits);
        box.write("whatsapp_fst_msg","Bienvenido a Pro Collision,Este mensaje es prueba del bot de whatsapp");
        



        Get.offNamed("/home");

     }
    
      

      }catch(e){
      Get.snackbar("", e.toString());
      }
    

  
       
    }
  
  }
}

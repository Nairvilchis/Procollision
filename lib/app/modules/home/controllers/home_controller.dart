import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pro_collision/app/assets/models/woorker.dart';

class HomeController extends GetxController {
  

var user = "".obs;
final count = 0.obs;
var workpermits =Workpermits().obs;
var currentIndex = 0.obs;

 

@override
  void onInit() {
   
    super.onInit();
    final box = GetStorage();
user.value = box.read("user");
workpermits.value = box.read("workpermits");

       // TODO: implement onInit
    
  }

void changePage(int index){
  currentIndex.value=index;
update();
}
@override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
     if(Get.arguments != null){
      Get.snackbar("Error", "No Se Encontro La Orden Solicitada Verifique el Numero de Orden",duration: Duration(seconds: 5),snackPosition:SnackPosition.BOTTOM );
    }
  }

}

  
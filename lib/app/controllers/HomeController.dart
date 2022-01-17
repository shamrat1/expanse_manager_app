import 'package:expanse_manager/views/screens/create_transaction.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  RxBool loading = false.obs;

  @override
  void onInit() {
    super.onInit();

    // get current months overview
    // get recent 5 records
  }

  void gotoNewTransactionPage(String type) {
    Get.to(() => CreateTransaction(), arguments: type);
  }
}

import 'package:expanse_manager/app/models/HomeResponse.dart';
import 'package:expanse_manager/app/models/TransactionResponse.dart';
import 'package:expanse_manager/app/services/TransactionService.dart';
import 'package:expanse_manager/views/screens/create_transaction.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  RxBool loading = false.obs;
  Rx<HomeResponse> homeData = HomeResponse().obs;
  @override
  void onInit() {
    super.onInit();

    // get current months overview
    // get recent 5 records
    getHomeData();
  }

  void getHomeData() async {
    loading(true);
    homeData.value = await TransactionService().getHomeData();
    loading(false);
  }

  void gotoNewTransactionPage(String type) {
    Get.to(() => CreateTransaction(), arguments: type);
  }
}

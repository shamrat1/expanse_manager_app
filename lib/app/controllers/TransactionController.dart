import 'dart:async';

import 'package:expanse_manager/app/controllers/HomeController.dart';
import 'package:expanse_manager/app/helpers.dart/Globals.dart';
import 'package:expanse_manager/app/models/CategoryResponse.dart';
import 'package:expanse_manager/app/services/TransactionCategoryService.dart';
import 'package:expanse_manager/app/services/TransactionService.dart';
import 'package:expanse_manager/main.dart';
import 'package:expanse_manager/views/screens/home_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:expanse_manager/app/extensions/color_extension.dart';
import 'package:intl/intl.dart';

class TransactionController extends GetxController {
  String type = "";

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  Rx<String> selectedDate = "".obs;
  TextEditingController amountController = TextEditingController();
  TextEditingController entryDateController = TextEditingController();
  TextEditingController categoryController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  Rx<bool> loading = false.obs;
  RxList<Category> categories = <Category>[].obs;
  Rx<Category> selectedCategory = Category().obs;
  List<Category> dummyCats = [
    Category(
      id: 1,
      name: "House Rent",
      color: "#dbdbdb",
    ),
    Category(
      id: 2,
      name: "Monthly Groceries",
      color: "#ab345r",
    ),
    Category(
      id: 3,
      name: "Transportation",
      color: "#ff4eff",
    ),
  ];
  @override
  void onInit() async {
    super.onInit();
    type = Get.arguments;

    selectedDate.value = getFormattedDate(DateTime.now());
    loading(true);
    categories.value =
        await TransactionCategoryService().getTransactionCategory(type);
    loading(false);

    // Timer.periodic(const Duration(seconds: 2), (timer) {
    //   categories.value = dummyCats;
    //   loading(false);
    // });
  }

  void save() async {
    if (formKey.currentState!.validate()) {
      var data = {
        "entry_date": selectedDate.value,
        "amount": amountController.text,
        "description": descriptionController.text,
        "category_id": selectedCategory.value.id.toString()
      };
      loading(true);
      var response = await TransactionService()
          .postTransaction(data, income: type == "income");

      loading(false);
      if (response.statusCode == 201) {
        Get.snackbar("Success", "New $type added successfully.");
        HomeController controller = Get.find();
        controller.getHomeData();
        amountController.text = "";
        descriptionController.text = "";
        categoryController.text = "";
        entryDateController.text = "";
        Get.offUntil(MaterialPageRoute(builder: (ctx) => LandingPage()),
            (route) => false);
      } else if (response.statusCode == 422) {
        Get.snackbar("Warning", response.body);
      } else {
        print(response.statusCode);
        print(response.body);
        Get.snackbar(
            "Error", "Something Unexpected Happened. ${response.statusCode}");
      }
    }
  }

  void setDate() async {
    var now = DateTime.now();
    var date = await showDatePicker(
      context: Get.context!,
      initialDate: now,
      firstDate: now.subtract(const Duration(days: 60)),
      lastDate: now.add(const Duration(days: 60)),
    );

    if (date != null) {
      selectedDate.value = getFormattedDate(date);
    }
  }

  void setCategory(Category category) {
    print("setting category ${category.id}");
    selectedCategory(category);
    print("${selectedCategory.value.id} | ${selectedCategory.value.name}");
  }
}

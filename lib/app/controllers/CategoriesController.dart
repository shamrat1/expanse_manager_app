import 'dart:convert';

import 'package:expanse_manager/app/models/CategoryResponse.dart';
import 'package:expanse_manager/app/services/CategoryService.dart';
import 'package:expanse_manager/app/services/TransactionService.dart';
import 'package:expanse_manager/views/screens/category_page.dart';
import 'package:expanse_manager/views/screens/create_category.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class CategoriesController extends GetxController {
  Rx<CategoryResponse> categoryResponse = CategoryResponse().obs;
  Rx<bool> loading = false.obs;
  Rx<Category> selectedCategory = Category().obs;
  TextEditingController nameController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey();
  List<String> categoryTypes = [
    "income",
    "expanse",
    "todo",
  ];
  Rx<String> selectedType = "income".obs;
  Rx<String> selectedHexColor = "000000".obs;
  TextEditingController colorController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    _getResponse();
  }

  void _getResponse({int page = 1}) async {
    loading(true);
    categoryResponse.value =
        await CategoryService().getCategoryResponse(page: page);
    print(categoryResponse.value.total);
    loading(false);
  }

  void getToCreateCategroyPage({int? index}) {
    if (index != null) {
      var cat = categoryResponse.value.categories![index];
      selectedCategory.value = cat;
      nameController.text = cat.name!;
      selectedType.value = cat.type!;
      selectedHexColor.value = cat.color != null ? cat.color! : "";
    } else {
      selectedCategory.value = Category();
    }
    Get.to(() => CreateCategory());
  }

  void setSelectedType(String type) {
    selectedType.value = type;
  }

  void getColorPickPopup() async {
    showDialog(
        context: Get.context!,
        builder: (context) {
          return AlertDialog(
            title: Text("Pick a Color"),
            content: SingleChildScrollView(
              child: ColorPicker(
                  pickerColor: Theme.of(context).colorScheme.secondary,
                  onColorChanged: (value) => setColor(value)),
            ),
            actions: <Widget>[
              TextButton(
                  onPressed: () => Get.back(),
                  child: Text(
                    "Done",
                    style: TextStyle(color: Theme.of(context).accentColor),
                  )),
            ],
          );
        });
  }

  void setColor(Color color) {
    selectedHexColor.value = color.value.toRadixString(16).replaceAll("ff", "");
  }

  void getDeleteConfirmation(int index) {
    showDialog(
        context: Get.context!,
        builder: (ctx) {
          return AlertDialog(
            title: const Text(
              "Warning",
              style: TextStyle(
                color: Colors.red,
                fontSize: 16,
              ),
            ),
            content: Container(
              height: Get.height * .10,
              width: double.infinity,
              child: Center(
                child: Text(
                    "Are You Sure to Delete ${categoryResponse.value.categories![index].name}?"),
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Get.back(),
                child: const Text(
                  "No",
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 16,
                  ),
                ),
              ),
              TextButton(
                onPressed: () => _deleteCategory(index),
                child: const Text(
                  "Yes",
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          );
        });
  }

  void _deleteCategory(int index) async {
    loading(true);
    var cat = categoryResponse.value.categories![index];
    var response = await CategoryService().deleteCategory(cat.id!);

    if (response.statusCode == 200) {
      loading(false);
      Get.back();
      Get.snackbar("Success", "Category Deleted");

      _getResponse();
    } else if (response.statusCode == 422) {
      Get.back();

      loading(false);
      Get.snackbar("Error", "Operation not allowed.");
    } else {
      loading(false);
      print(response.statusCode);
      print(response.body);
      Get.snackbar("Error", "Something Went wrong. Try Again Later.");
    }
  }

  void save() async {
    if (formKey.currentState!.validate()) {
      var data = {
        "name": nameController.text,
        "type": selectedType.value,
        "color": selectedHexColor.value.contains("#")
            ? selectedHexColor.value
            : ("#" + selectedHexColor.value),
      };
      loading(true);
      var res = await CategoryService().storeCategories(data,
          id: selectedCategory.value.name != null
              ? selectedCategory.value.id
              : null);
      if (res.statusCode == 200) {
        Get.back();
        Get.snackbar("Success",
            "Category ${selectedCategory.value.name != null ? "Updated" : "Added"} Successfully.");
        loading(false);
        _getResponse();
      } else if (res.statusCode == 422) {
        print(res.body);
        loading(false);
      } else {
        print(res.body);
        print(res.statusCode);
        loading(false);
        throw Exception("Error");
      }
    }
  }
}

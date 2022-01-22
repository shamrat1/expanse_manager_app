import 'package:expanse_manager/app/models/CategoryResponse.dart';
import 'package:expanse_manager/app/services/CategoryService.dart';
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
  List<String> categoryTypes = [
    "income",
    "expanse",
    "todo",
  ];
  Rx<String> selectedType = "".obs;
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
      selectedCategory.value = categoryResponse.value.categories![index];
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

  void save() {}
}

import 'package:expanse_manager/app/controllers/CategoriesController.dart';
import 'package:expanse_manager/app/extensions/color_extension.dart';
import 'package:expanse_manager/views/widgets/custom_appbar.dart';
import 'package:expanse_manager/views/widgets/paperfly_loading.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({Key? key}) : super(key: key);

  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  CategoriesController controller = Get.put(CategoriesController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getCustomAppBar(title: "Categories"),
      body: Obx(() => Stack(
            children: [
              ListView.builder(
                itemCount:
                    controller.categoryResponse.value.categories?.length ?? 0,
                itemBuilder: (context, index) {
                  var category =
                      controller.categoryResponse.value.categories?[index];
                  return InkWell(
                    onTap: () =>
                        controller.getToCreateCategroyPage(index: index),
                    onLongPress: () => controller.getDeleteConfirmation(index),
                    child: Container(
                      margin: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 8),
                      padding: const EdgeInsets.symmetric(
                          vertical: 16, horizontal: 16),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey.shade400,
                              spreadRadius: 1,
                              blurRadius: 1,
                              offset: Offset(1, 1))
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(category!.name!),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8.0,
                              vertical: 5.0,
                            ),
                            margin: const EdgeInsets.symmetric(vertical: 5.0),
                            decoration: BoxDecoration(
                              color: category.color != null
                                  ? HexColor.fromHex(category.color!)
                                  : Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              category.type!.toUpperCase(),
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                fontStyle: FontStyle.italic,
                                letterSpacing: 1.5,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
              if (controller.loading.value) EMLoading(),
            ],
          )),
      floatingActionButton: FloatingActionButton(
        onPressed: () => controller.getToCreateCategroyPage(),
        child: Icon(Icons.add_rounded),
      ),
    );
  }
}

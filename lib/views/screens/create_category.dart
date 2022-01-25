import 'package:expanse_manager/app/controllers/CategoriesController.dart';
import 'package:expanse_manager/app/extensions/color_extension.dart';
import 'package:expanse_manager/views/widgets/paperfly_loading.dart';
import 'package:expanse_manager/views/widgets/submit_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreateCategory extends StatefulWidget {
  const CreateCategory({Key? key}) : super(key: key);

  @override
  _CreateCategoryState createState() => _CreateCategoryState();
}

class _CreateCategoryState extends State<CreateCategory> {
  CategoriesController controller = Get.find();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool isEdit = controller.selectedCategory.value.name != null;
    return Obx(() => Scaffold(
          appBar: AppBar(
            title: Text(
              isEdit
                  ? "Edit ${controller.selectedCategory.value.name}"
                  : "New Category",
              overflow: TextOverflow.ellipsis,
            ),
          ),
          body: Stack(
            children: [
              Form(
                key: controller.formKey,
                child: Container(
                  margin: const EdgeInsets.symmetric(
                      vertical: 8.0, horizontal: 8.0),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8),
                          child: TextFormField(
                            controller: controller.nameController,
                            decoration: const InputDecoration(
                              label: Text("Name"),
                              border: OutlineInputBorder(),
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Enter Category Name";
                              }
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8),
                          child: DropdownButtonFormField<String>(
                              decoration: const InputDecoration(
                                label: Text("Category Type"),
                                border: OutlineInputBorder(),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Select a Category Type";
                                }
                              },
                              value: controller.selectedType.value,
                              items: controller.categoryTypes
                                  .map(
                                    (e) => DropdownMenuItem(
                                      child: Text(e),
                                      value: e,
                                    ),
                                  )
                                  .toList(),
                              onChanged: (value) =>
                                  controller.setSelectedType(value!)),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8),
                          child: InkWell(
                            onTap: () => controller.getColorPickPopup(),
                            child: Container(
                              height: 56,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: 16,
                                  ),
                                  Container(
                                    padding: EdgeInsets.all(8),
                                    width: Get.width * 0.30,
                                    height: 30,
                                    decoration: BoxDecoration(
                                        color: HexColor.fromHex(
                                            controller.selectedHexColor.value),
                                        borderRadius: BorderRadius.circular(3)),
                                  ),
                                  SizedBox(
                                    width: 16,
                                  ),
                                  Text(controller.selectedHexColor.value),
                                ],
                              ),
                            ),
                          ),
                        ),

                        // Spacer(),
                        SubmitButton(callback: () => controller.save())
                      ],
                    ),
                  ),
                ),
              ),
              if (controller.loading.value) EMLoading(),
            ],
          ),
        ));
  }
}

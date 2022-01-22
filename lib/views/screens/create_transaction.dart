import 'package:expanse_manager/app/controllers/TransactionController.dart';
import 'package:expanse_manager/app/models/CategoryResponse.dart';
import 'package:expanse_manager/views/widgets/custom_appbar.dart';
import 'package:expanse_manager/views/widgets/paperfly_loading.dart';
import 'package:expanse_manager/views/widgets/submit_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreateTransaction extends StatefulWidget {
  const CreateTransaction({Key? key}) : super(key: key);

  @override
  _CreateTransactionState createState() => _CreateTransactionState();
}

class _CreateTransactionState extends State<CreateTransaction> {
  TransactionController controller = Get.put(TransactionController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getCustomAppBar(title: "Add ${controller.type.capitalize}"),
      body: Obx(() => Container(
            color: Colors.grey.shade100,
            child: Form(
              key: controller.formKey,
              child: Stack(
                children: [
                  Container(
                    margin: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8),
                          child: TextFormField(
                            controller: controller.amountController,
                            decoration: const InputDecoration(
                              label: Text("Amount"),
                              border: OutlineInputBorder(),
                            ),
                            keyboardType: TextInputType.number,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Amount is Required.";
                              }
                              if (double.tryParse(value) == null) {
                                return "Input Amount is not valid";
                              }
                              return null;
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8),
                          child: InkWell(
                            onTap: () => controller.setDate(),
                            child: Container(
                              height: 56,
                              width: Get.width - 32,
                              padding: EdgeInsets.only(left: 10),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey.shade500),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Entry Date: ${controller.selectedDate.value}",
                                style: TextStyle(color: Colors.black54),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8),
                          child: DropdownButtonFormField<Category>(
                              decoration: const InputDecoration(
                                label: Text("Category"),
                                border: OutlineInputBorder(),
                              ),
                              items: controller.categories
                                  .map(
                                    (e) => DropdownMenuItem(
                                      child: Text(e.name!),
                                      value: e,
                                    ),
                                  )
                                  .toList(),
                              onChanged: (category) =>
                                  controller.setCategory(category!)),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8),
                          child: TextFormField(
                            controller: controller.descriptionController,
                            decoration: const InputDecoration(
                              label: Text("Description"),
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ),
                        Spacer(),
                        SubmitButton(callback: () => controller.save()),
                      ],
                    ),
                  ),
                  if (controller.loading.value) const EMLoading(),
                ],
              ),
            ),
          )),
    );
  }
}

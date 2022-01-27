import 'package:expanse_manager/app/controllers/TodoController.dart';
import 'package:expanse_manager/app/models/CategoryResponse.dart';
import 'package:expanse_manager/views/widgets/custom_appbar.dart';
import 'package:expanse_manager/views/widgets/paperfly_loading.dart';
import 'package:expanse_manager/views/widgets/submit_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreateTodo extends StatefulWidget {
  const CreateTodo({Key? key}) : super(key: key);

  @override
  _CreateTodoState createState() => _CreateTodoState();
}

class _CreateTodoState extends State<CreateTodo> {
  TodoController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getCustomAppBar(title: "New Todo"),
      body: Obx(() => Container(
            padding: const EdgeInsets.all(8),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Form(
                  key: controller.formkey,
                  child: ListView(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8),
                        child: TextFormField(
                          controller: controller.taskController,
                          decoration: const InputDecoration(
                            label: Text("Task"),
                            border: OutlineInputBorder(),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Enter Task";
                            }
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8),
                        child: DropdownButtonFormField<Category>(
                            validator: (value) {
                              if (value == null) {
                                return "Select a Category to continue.";
                              }
                            },
                            // value: controller.selectedCategory.value,
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
                        child: InkWell(
                          onTap: () => controller.setReminderAt(),
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
                              "Reminder: ${controller.selectedDateTime.value}",
                              style: Theme.of(context).textTheme.bodyText1,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8),
                        child: TextFormField(
                          controller: controller.noteController,
                          maxLines: 4,
                          minLines: 1,
                          decoration: const InputDecoration(
                            label: Text("Note"),
                            border: OutlineInputBorder(),
                          ),
                          keyboardType: TextInputType.text,
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  child: SubmitButton(
                    callback: () => controller.saveTodo(),
                  ),
                  bottom: 0,
                ),
                if (controller.loading.value) EMLoading(),
              ],
            ),
          )),
    );
  }
}

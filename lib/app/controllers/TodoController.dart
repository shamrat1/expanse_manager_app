import 'package:expanse_manager/app/helpers.dart/Globals.dart';
import 'package:expanse_manager/app/models/CategoryResponse.dart';
import 'package:expanse_manager/app/models/TodoResponse.dart';
import 'package:expanse_manager/app/services/CategoryService.dart';
import 'package:expanse_manager/app/services/TodoService.dart';
import 'package:expanse_manager/views/screens/create_todo.dart';
import 'package:expanse_manager/views/screens/todo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TodoController extends GetxController {
  Rx<bool> loading = false.obs;

  Rx<TodoResponse> todoResponse = TodoResponse().obs;
  RxList<Todo> todos = <Todo>[].obs;
  List<Category> categories = [];
  TextEditingController taskController = TextEditingController();
  TextEditingController noteController = TextEditingController();
  Rx<String> selectedDateTime = "".obs;
  Rx<Category> selectedCategory = Category().obs;
  GlobalKey<FormState> formkey = GlobalKey();

  @override
  void onInit() {
    super.onInit();
    getTodos();
  }

  void getToNewTodoPage() {
    getCategories();
    Get.to(() => CreateTodo());
  }

  void getCategories() async {
    if (!(categories.length > 0)) {
      loading(true);
      var res = await CategoryService().getCategoryResponse(type: "todo");
      categories = res.categories ?? [];
      loading(false);
    }
  }

  void setCategory(Category category) {
    selectedCategory.value = category;
  }

  void setReminderAt() async {
    var selectedDate = await showDatePicker(
        context: Get.context!,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(Duration(days: 30)));

    var selectedTime = await showTimePicker(
        context: Get.context!, initialTime: TimeOfDay.now());
    if (selectedDate != null && selectedTime != null) {
      selectedDateTime.value = getFormattedDateTime(DateTime(
        selectedDate.year,
        selectedDate.month,
        selectedDate.day,
        selectedTime.hour,
        selectedTime.minute,
      ));
    }
  }

  void getTodos({int page = 1}) async {
    loading(true);
    todoResponse.value = await TodoService().getTodoResponse(page: page);
    // ignore: invalid_use_of_protected_member
    if(todoResponse.value.currentPage == 1){
      todos.value = todoResponse.value.todos!;
    }else{
      todos.value = [...todos.value, ...todoResponse.value.todos!];

    }
    loading(false);

  }

  void saveTodo() async {
    if(formkey.currentState!.validate()){
      Map<String, String> data = {
        "category_id" : selectedCategory.value.id.toString(),
        "task" : taskController.text,
        "note" : noteController.text,
        "reminder_at" : selectedDateTime.value,
      };
      loading(true);
      var response = await TodoService().storeTodo(data);
      print(response.statusCode);
      print(response.body);

      if(response.statusCode == 200){
        Get.snackbar("Success", "New Todo added successfully.");
        loading(false);
        // Get.offUntil(MaterialPageRoute(builder: (ctx) => TodoPage()), (route) => false);
        getTodos();
        Navigator.of(Get.context!).pop();
      }else{
        loading(false);
        throw Exception("Error");
      }

    }
  }
}

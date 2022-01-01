import 'package:expanse_manager/app/controllers/HomeController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HomeController controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Obx(() {
          if (controller.loading.value) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  height: Get.height * .30,
                  width: Get.width,
                  color: Colors.red,
                  child: Center(child: Text("Sometjing")),
                ),
                Container(
                  height: Get.height * .10,
                  width: Get.width,
                  padding: EdgeInsets.symmetric(vertical: 8),
                  child: LayoutBuilder(builder: (context, constraint) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () {},
                          child: Container(
                            height: Get.height * 0.06,
                            width: constraint.maxWidth * .50 - 8,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.blue,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.lightBlueAccent,
                                  blurRadius: 3,
                                  spreadRadius: 1,
                                  offset: Offset(1, 1),
                                )
                              ],
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.add),
                                Text("Income"),
                              ],
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {},
                          child: Container(
                            height: Get.height * 0.06,
                            width: constraint.maxWidth * .50 - 8,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.red[500],
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.redAccent,
                                  blurRadius: 3,
                                  spreadRadius: 1,
                                  offset: Offset(1, 1),
                                )
                              ],
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.remove),
                                Text("Expanse"),
                              ],
                            ),
                          ),
                        ),
                      ],
                    );
                  }),
                ),
                Container(
                    height:
                        Get.height * .60 - MediaQuery.of(context).padding.top,
                    width: Get.width,
                    // color: Colors.greenAccent,
                    child: ListView.builder(
                        itemCount: 5,
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Text("Something"),
                            subtitle: Text("Cate"),
                            trailing: Text(
                              "3 Days Ago",
                              style: TextStyle(color: Color(0xffdbdbdb)),
                            ),
                          );
                        })),
              ],
            ),
          );
        }),
      ),
    );
  }
}

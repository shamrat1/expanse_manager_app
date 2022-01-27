import 'dart:math';

import 'package:expanse_manager/app/controllers/HomeController.dart';
import 'package:expanse_manager/views/screens/todo.dart';
import 'package:expanse_manager/views/screens/transactions_page.dart';
import 'package:expanse_manager/views/widgets/custom_appbar.dart';
import 'package:expanse_manager/views/widgets/paperfly_loading.dart';
import 'package:expanse_manager/views/widgets/transaction_item_tile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HomeController controller = Get.put(HomeController());
  List<_ChartData>? _incomeData;
  List<_ChartData>? _expanseData;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getCustomAppBar(title: "Expanse Manager"),
      body: Container(
        margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Obx(() {
          _getChartData();
          if (controller.loading.value) {
            return const Center(
              child: const EMLoading(),
            );
          }
          return SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  height: Get.height * .30,
                  width: Get.width - 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                          color: Theme.of(context)
                              .colorScheme
                              .primaryVariant
                              .withOpacity(0.3),
                          offset: Offset(1, 1),
                          blurRadius: 2,
                          spreadRadius: 2)
                    ],
                  ),
                  // color: Colors.amber,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    child: _buildAnimationSplineChart(),
                  ),
                ),
                Container(
                  height: Get.height * .10,
                  width: Get.width,
                  padding: EdgeInsets.symmetric(vertical: 8),
                  child: LayoutBuilder(builder: (context, constraint) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 2.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap: () =>
                                controller.gotoNewTransactionPage("income"),
                            child: Container(
                              height: Get.height * 0.06,
                              width: constraint.maxWidth * .50 - 10,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.lightBlueAccent,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.lightBlueAccent.shade100,
                                    blurRadius: 3,
                                    spreadRadius: 1,
                                    offset: Offset(1, 1),
                                  )
                                ],
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Icon(Icons.add),
                                  Text("Income"),
                                ],
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () =>
                                controller.gotoNewTransactionPage("expense"),
                            child: Container(
                              height: Get.height * 0.06,
                              width: constraint.maxWidth * .50 - 10,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.redAccent,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.redAccent.shade200,
                                    blurRadius: 3,
                                    spreadRadius: 1,
                                    offset: Offset(1, 1),
                                  )
                                ],
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Icon(Icons.remove),
                                  Text("Expanse"),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Recent expanses",
                        style: TextStyle(
                          color: Color(0xffdbdbdb),
                          fontSize: 14,
                        ),
                      ),
                      InkWell(
                        onTap: () => Get.to(TransactionsPage()),
                        child: const Text(
                          "View",
                          style:
                              TextStyle(color: Color(0xffdbdbdb), fontSize: 14),
                        ),
                      )
                    ],
                  ),
                ),
                if (controller.homeData.value.recentExpenses != null)
                  Container(
                    // height: Get.height * .60 - MediaQuery.of(context).padding.top,
                    width: Get.width,
                    // color: Colors.greenAccent,
                    child: Column(
                      children: [
                        for (var i = 0;
                            i <
                                controller
                                    .homeData.value.recentExpenses!.length;
                            i++)
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4.0),
                            child: TransactionItemTile(
                              type: TransactionType.EXPANSE,
                              transaction:
                                  controller.homeData.value.recentExpenses![i],
                            ),
                          ),
                      ],
                    ),
                  ),
              ],
            ),
          );
        }),
      ),
    );
  }

  /// get the spline chart sample with dynamically updated data points.
  SfCartesianChart _buildAnimationSplineChart() {
    return SfCartesianChart(
      plotAreaBorderWidth: 0,
      backgroundColor: Theme.of(context).colorScheme.background,
      title: ChartTitle(text: "Monthly Income Expanse View"),
      primaryXAxis: NumericAxis(
        name: "Expenses",
        majorGridLines: const MajorGridLines(width: 0),
        isVisible: true,
      ),
      primaryYAxis: NumericAxis(
        name: "Income",
        majorTickLines: const MajorTickLines(color: Colors.transparent),
        axisLine: const AxisLine(width: 0),
        minimum: 0,
        maximum:
            double.parse(controller.homeData.value.incomeTotal ?? '0') + 10000,
        isVisible: true,
      ),

      // palette: [
      //   Colors.blue.shade300,
      //   Colors.red.shade300,
      // ],
      series: _getDefaultSplineSeries(),
    );
  }

  /// get the spline series sample with dynamically updated data points.
  List<AreaSeries<_ChartData, num>> _getDefaultSplineSeries() {
    return <AreaSeries<_ChartData, num>>[
      AreaSeries<_ChartData, num>(
          color: Colors.blue.withOpacity(0.5),
          dataSource: _incomeData!,
          xValueMapper: (_ChartData sales, _) => sales.x,
          yValueMapper: (_ChartData sales, _) => sales.y,
          markerSettings: const MarkerSettings(isVisible: false),
          onPointTap: (ChartPointDetails details) {
            Get.snackbar("Income", details.pointIndex.toString(),
                snackPosition: SnackPosition.BOTTOM);
          }),
      AreaSeries<_ChartData, num>(
        color: Colors.red.withOpacity(0.5),
        dataSource: _expanseData!,
        xValueMapper: (_ChartData sales, _) => sales.x,
        yValueMapper: (_ChartData sales, _) => sales.y,
        markerSettings: const MarkerSettings(isVisible: false),
      ),
    ];
  }

  @override
  void dispose() {
    _incomeData!.clear();
    _expanseData!.clear();
    super.dispose();
  }

  //Get the random data points
  void _getChartData() {
    var income = double.parse(controller.homeData.value.incomeTotal ?? '0');
    var expanses = controller.homeData.value.expenseArray ?? [];
    print(controller.homeData.value.expenseTotal);
    print(income);
    _incomeData = <_ChartData>[];
    var totalExpanse = 0.0;
    _expanseData = <_ChartData>[];

    for (int i = 0; i < expanses.length; i++) {
      income = income - double.parse(expanses[i]);
      totalExpanse += double.parse(expanses[i]);
      _incomeData!.add(_ChartData(i, income.toInt()));
      _expanseData!.add(_ChartData(i, totalExpanse.toInt()));
    }
  }
}

class _ChartData {
  _ChartData(this.x, this.y);
  final int x;
  final int y;
}

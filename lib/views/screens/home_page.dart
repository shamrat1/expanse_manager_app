import 'dart:math';

import 'package:expanse_manager/app/controllers/HomeController.dart';
import 'package:expanse_manager/views/screens/todo.dart';
import 'package:expanse_manager/views/screens/transactions_page.dart';
import 'package:expanse_manager/views/widgets/custom_appbar.dart';
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
    _getChartData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getCustomAppBar(title: "Expanse Manager"),
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
                  // color: Colors.amber,
                  child: _buildAnimationSplineChart(),
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
                              boxShadow: const [
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
                              children: const [
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
                              boxShadow: const [
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
                              children: const [
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
                  margin: EdgeInsets.symmetric(vertical: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Recent Income and expanses",
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
                Container(
                  // height: Get.height * .60 - MediaQuery.of(context).padding.top,
                  width: Get.width,
                  // color: Colors.greenAccent,
                  child: Column(
                    children: [
                      for (var i = 0; i < 4; i++)
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4.0),
                          child: TransactionItemTile(
                            type: i % 2 == 0
                                ? TransactionType.INCOME
                                : TransactionType.EXPANSE,
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
      // backgroundColor: Colors.amber,
      title: ChartTitle(text: "Monthly Income Expanse View"),
      primaryXAxis: NumericAxis(
          majorGridLines: const MajorGridLines(width: 0), isVisible: false),
      primaryYAxis: NumericAxis(
        majorTickLines: const MajorTickLines(color: Colors.transparent),
        axisLine: const AxisLine(width: 0),
        minimum: 0,
        maximum: 10000,
        isVisible: false,
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
    var income = 7500;
    var expanses = [
      20,
      30,
      500,
      700,
      163,
      5,
      1600,
      20,
      30,
      500,
      700,
      163,
      5,
      1600
    ];

    _incomeData = <_ChartData>[];
    var totalExpanse = 0;
    _expanseData = <_ChartData>[];

    for (int i = 0; i < expanses.length; i++) {
      income = income - expanses[i];
      totalExpanse += expanses[i];
      _incomeData!.add(_ChartData(i, income));
      _expanseData!.add(_ChartData(i, totalExpanse));
    }
  }
}

class _ChartData {
  _ChartData(this.x, this.y);
  final int x;
  final int y;
}

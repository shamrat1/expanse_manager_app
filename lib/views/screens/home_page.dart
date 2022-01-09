import 'dart:math';

import 'package:expanse_manager/app/controllers/HomeController.dart';
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
      appBar: AppBar(
        title: Text('Expanse'),
        centerTitle: true,
      ),
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
                    height:
                        Get.height * .60 - MediaQuery.of(context).padding.top,
                    width: Get.width,
                    // color: Colors.greenAccent,
                    child: ListView.builder(
                        itemCount: 5,
                        itemBuilder: (context, index) {
                          // ignore: prefer_const_constructors
                          return ListTile(
                            title: const Text("Something"),
                            subtitle: Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 3,
                                    horizontal: 10,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.amber,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: const Text(
                                    "Cate",
                                    style: TextStyle(fontSize: 9),
                                  ),
                                ),
                              ],
                            ),
                            trailing: const Text(
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

  /// get the random value
  int _getRandomInt(int min, int max) {
    final Random random = Random();
    return min + random.nextInt(max - min);
  }

  /// get the spline chart sample with dynamically updated data points.
  SfCartesianChart _buildAnimationSplineChart() {
    return SfCartesianChart(
        plotAreaBorderWidth: 0,
        primaryXAxis:
            NumericAxis(majorGridLines: const MajorGridLines(width: 0)),
        primaryYAxis: NumericAxis(
            majorTickLines: const MajorTickLines(color: Colors.transparent),
            axisLine: const AxisLine(width: 0),
            minimum: 0,
            maximum: 100),
        series: _getDefaultSplineSeries());
  }

  /// get the spline series sample with dynamically updated data points.
  List<SplineSeries<_ChartData, num>> _getDefaultSplineSeries() {
    return <SplineSeries<_ChartData, num>>[
      SplineSeries<_ChartData, num>(
        dataSource: _incomeData!,
        xValueMapper: (_ChartData sales, _) => sales.x,
        yValueMapper: (_ChartData sales, _) => sales.y,
        markerSettings: const MarkerSettings(isVisible: true),
      ),
      SplineSeries<_ChartData, num>(
        dataSource: _expanseData!,
        xValueMapper: (_ChartData sales, _) => sales.x,
        yValueMapper: (_ChartData sales, _) => sales.y,
        markerSettings: const MarkerSettings(isVisible: true),
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
    _incomeData = <_ChartData>[];
    for (int i = 0; i < 11; i++) {
      _incomeData!.add(_ChartData(i, _getRandomInt(15, 85)));
    }
    _expanseData = <_ChartData>[];
    for (int i = 0; i < 11; i++) {
      _expanseData!.add(_ChartData(i, _getRandomInt(5, 80)));
    }
  }
}

class _ChartData {
  _ChartData(this.x, this.y);
  final int x;
  final int y;
}

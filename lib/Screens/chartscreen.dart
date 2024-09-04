import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../Models/stock.dart';
import '../Services/staticdata.dart';

class ChartScreen extends StatefulWidget {
  final Stock stock;

  ChartScreen({required this.stock});

  @override
  _ChartScreenState createState() => _ChartScreenState();
}

class _ChartScreenState extends State<ChartScreen> {
  int _timeFrame = 1; // 1 day, 2 weeks, 3 months

  void _updateTimeFrame(int timeFrame) {
    setState(() {
      _timeFrame = timeFrame;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.stock.symbol),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: ToggleButtons(
                isSelected: [
                  _timeFrame == 1,
                  _timeFrame == 2,
                  _timeFrame == 3,
                ],
                onPressed: (int index) {
                  _updateTimeFrame(index + 1);
                },
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text('1 day'),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text('1 week'),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text('1 month'),
                  ),
                ],
                borderRadius: BorderRadius.circular(10.0),
                color: Colors.blueGrey,
                selectedColor: Colors.white,
                fillColor: Colors.blueAccent,
                splashColor: Colors.blue,
                highlightColor: Colors.blue.withOpacity(0.2),
                borderColor: Colors.blueGrey,
              ),
            ),
            Container(
              height: 550,
              width: 450,
              padding: const EdgeInsets.fromLTRB(8.0,40,8,30),
              child: LineChart(
                LineChartData(
                  lineBarsData: [
                    LineChartBarData(
                      spots: StaticStockData.getChartData(widget.stock.symbol, _timeFrame),
                      isCurved: true,
                      barWidth: 3,
                      belowBarData: BarAreaData(show: false),
                      color: Colors.orange,
                      dotData: FlDotData(
                        show: true,
                      ),
                      aboveBarData: BarAreaData(
                        show: true,
                        gradient: LinearGradient(
                          colors: [
                            Colors.orange.withOpacity(0.2),
                            Colors.transparent
                          ],
                          stops: [0.5, 1.0],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                      ),
                    ),
                  ],
                  titlesData: FlTitlesData(
                    show: true,
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, meta) {
                          return Text('');
                        },
                      ),
                    ),
                    rightTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 42,
                        getTitlesWidget: (value, meta) {

                          if (value == meta.min || value == meta.max) {
                            return const SizedBox.shrink();
                          }
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Text('${value.toStringAsFixed(1)}'),
                          );
                        },
                        interval: _getIntervaly(),
                      ),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        interval: _getInterval(),
                        getTitlesWidget: (value, meta) {
                          if (_timeFrame == 1) {
                            int hours = value.toInt() + 9;
                            if (hours >= 9 && hours <= 15) {
                              return Text('${hours.toString().padLeft(2, '0')}:00');
                            }
                            return Container();
                          } else if (_timeFrame == 2) {
                            return Text('${value.toInt()}d');
                          } else {
                            int weekNumber = (value.toInt() ~/ 7) + 1;
                            return Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Text('${weekNumber}w'),
                            );
                          }
                        },
                      ),
                    ),
                  ),
                  borderData: FlBorderData(
                    show: true,
                    border: Border.all(color: Colors.grey, width: 1),
                  ),
                  gridData: FlGridData(
                    show: true,
                    drawVerticalLine: true,
                    horizontalInterval: 10,
                    verticalInterval: 1,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(13,50,13,20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    height: 50,
                    width: 150,
                    child: ElevatedButton(
                      onPressed: () {
                        // Add to Cart functionality
                      },
                      child: Text('SELL',
                        style: TextStyle(
                            color: Colors.white
                        ),),
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          backgroundColor: Colors.redAccent

                      ),
                    ),
                  ),
                  SizedBox(
                    height: 50,
                    width: 150,

                    child: ElevatedButton(
                      onPressed: () {
                        // Add to Cart functionality
                      },
                      child: Text('BUY',
                        style: TextStyle(
                            color: Colors.white
                        ),),
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          backgroundColor: Colors.green

                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }


  double _getInterval() {
    if (_timeFrame == 1) {
      return 2.0;
    } else if (_timeFrame == 2) {
      return 2.0;
    } else {
      return 8.0;
    }
  }
  double _getIntervaly() {
    if (_timeFrame == 1) {
      return 1.0;
    } else if (_timeFrame == 2) {
      return 2.0;
    } else {
      return 2.0;
    }
  }
}

import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:stock_trading/Models/stock.dart';


class StaticStockData {
  static List<Stock> get stocks => [
    Stock('AAPL', 100.0, 2.5),
    Stock('GOOG', 550.0, -1.2),
    Stock('MSFT', 150.0, 3.1),
    Stock('RVNL', 598.75, -1.42),
    Stock('GAIL', 237.69, 2.49),
  ];

  static List<FlSpot> getChartData(String symbol, int timeFrame) {
    double basePrice = 100.0; // Base price for static data
    switch (symbol) {
      case 'AAPL':
        basePrice =100.0;
        break;
      case 'GOOG':
        basePrice = 550.0;
        break;
      case 'MSFT':
        basePrice = 150.0;
        break;
      case 'RVNL':
        basePrice = 598.75;
        break;
      case 'GAIL':
        basePrice = 237.69;
        break;
    }

    List<FlSpot> spots = [];
    Random random = Random();
    double currentPrice = basePrice;

    switch (timeFrame) {
      case 1: // 1 day (7 points representing hours)
        for (int i = 0; i < 7; i++) {
          double change = random.nextDouble() * 5 - 2.5;
          currentPrice += change;
          spots.add(FlSpot(i.toDouble(), currentPrice));
        }
        break;
      case 2: // 1 week (7 points representing days)
        for (int i = 0; i < 7; i++) {
          double change = random.nextDouble() * 10 - 5;
          currentPrice += change;
          spots.add(FlSpot(i.toDouble(), currentPrice));
        }
        break;
      case 3: // 1 month (30 points representing days)
        for (int i = 0; i < 30; i++) {
          double change = random.nextDouble() * 15 - 7.5;
          currentPrice += change;
          spots.add(FlSpot(i.toDouble(), currentPrice));
        }
        break;
    }

    return spots;
  }
}

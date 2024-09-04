import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stock_trading/Screens/chartscreen.dart';
import '../Models/stock.dart';
import 'addstock.dart';

class WatchList extends StatefulWidget {
  const WatchList({super.key});

  @override
  State<WatchList> createState() => _WatchListState();
}

class _WatchListState extends State<WatchList> {
  List<String> titles = <String>['Watchlist 1', 'Watchlist 2'];
  List<Stock> _stocksWatchlist1 = [];
  List<Stock> _stocksWatchlist2 = [];

  void _addStock(int watchlistIndex) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AddStockScreen()),
    ).then((stock) {
      if (stock != null) {
        setState(() {
          if (watchlistIndex == 0) {
            _stocksWatchlist1.add(stock);
          } else if (watchlistIndex == 1) {
            _stocksWatchlist2.add(stock);
          }
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    int tabsCount = 2;
    return DefaultTabController(
      initialIndex: 0,
      length: tabsCount,
      child: Scaffold(
        appBar: AppBar(
          title: Text('WatchList'),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.keyboard_arrow_down_outlined, size: 30),
              onPressed: () {},
            ),
          ],
          scrolledUnderElevation: 4.0,
          bottom: TabBar(
            tabs: <Widget>[
              Tab(
                text: titles[0],
              ),
              Tab(
                text: titles[1],
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            buildWatchlist(0, _stocksWatchlist1),
            buildWatchlist(1, _stocksWatchlist2),
          ],
        ),
      ),
    );
  }

  // Function to build watchlist UI
  Widget buildWatchlist(int watchlistIndex, List<Stock> stocksList) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: GestureDetector(
            onTap: () => _addStock(watchlistIndex),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 1,
                    blurRadius: 5,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                child: Row(
                  children: [
                    Icon(Icons.search, color: Colors.blueAccent),
                    SizedBox(width: 10),
                    Text('Search for a stock', style: TextStyle(color: Colors.blueAccent)),
                  ],
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: ListView.separated(
            itemCount: stocksList.length,
            separatorBuilder: (context, index) => Divider(
              color: Colors.grey[300],
              thickness: 1,
            ),
            itemBuilder: (context, index) {
              final stock = stocksList[index];
              return ListTile(
                contentPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 5.0),
                title: Text(stock.symbol, style: TextStyle(fontWeight: FontWeight.bold)),
                trailing: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      '${stock.currentPrice}',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.redAccent,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text('(${stock.percentageChange}%)', style: TextStyle(color: Colors.grey[600])),
                  ],
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ChartScreen(stock: stock),
                    ),
                  );
                },
                onLongPress: () {
                  _showDeleteDialog(context, stocksList, index);
                },
              );
            },
          ),
        ),
      ],
    );
  }


  // Function to show delete dialog
  void _showDeleteDialog(BuildContext context, List<Stock> stocksList, int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Delete Item', style: TextStyle(fontWeight: FontWeight.bold)),
          content: Text('Are you sure you want to delete this item?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('Cancel', style: TextStyle(color: Colors.blueAccent)),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  stocksList.removeAt(index);
                });
                Navigator.of(context).pop();
              },
              child: Text('Delete', style: TextStyle(color: Colors.redAccent)),
            ),
          ],
        );
      },
    );
  }
}
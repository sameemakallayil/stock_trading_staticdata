import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Models/stock.dart';

class AddStockScreen extends StatefulWidget {
  const AddStockScreen({super.key});

  @override
  State<AddStockScreen> createState() => _AddStockScreenState();
}

class _AddStockScreenState extends State<AddStockScreen> {
  final _searchController = TextEditingController();
  List<Stock> _allStocks = [
    Stock('AAPL', 100.0, 2.5),
    Stock('GOOG', 550.0, -1.2),
    Stock('MSFT', 150.0, 3.1),
    Stock('RVNL', 598.75, -1.42),
    Stock('GAIL', 237.69, 2.49),
  ];
  List<Stock> _searchResults = [];

  @override
  void initState() {
    super.initState();
    _searchResults = _allStocks; // Initialize with all stocks
  }

  void _searchStocks(String query) {
    setState(() {
      if (query.isEmpty) {
        _searchResults = _allStocks;
      } else {
        _searchResults = _allStocks
            .where((stock) =>
            stock.symbol.toLowerCase().contains(query.toLowerCase()))
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Stock'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: 'Search for a stock',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                suffixIcon: IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () => _searchStocks(_searchController.text),
                ),
              ),
              onChanged: _searchStocks, // Update results as user types
            ),
            SizedBox(height: 16),
            Expanded(
              child: ListView.separated(
                itemCount: _searchResults.length,
                separatorBuilder: (context, index) => Divider(color: Colors.grey[300]),
                itemBuilder: (context, index) {
                  final stock = _searchResults[index];
                  return ListTile(
                    contentPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 3.0),
                    title: Text(stock.symbol, style: TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text(
                      '${stock.currentPrice} (${stock.percentageChange}%)',
                      style: TextStyle(color: Colors.red),
                    ),
                    trailing: IconButton(
                      icon: Icon(Icons.add, color: Colors.green),
                      onPressed: () {
                        Navigator.pop(context, stock);
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stock_trading/Screens/portfolio.dart';
import 'package:stock_trading/Screens/watchlist.dart';

import 'account.dart';
import 'bids.dart';
import 'orders.dart';

class DashBoard extends StatefulWidget {
  const DashBoard({super.key});

  @override
  State<DashBoard> createState() => _DashBoardState();
}


class _DashBoardState extends State<DashBoard> {
  PageController pageController=PageController(initialPage: 0);
  List<Widget> screens=[
    WatchList(),
    Orders(),
    Portfolio(),
    Bids(),
    Account(),
  ];
  int currentPageIndex = 0;
  void _onItemTapped(int index) {
    setState(() {
      currentPageIndex = index;
      pageController.jumpToPage(index);

    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: PageView(
        controller: pageController,
        children: screens,
        onPageChanged: (int index){
          setState(() {
            currentPageIndex = index;

          });
    },
        physics: NeverScrollableScrollPhysics(),
    ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.bookmark_border),
            label: 'WatchList',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list_alt_outlined),
            label: 'Orders',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_bag_outlined),
            label: 'Portfolio',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.money),
            label: 'Bids',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle_outlined,),
            label: 'Account',
          ),
        ],
        currentIndex: currentPageIndex,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.black,
        showUnselectedLabels: true,
        onTap: _onItemTapped,
      ),
    );
  }
}

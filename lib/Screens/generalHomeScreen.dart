import 'package:crush/Constants/constants.dart';
import 'package:crush/Model/coinsModel.dart';
import 'package:crush/Model/myAccountModel.dart';
import 'package:crush/Services/coinsServices.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'callhistoryPg.dart';
import 'favouritesPg.dart';
import 'homePg.dart';
import 'myAccountPg.dart';

class generalHomeScreen extends StatefulWidget {
  final String user_id;
  final int selectedindex;
  const generalHomeScreen({
    Key? key,
    this.selectedindex = 0,
    required this.user_id,
  }) : super(key: key);
  @override
  _generalHomeScreenState createState() => _generalHomeScreenState();
}

class _generalHomeScreenState extends State<generalHomeScreen> {
  late Future<Coins> coins;

  late MyAccount myAccount;
  bool _loading = false;

  late int _selectedIndex = widget.selectedindex;
  late String user_id = widget.user_id;
  Color bottom = Colors.white;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  List<Widget> _pages() => <Widget>[
        homePg(user_id: user_id),
        favouritesPg(
          user_id: user_id,
        ),
        callHistoryPg(
          user_id: user_id,
        ),
        myAccountPg(
          user_id: user_id,
        ),
      ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: (_selectedIndex == 0) ? true : false,
      resizeToAvoidBottomInset: false,
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.red,
        unselectedItemColor: (_selectedIndex == 0)
            ? Colors.white
            : Color(0xff0B0D0F).withOpacity(0.4),
        selectedItemColor: (_selectedIndex == 0) ? Colors.white : appThemeColor,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            backgroundColor:
                (_selectedIndex == 0) ? Colors.transparent : bottom,
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            backgroundColor:
                (_selectedIndex == 0) ? Colors.transparent : bottom,
            icon: Icon(Icons.favorite),
            label: 'Favourites',
          ),
          BottomNavigationBarItem(
            backgroundColor:
                (_selectedIndex == 0) ? Colors.transparent : bottom,
            icon: Icon(Icons.call),
            label: 'Calls',
          ),
          BottomNavigationBarItem(
            backgroundColor:
                (_selectedIndex == 0) ? Colors.transparent : bottom,
            icon: Icon(Icons.person),
            label: 'Accounts',
          ),
          // BottomNavigationBarItem(
          //   icon: Icon(Icons.chat),
          //   label: 'Chats',
          // ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
      body: Stack(
        children: [
          Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                  // height: MediaQuery.of(context).size.height * 0.9,
                  child: Expanded(child: _pages().elementAt(_selectedIndex))),
              Divider(
                height: 1,
                color: Colors.grey,
              ),
            ],
          ),
          // Align(
          //   alignment: Alignment.bottomCenter,
          //   child: Theme(
          //     data: Theme.of(context).copyWith(
          //         canvasColor: (_selectedIndex == 0)
          //             ? Colors.transparent
          //             : Colors.white),
          //     child: ,
          //   ),
          // ),
        ],
      ),
    );
  }
}

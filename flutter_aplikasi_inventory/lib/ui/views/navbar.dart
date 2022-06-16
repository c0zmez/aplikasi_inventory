import 'package:aplikasi_inventory/constants/color.dart';
import 'package:aplikasi_inventory/ui/views/navbars/add_edit_item_view.dart';
import 'package:aplikasi_inventory/ui/views/navbars/inventory_list_view.dart';
import 'package:flutter/material.dart';

import 'navbars/dashboard_view.dart';

class Navbar extends StatefulWidget {
  const Navbar({Key? key}) : super(key: key);

  @override
  _NavbarState createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {
  int _selectedNavbar = 0;

  final List<Widget> content = [
    const DashboardView(),
    const InventoryListView(),
  ];

  void _changeSelectedNavbar(int index) {
    setState(() {
      _selectedNavbar = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorWhite2,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedNavbar,
        onTap: _changeSelectedNavbar,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            backgroundColor: colorWhite2,
            icon: Icon(Icons.dashboard_outlined),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
              backgroundColor: colorWhite2,
              icon: Icon(Icons.list),
              label: 'List Barang'
          ),
        ],
        selectedLabelStyle: const TextStyle(
          fontSize: 15,
        ),
        backgroundColor: colorWhite1,
        iconSize: 30,
        selectedItemColor: colorGreen,
        unselectedItemColor: colorGrey,
        showUnselectedLabels: false,
        showSelectedLabels: true,
        elevation: 10,
      ),
      floatingActionButton: Container(
        padding: const EdgeInsets.all(10),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(50)),
          color: colorWhite1
        ),
        height: 90,
        child: Container(
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(15))
          ),
          child: FittedBox(
            child: FloatingActionButton(
              child: const Icon(Icons.add, color: colorWhite1, size: 35,),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => AddEditItem()));
              },
              backgroundColor: colorGreen,
              elevation: 0,
            ),
          ),
        ),
      ),floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: content[_selectedNavbar],
    );
  }
}

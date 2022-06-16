import 'package:aplikasi_inventory/ui/views/navbar.dart';
import 'package:aplikasi_inventory/ui/views/navbars/add_edit_item_view.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Aplikasi Inventory',
      showSemanticsDebugger: false,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: Navbar(),
      routes: {
        '/edit-product': (context) => const AddEditItem(),
      },
    );
  }
}
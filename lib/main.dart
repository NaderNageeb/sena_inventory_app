// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_import

import 'package:flutter/material.dart';
import 'package:sena_inventory/app/AllPurchase.dart';
import 'package:sena_inventory/app/addpurchase.dart';
import 'package:sena_inventory/app/addsupplier.dart';
import 'package:sena_inventory/app/auth/login.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import 'app/add_category.dart';
import 'app/add_item.dart';
import 'app/add_user.dart';
import 'app/addcat.dart';
import 'app/all_expenses.dart';
import 'app/bills.dart';
import 'app/cart.dart';
import 'app/Category.dart';
import 'app/edit_item.dart';
import 'app/expenses.dart';
import 'app/home.dart';
import 'app/inventory.dart';
import 'app/reports.dart';
import 'app/reports/donebill.dart';
import 'app/reports/expences_report.dart';
import 'app/reports/pending_bill.dart';
import 'app/suppliers.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app/test.dart';
import 'app/users.dart';

late SharedPreferences sharedPref;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  sharedPref = await SharedPreferences.getInstance();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sena',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        iconTheme: IconThemeData(
          // color: Color.fromARGB(255, 107, 131, 182),
          color: Color(0xFF79AED1),
        ),

        // useMaterial3: true,
        colorScheme: ColorScheme(
          brightness: Brightness.light,
          // primary: Color.fromARGB(255, 107, 131, 182),
          primary: Color(0xFF79AED1),
          onPrimary: Colors.white,
          secondary: Colors.white,
          onSecondary: Colors.black,
          error: Colors.red,
          onError: Colors.white,
          background: Colors.white,
          onBackground: Colors.black,
          surface: Colors.white,
          onSurface: Colors.black,
        ),
      ),
      initialRoute: sharedPref.getString("user_id") == null ? "login" : "home",
      // initialRoute: "/",
      routes: {
        'additem': (context) => AddItem(),
        'inventory': (context) => Inventory(),
        'category': (context) => Category(),
        'suppliers': (context) => Suppliers(),
        'expenses': (context) => Expenses(),
        'home': (context) => HomeScreen(),
        'login': (context) => Login(),
        'add_category': (context) => AddCategory(),
        'reports': (context) => Reports(),
        'view_expenses': (context) => ViewExpenses(),
        'AddSuppliers': (context) => AddSuppliers(),
        'AddPurchase': (context) => AddPurchase(),
        'AllPurchase': (context) => AllPurchase(),
        'newPurchase': (context) => AddPurchase(),
        'addCat': (context) => AddCat(),
        'Cart': (context) => Cart(),
        'allbills': (context) => AllBills(),
        'expencesReports': (context) => ExpencesReports(),
        'donebill': (context) => DoneBill(),
        'pendingBill': (context) => PendingBill(),
        'users': (context) => Users(),
        'AddUser': (context) => AddUser(),
      },
      home: HomeScreen(),
    );
  }
}

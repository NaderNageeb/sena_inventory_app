// ignore_for_file: prefer_const_constructors, non_constant_identifier_names, prefer_interpolation_to_compose_strings, unused_import

import 'package:flutter/material.dart';
import 'package:sena_inventory/constant/linkapi.dart';

import 'package:sena_inventory/main.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer({super.key});

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  String? username = sharedPref.getString('username');
  String? email = sharedPref.getString('email');
  // String? user_image = sharedPref.getString('user_image');

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          UserAccountsDrawerHeader(
            currentAccountPicture: CircleAvatar(
              backgroundImage: AssetImage("assets/inv.ico"),
            ),
            accountName: Text(
              username!,
              style: TextStyle(color: Colors.black),
            ),
            accountEmail: Text(
              email!,
              style: TextStyle(color: Colors.black),
            ),

            // decoration: BoxDecoration(
            //   image: DecorationImage(
            //     // fit: BoxFit.cover,
            //     fit: BoxFit.contain,
            //     // image: AssetImage("assets/inv.ico"),
            //     // image: ,
            //   ),
            // ),
            // decoration: BoxDecoration(color: Colors.white),
          ),
          ListTile(
            title: Text("Home"),
            leading: Icon(
              Icons.home_outlined,
              color: Color(0xFF79AED1),
            ),
            // splashColor: Colors.black,
            onTap: () {
              Navigator.of(context).pushNamed("home");
            },
          ),
          ListTile(
            title: Text("Stock"),
            leading: Icon(
              Icons.stacked_bar_chart,
              color: Color(0xFF79AED1),
            ),
            onTap: () {
              Navigator.of(context).pushNamed("inventory");
            },
          ),
          ListTile(
            title: Text("expenses"),
            leading: Icon(
              Icons.money,
              color: Color(0xFF79AED1),
            ),
            onTap: () {
              Navigator.of(context).pushNamed("view_expenses");
            },
          ),
          ListTile(
            title: Text("POS"),
            leading: Icon(
              Icons.point_of_sale,
              color: Color(0xFF79AED1),
            ),
            onTap: () {
              Navigator.of(context).pushNamed("Cart");
            },
          ),
          ListTile(
            title: Text("All Bills"),
            leading: Icon(
              Icons.receipt,
              color: Color(0xFF79AED1),
            ),
            onTap: () {
              Navigator.of(context).pushNamed("allbills");
            },
          ),
          ListTile(
            title: Text("New Purchase"),
            leading: Icon(
              Icons.add_shopping_cart,
              color: Color(0xFF79AED1),
            ),
            onTap: () {
              Navigator.of(context).pushNamed("newPurchase");
            },
          ),
          ListTile(
            title: Text("Reports"),
            leading: Icon(
              Icons.file_open_sharp,
              color: Color(0xFF79AED1),
            ),
            onTap: () {
              Navigator.of(context).pushNamed("reports");
            },
          ),
          ListTile(
            title: Text("Exit"),
            leading: Icon(
              Icons.exit_to_app,
              color: Color(0xFF79AED1),
            ),
            onTap: () {
              sharedPref.clear();

              Navigator.of(context)
                  .pushNamedAndRemoveUntil("login", (route) => false);
            },
          ),
        ],
      ),
    );
  }
}

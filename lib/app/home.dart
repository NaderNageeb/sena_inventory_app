// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unrelated_type_equality_checks, must_be_immutable

import 'package:flutter/material.dart';
import 'package:sena_inventory/main.dart';

import '../components/Drawer.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  String? user_type = sharedPref.getString('type');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Inventory"),
      ),
      drawer: MyDrawer(),
      body: ListView(
        padding: EdgeInsets.all(10),
        children: [
          Row(
            children: [
              Expanded(
                child: InkWell(
                  onTap: () {
                    Navigator.of(context).pushNamed("inventory");
                  },
                  child: Container(
                    width: 70,
                    height: 120,
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    // padding: EdgeInsets.symmetric(vertical: 30, horizontal: 10),
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 245, 241, 241),
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.inventory_2,
                          size: 50,
                          // color: Color.fromARGB(255, 107, 131, 182),
                        ),
                        Text("Inventory"),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                child: InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, "Cart");
                  },
                  child: Container(
                    width: 70,
                    height: 120,
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    // padding: EdgeInsets.symmetric(vertical: 30, horizontal: 10),
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 245, 241, 241),
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.shopping_cart,
                          size: 50,
                        ),
                        Text("Cart"),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Expanded(
                child: InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, "AllPurchase");
                  },
                  child: Container(
                    width: 70,
                    height: 120,
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    // padding: EdgeInsets.symmetric(vertical: 30, horizontal: 10),
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 245, 241, 241),
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.add_shopping_cart, size: 50),
                        Text("Purchase"),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                child: InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, "category");
                  },
                  child: Container(
                    width: 70,
                    height: 120,
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    // padding: EdgeInsets.symmetric(vertical: 30, horizontal: 10),
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 245, 241, 241),
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.category,
                          size: 50,
                        ),
                        Text("Categories"),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Expanded(
                child: InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, "suppliers");
                  },
                  child: Container(
                    width: 70,
                    height: 120,
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    // padding: EdgeInsets.symmetric(vertical: 30, horizontal: 10),
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 245, 241, 241),
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.add_business_sharp, size: 50),
                        Text("Suppliers"),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                child: InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, "expenses");
                  },
                  child: Container(
                    width: 70,
                    height: 120,
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    // padding: EdgeInsets.symmetric(vertical: 30, horizontal: 10),
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 245, 241, 241),
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.attach_money_sharp,
                          size: 50,
                        ),
                        Text("Expenses"),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Expanded(
                child: InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, "reports");
                  },
                  child: Container(
                    width: 70,
                    height: 120,
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    // padding: EdgeInsets.symmetric(vertical: 30, horizontal: 10),
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 245, 241, 241),
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.file_copy,
                          size: 50,
                        ),
                        Text("Reports"),
                      ],
                    ),
                  ),
                ),
              ),
              if (sharedPref.getString("type") == 'admin')
                Expanded(
                  child: InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, 'users');
                    },
                    child: Container(
                      width: 70,
                      height: 120,
                      margin: EdgeInsets.symmetric(horizontal: 10),
                      // padding: EdgeInsets.symmetric(vertical: 30, horizontal: 10),
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 245, 241, 241),
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.manage_accounts,
                            size: 50,
                          ),
                          Text("Users"),
                        ],
                      ),
                    ),
                  ),
                ),
            ],
          ),
          Container(
            padding: EdgeInsets.all(10),
            margin: EdgeInsets.only(top: 10, bottom: 10),
            child: Image.asset(
              "assets/senamart.jpeg",
              width: 70,
              height: 150,
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    );
  }
}

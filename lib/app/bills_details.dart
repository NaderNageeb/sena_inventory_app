// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, non_constant_identifier_names, override_on_non_overriding_member

import 'package:flutter/material.dart';

import '../components/crud.dart';
import '../constant/linkapi.dart';

class BillDetils extends StatefulWidget {
  final billData;

  BillDetils({super.key, required this.billData});

  @override
  State<BillDetils> createState() => _BillDetilsState();
}

class _BillDetilsState extends State<BillDetils> {
  @override
  var total = "";

  var totalPrice = 0;

  var itemqty = "";
  var itemtotprice = "";
  var bill_id = "";

  var paiedPrice = "";
  var totalPricebill = "";

  void initState() {
    // TODO: implement initState
    super.initState();
    bill_id = widget.billData['bill_id'];
    paiedPrice = widget.billData['total_paied'];
    totalPricebill = widget.billData['total_price'];

    Get_billDetils();
  }

  Crud _crud = Crud();

  Future<List<dynamic>> Get_billDetils() async {
    var response =
        await _crud.postRequests(linkgetbillsdetils, {"bill_id": bill_id});

    return response['data'];
  }

  Calculate(itemPrice, qty) {
    int? x = int.tryParse(qty);
    int? y = int.tryParse(itemPrice);

    var z = x! * y!;

    return "$z";
    // return Text("Total : " + "$z");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Bill Details"),
      ),
      body: Column(
        children: [
          // ///////////
          FutureBuilder(
            future: Get_billDetils(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(
                  child: Column(
                    children: [
                      Image.asset(
                        "assets/empty-cart.png",
                      ),
                    ],
                  ),
                );
              } else if (snapshot.hasData) {
                final data = snapshot.data!;

                return Expanded(
                  child: ListView.builder(
                    itemCount: data.length,
                    itemBuilder: (context, i) {
                      totalPrice = 0;
                      for (var i = 0; i < data.length; i++) {
                        var totprice = data[i]['item_seale_price'];
                        var totqty = data[i]['qty'];
                        totalPrice +=
                            (int.tryParse(totprice)! * int.tryParse(totqty)!);
                      }
// swep to delete
                      // return Expanded(
                      //   child: Container(
                      //     height: 100,
                      //     width: 500,
                      //     decoration: BoxDecoration(
                      //       color: Color.fromARGB(255, 246, 243, 243),
                      //     ),
                      //     margin: EdgeInsets.all(1),
                      //     child: Row(
                      //       crossAxisAlignment: CrossAxisAlignment.center,
                      //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //       children: [
                      //         Expanded(child: Text(data[i]['item_name'])),
                      //         Expanded(
                      //             child: Text(data[i]['item_seale_price'])),
                      //         Expanded(
                      //           child: Text(data[i]['qty']),
                      //         ),
                      //         Expanded(
                      // child: Text(
                      //     "Total : ${Calculate(data[i]['item_seale_price'], data[i]['qty'])}"),
                      //         ),
                      //       ],
                      //     ),
                      //   ),
                      // );

                      return Container(
                        margin: EdgeInsets.all(10),
                        child: ListTile(
                          titleTextStyle:
                              TextStyle(fontSize: 13, color: Colors.black),
                          subtitleTextStyle:
                              TextStyle(fontSize: 13, color: Colors.black),
                          leading: Text(
                            data[i]['item_name'],
                            style: TextStyle(fontSize: 19, color: Colors.black),
                          ),
                          title: Text(data[i]['item_seale_price']),
                          subtitle: Text(data[i]['qty']),
                          trailing: Text(
                              "Total : ${Calculate(data[i]['item_seale_price'], data[i]['qty'])}"),
                        ),
                      );
                    },
                  ),
                );
              } else {
                return Text('No items found');
              }
            },
          ),
          Expanded(
              child: Column(
            children: [
              Text("Total Bill  :  " + totalPricebill.toString()),
              SizedBox(
                height: 10,
              ),
              Text("Total Paied  :  " + paiedPrice.toString()),
            ],
          )),
        ],
      ),
    );
  }
}

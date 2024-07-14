// ignore_for_file: prefer_const_constructors, prefer_interpolation_to_compose_strings, unrelated_type_equality_checks

import 'package:flutter/material.dart';

import '../components/Drawer.dart';
import '../components/crud.dart';
import '../constant/linkapi.dart';
import 'bills_details.dart';

class AllBills extends StatefulWidget {
  const AllBills({super.key});

  @override
  State<AllBills> createState() => _AllBillsState();
}

class _AllBillsState extends State<AllBills> {
  @override
  void initState() {
    super.initState();
    Get_bills();
  }

  Crud _crud = Crud();
  Future<List<dynamic>> Get_bills() async {
    var response = await _crud.getRequests(linkgetbills);

    return response['data'];
    // return response;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Bills"),
      ),
      drawer: MyDrawer(),
      body: RefreshIndicator(
        onRefresh: () async {
          setState(() {});

          return Future<void>.delayed(const Duration(seconds: 3));
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // ///////////
              FutureBuilder(
                future: Get_bills(),
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
                          return Container(
                            margin: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                                color: Color.fromARGB(255, 243, 240, 240)),
                            child: ListTile(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => BillDetils(
                                          billData: data[i],
                                        )));
                              },
                              title: Text(data[i]['customer_id'].toString()),
                              contentPadding: EdgeInsets.all(10),
                              subtitle: Text(data[i]['total_price'] == ""
                                  ? "in cart"
                                  : "Total Price :" +
                                      data[i]['total_price'].toString()),
                              // leading: Text(" NO :" + data[i]['bill_id']),
                              trailing: Text("Status :" +
                                          data[i]['bill_status'].toString() ==
                                      '0'
                                  ? "In Cart"
                                  : "Checked Out"),
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
            ],
          ),
        ),
      ),
    );
  }
}

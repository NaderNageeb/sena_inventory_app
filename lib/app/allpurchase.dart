// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last, prefer_final_fields, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:sena_inventory/app/editpurchase.dart';

import '../components/Drawer.dart';
import '../components/crud.dart';
import '../constant/linkapi.dart';

class AllPurchase extends StatefulWidget {
  const AllPurchase({super.key});

  @override
  State<AllPurchase> createState() => _AllPurchaseState();
}

class _AllPurchaseState extends State<AllPurchase> {
  @override
  void initState() {
    super.initState();
    getPurchase();
  }

  Crud _crud = Crud();

  Future<List<dynamic>> getPurchase() async {
    var responce = await _crud.getRequests(linkgetPurchase);

    return responce['data'];
  }

  deletePurchase(purchaseId) async {
    var responce =
        await _crud.postRequests(linkdelpurchase, {"purchase_id": purchaseId});
    if (responce['status'] == 'success') {
      setState(() {});
      return Alert(
        context: context,
        type: AlertType.success,
        title: "Success",
        desc: "Purchase Deleted Success",
        buttons: [
          DialogButton(
            child: Text(
              "Ok",
              style: TextStyle(color: Colors.black, fontSize: 20),
            ),
            onPressed: () => Navigator.of(context).pushNamed("AllPurchase"),
            width: 120,
          )
        ],
      ).show();
    }
    if (responce['status'] == 'Faild') {
      return Alert(
        context: context,
        type: AlertType.error,
        title: "Error",
        desc: " item Delete Faild",
        buttons: [
          DialogButton(
            child: Text(
              "OK",
              style: TextStyle(color: Colors.black, fontSize: 20),
            ),
            onPressed: () => Navigator.pop(context),
            width: 120,
          )
        ],
      ).show();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Purchase"),
      ),
      drawer: MyDrawer(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed("AddPurchase");
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        backgroundColor: Color.fromARGB(255, 107, 131, 182),
      ),
      body: RefreshIndicator(
        onRefresh: () {
          setState(() {});
          return Future<void>.delayed(const Duration(seconds: 3));
        },
        child: Container(
          padding: EdgeInsets.all(5),
          child: ListView(
            children: [
              FutureBuilder(
                  future: getPurchase(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      // return Text('Error: ${snapshot.error}');
                      return Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Center(
                            child: Icon(
                          Icons.remove_shopping_cart_outlined,
                          size: 100,
                        )),
                      );
                    } else if (snapshot.hasData) {
                      final data = snapshot.data!;
                      final length = data.length;
                      return SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: DataTable(
                          columns: [
                            DataColumn(label: Text('#')),
                            DataColumn(label: Text('Item')),
                            DataColumn(label: Text('Supplier Name')),
                            DataColumn(label: Text('P Price')),
                            DataColumn(label: Text('Quantity')),
                            DataColumn(label: Text('Date')),
                            DataColumn(label: Text('Action')),
                          ],
                          rows: List<DataRow>.generate(
                            length,
                            (index) => DataRow(
                              cells: [
                                DataCell(Text(data[index]['purchase_id'])),
                                DataCell(Text(data[index]['item_name'])),
                                DataCell(Text(data[index]['sup_name'])),
                                DataCell(Text(data[index]['purchase_price'])),
                                DataCell(
                                    Text(data[index]['purchase_item_qty'])),
                                DataCell(Text(data[index]['purchase_date']!)),
                                DataCell(
                                  Padding(
                                    padding: EdgeInsets.all(8),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Expanded(
                                          child: IconButton(
                                            onPressed: () {
                                              Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          Editpurchase(
                                                            purchaseData:
                                                                data[index],
                                                          )));
                                            },
                                            icon: Icon(Icons.remove_red_eye),
                                          ),
                                        ),
                                        Expanded(
                                          child: IconButton(
                                            onPressed: () async {
                                              var purchaseId =
                                                  data[index]['purchase_id'];

                                              await deletePurchase(purchaseId);
                                            },
                                            icon: Icon(
                                              Icons.delete,
                                              color: Colors.red,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                // DataCell(Text(data[index]['purchase_date']!)),
                              ],
                            ),
                          ),
                        ),
                      );
                    } else {
                      return Text('No customers data found');
                    }
                  }),
            ],
          ),
        ),
      ),
    );
  }
}

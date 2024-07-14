// ignore_for_file: prefer_const_constructors, sort_child_properties_last, prefer_const_literals_to_create_immutables, prefer_final_fields, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import '../components/Drawer.dart';
import '../components/crud.dart';
import '../constant/linkapi.dart';
import 'edit_sup.dart';

class Suppliers extends StatefulWidget {
  const Suppliers({super.key});

  @override
  State<Suppliers> createState() => _SuppliersState();
}

class _SuppliersState extends State<Suppliers> {
  @override
  void initState() {
    super.initState();
    getSuppliers();
  }

  Crud _crud = Crud();

  Future<List<dynamic>> getSuppliers() async {
    var responce = await _crud.getRequests(linkgetgetsuppliers);

    return responce['data'];
  }

  delSub(subId) async {
    var responce = await _crud.postRequests(linkdelSup, {"sup_id": subId});
    if (responce['status'] == 'success') {
      setState(() {});
      return Alert(
        context: context,
        type: AlertType.success,
        title: "Success",
        desc: "Supplier Deleted Success",
        buttons: [
          DialogButton(
            child: Text(
              "Ok",
              style: TextStyle(color: Colors.black, fontSize: 20),
            ),
            onPressed: () => Navigator.of(context).pushNamed("suppliers"),
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
        title: Text("Suppliers"),
      ),
      drawer: MyDrawer(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed("AddSuppliers");
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
                  future: getSuppliers(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(
                        child: Text("No Data"),
                      );
                      // return Text('Error: ${snapshot.error}');
                    } else if (snapshot.hasData) {
                      final data = snapshot.data!;
                      final length = data.length;
                      return SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: DataTable(
                          columns: [
                            DataColumn(label: Text('#')),
                            DataColumn(label: Text('Supplier Name')),
                            DataColumn(label: Text('Phone')),
                            DataColumn(label: Text('Action')),
                          ],
                          rows: List<DataRow>.generate(
                            length,
                            (index) => DataRow(
                              cells: [
                                DataCell(Text(data[index]['sup_id'])),
                                DataCell(Text(data[index]['sup_name'])),
                                DataCell(Text(data[index]['sup_phone'])),
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
                                                          EditSup(
                                                            subData:
                                                                data[index],
                                                          )));
                                            },
                                            icon: Icon(Icons.remove_red_eye),
                                          ),
                                        ),
                                        Expanded(
                                          child: IconButton(
                                            onPressed: () async {
                                              var supId = data[index]['sup_id'];

                                              await delSub(supId);
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

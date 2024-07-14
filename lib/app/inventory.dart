// ignore_for_file: prefer_const_constructors, sort_child_properties_last, prefer_const_literals_to_create_immutables, must_be_immutable, prefer_final_fields, body_might_complete_normally_nullable, non_constant_identifier_names, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:sena_inventory/components/Drawer.dart';
import 'package:sena_inventory/components/crud.dart';
import 'package:sena_inventory/constant/linkapi.dart';

import 'edit_item.dart';

class Inventory extends StatefulWidget {
  Inventory({super.key});

  @override
  State<Inventory> createState() => _InventoryState();
}

class _InventoryState extends State<Inventory> {
  @override
  void initState() {
    super.initState();
    getItems();
  }

  Crud _crud = Crud();

  Future<List<dynamic>> getItems() async {
    var responce = await _crud.getRequests(linkgetitems);

    return responce['data'];
  }

  AddToCart(item_id) async {
    var responce =
        await _crud.postRequests(linkaddtocart, {"item_id": item_id});
    if (responce['status'] == 'Exist') {
      return ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          duration: Duration(seconds: 2),
          content: Text("The Item Already in Cart !!"),
        ),
      );
    }
    if (responce['status'] == 'success') {
      return ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          duration: Duration(seconds: 2),
          content: Text("Item Added in Cart Success !!"),
        ),
      );
    }
  }

  deleteItem(itemId) async {
    var responce = await _crud.postRequests(linkdeletItem, {"item_id": itemId});
    if (responce['status'] == 'success') {
      setState(() {});
      return Alert(
        context: context,
        type: AlertType.success,
        title: "Success",
        desc: "Item Deleted Success",
        buttons: [
          DialogButton(
            child: Text(
              "Ok",
              style: TextStyle(color: Colors.black, fontSize: 20),
            ),
            onPressed: () => Navigator.of(context).pushNamed("inventory"),
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
        title: Text("Inventory Stock"),
        elevation: 0,
      ),
      drawer: MyDrawer(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed("additem");
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        backgroundColor: Color.fromARGB(255, 107, 131, 182),
      ),
      body: RefreshIndicator(
        // semanticsLabel: "Loading",

        onRefresh: () {
          setState(() {});
          return Future<void>.delayed(const Duration(seconds: 3));
        },
        child: ListView(
          children: [
            FutureBuilder(
                future: getItems(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else if (snapshot.hasData) {
                    final items = snapshot.data!;
                    final length = items.length;
                    return SingleChildScrollView(
                      child: Padding(
                        padding: EdgeInsets.all(10),
                        child: Table(
                          columnWidths: {
                            0: FlexColumnWidth(
                                0.7), // Set the width of the "#" column
                            1: FlexColumnWidth(
                                1.3), // Set the width of the other columns
                            2: FlexColumnWidth(0.8),

                            3: FlexColumnWidth(1),

                            // Add more column widths as needed
                          },
                          border: TableBorder.all(color: Colors.white30),
                          defaultVerticalAlignment:
                              TableCellVerticalAlignment.middle,
                          children: [
                            TableRow(
                              decoration: BoxDecoration(
                                color: Color.fromARGB(255, 107, 131, 182),
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  topRight: Radius.circular(10),
                                ),
                              ),
                              children: [
                                TableCell(
                                  verticalAlignment:
                                      TableCellVerticalAlignment.middle,
                                  child: Padding(
                                    padding: EdgeInsets.all(8),
                                    child: Text(
                                      "#",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                                TableCell(
                                  verticalAlignment:
                                      TableCellVerticalAlignment.middle,
                                  child: Padding(
                                    padding: EdgeInsets.all(8),
                                    child: Text(
                                      "Item",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                                TableCell(
                                  verticalAlignment:
                                      TableCellVerticalAlignment.middle,
                                  child: Padding(
                                    padding: EdgeInsets.all(8),
                                    child: Text(
                                      "QTY",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                                TableCell(
                                  verticalAlignment:
                                      TableCellVerticalAlignment.middle,
                                  child: Padding(
                                    padding: EdgeInsets.all(8),
                                    child: Text(
                                      "Action",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            // list Here

                            ...List.generate(
                              length,
                              (index) => TableRow(
                                children: [
                                  TableCell(
                                    child: Padding(
                                      padding: EdgeInsets.all(8),
                                      child: IconButton(
                                        onPressed: () async {
                                          if (int.parse(items[index]
                                                      ['item_stock']
                                                  .toString()) ==
                                              0) {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              SnackBar(
                                                duration: Duration(seconds: 2),
                                                content: Text(
                                                    "Sorry !! Item Quantity is 0 "),
                                              ),
                                            );
                                          } else {
                                            var item_id =
                                                items[index]['item_id'];
                                            await AddToCart(item_id);
                                          }

                                          // print(items[index]['item_id']);
                                        },
                                        icon: int.parse(items[index]
                                                        ['item_stock']
                                                    .toString()) ==
                                                0
                                            ? Icon(
                                                Icons.block_sharp,
                                                // .motion_photos_off_outlined,
                                                color: Colors.grey,
                                              )
                                            : Icon(
                                                Icons.add_circle_outlined,
                                                // color: Colors.green,
                                                color: Color(0xFF79AED1),
                                              ),
                                      ),
                                    ),
                                  ),
                                  TableCell(
                                    child: Padding(
                                      padding: EdgeInsets.all(8),
                                      child: Text(items[index]['item_name']),
                                    ),
                                  ),
                                  TableCell(
                                    child: Padding(
                                      padding: EdgeInsets.all(8),
                                      child: Text(
                                        items[index]['item_stock'],
                                        style: TextStyle(
                                            color: int.parse(items[index]
                                                            ['item_stock']
                                                        .toString()) <
                                                    5
                                                ? Colors.red
                                                : Colors.green),
                                      ),
                                    ),
                                  ),
                                  TableCell(
                                    child: Padding(
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
                                                            EditItem(
                                                              itemdata:
                                                                  items[index],
                                                            )));
                                              },
                                              icon: Icon(Icons.remove_red_eye),
                                            ),
                                          ),
                                          Expanded(
                                            child: IconButton(
                                              onPressed: () async {
                                                var itemId =
                                                    items[index]['item_id'];

                                                await deleteItem(itemId);
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
                          ],
                        ),
                      ),
                    );
                  } else {
                    return Text('No items found');
                  }
                }),
          ],
        ),
      ),
    );
  }
}

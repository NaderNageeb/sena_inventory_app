// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, sort_child_properties_last, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:sena_inventory/components/Drawer.dart';

import '../components/crud.dart';
import '../constant/linkapi.dart';
import 'editcat.dart';

class Category extends StatefulWidget {
  const Category({super.key});

  @override
  State<Category> createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  @override
  void initState() {
    super.initState();
    Get_category();
  }

  Crud _crud = Crud();

  Future<List<dynamic>> Get_category() async {
    var response = await _crud.getRequests(linkgetcat);

    return response['data'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Categories"),
      ),
      drawer: MyDrawer(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed("add_category");
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
        child: FutureBuilder(
            future: Get_category(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(
                  child: Text("No Categorys"),
                );
                // return Text('Error: ${snapshot.error}');
              } else if (snapshot.hasData) {
                final customers_data = snapshot.data!;
                final length = customers_data.length;
                return Container(
                  margin: EdgeInsets.only(top: 5),
                  child: SingleChildScrollView(
                    // controller: controller,
                    child: Padding(
                      padding: EdgeInsets.all(10),
                      child: Table(
                        columnWidths: {
                          0: FlexColumnWidth(
                              1), // Set the width of the "#" column
                          1: FlexColumnWidth(
                              2), // Set the width of the other columns
                          2: FlexColumnWidth(0.8),
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
                                    "Category",
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
                                    child: Text(customers_data[index]['cat_id']
                                        .toString()),
                                  ),
                                ),
                                TableCell(
                                  child: Padding(
                                    padding: EdgeInsets.all(8),
                                    child: Text(
                                      customers_data[index]['cat_name'] == ""
                                          ? ""
                                          : customers_data[index]['cat_name'],
                                    ),
                                  ),
                                ),
                                TableCell(
                                  child: IconButton(
                                    onPressed: () {
                                      Navigator.of(context)
                                          .push(MaterialPageRoute(
                                              builder: (context) => EditCat(
                                                    CatData:
                                                        customers_data[index],
                                                  )));
                                    },
                                    icon: Icon(Icons.remove_red_eye),
                                  ),
                                ),
                              ],
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
      ),
    );
  }
}

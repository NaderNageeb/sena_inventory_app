// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, sort_child_properties_last, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:sena_inventory/components/Drawer.dart';

import '../components/crud.dart';
import '../constant/linkapi.dart';
import 'edit_user.dart';

class Users extends StatefulWidget {
  const Users({super.key});

  @override
  State<Users> createState() => _UsersState();
}

class _UsersState extends State<Users> {
  @override
  void initState() {
    super.initState();
    Get_Users();
  }

  Crud _crud = Crud();

  Future<List<dynamic>> Get_Users() async {
    var response = await _crud.getRequests(linkgetUsers);

    return response['data'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Users"),
      ),
      drawer: MyDrawer(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed("AddUser");
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
                future: Get_Users(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    // return Text('Error: ${snapshot.error}');
                    return Center(
                      child: Text("No Data Check The Internet !!"),
                    );
                  } else if (snapshot.hasData) {
                    final user_data = snapshot.data!;
                    final length = user_data.length;

                    return Container(
                      margin: EdgeInsets.only(top: 5),
                      child: SingleChildScrollView(
                        // controller: controller,
                        child: Padding(
                          padding: EdgeInsets.all(10),
                          child: Table(
                            columnWidths: {
                              0: FlexColumnWidth(
                                  0.9), // Set the width of the "#" column
                              1: FlexColumnWidth(
                                  2), // Set the width of the other columns
                              2: FlexColumnWidth(0.8),
                              // Add more column widths as needed
                              3: FlexColumnWidth(0.4),
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
                                        "name",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ),
                                  TableCell(
                                    child: Padding(
                                      padding: EdgeInsets.all(8),
                                      child: Text(
                                        "email",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ),
                                  // TableCell(
                                  //   verticalAlignment:
                                  //       TableCellVerticalAlignment.middle,
                                  //   child: Padding(
                                  //     padding: EdgeInsets.all(8),
                                  //     child: Text(
                                  //       "type",
                                  //       style: TextStyle(color: Colors.white),
                                  //     ),
                                  //   ),
                                  // ),
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
                                        child: Text(user_data[index]['username']
                                            .toString()),
                                      ),
                                    ),
                                    TableCell(
                                      child: Padding(
                                        padding: EdgeInsets.all(8),
                                        child: Text(user_data[index]['email']
                                            .toString()),
                                      ),
                                    ),
                                    // TableCell(
                                    //   child: Padding(
                                    //     padding: EdgeInsets.all(8),
                                    //     child: Text(user_data[index]['type']),
                                    //   ),
                                    // ),
                                    TableCell(
                                      child: IconButton(
                                        onPressed: () {
                                          Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      EditUser(
                                                        UserData:
                                                            user_data[index],
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
          ],
        ),
      ),
    );
  }
}

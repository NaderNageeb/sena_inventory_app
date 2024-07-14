// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

import '../../components/crud.dart';
import '../../constant/linkapi.dart';

class ExpencesReports extends StatefulWidget {
  const ExpencesReports({super.key});

  @override
  State<ExpencesReports> createState() => _ExpencesReportsState();
}

class _ExpencesReportsState extends State<ExpencesReports> {
  @override
  void initState() {
    super.initState();
    Get_expenses();
  }

  Crud _crud = Crud();

  Future<List<dynamic>> Get_expenses() async {
    var response = await _crud.getRequests(linkgetexpenses);

    return response['data'];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(5),
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(top: 10, bottom: 10),
            child: Text(
              "Expenses Reports",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          FutureBuilder(
              future: Get_expenses(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  // return Text('Error: ${snapshot.error}');
                  return Center(
                    child: Container(
                      margin: EdgeInsets.all(10),
                      child: Text("No Data For Now !"),
                    ),
                  );
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
                                2), // Set the width of the "#" column
                            1: FlexColumnWidth(
                                2), // Set the width of the other columns
                            2: FlexColumnWidth(1.5),
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
                                      "Name",
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
                                      "Date",
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
                                      "Price",
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
                                      child: Text(
                                        customers_data[index]['exp_name'],
                                      ),
                                    ),
                                  ),
                                  TableCell(
                                    child: Padding(
                                      padding: EdgeInsets.all(8),
                                      child: Text(customers_data[index]
                                              ['expe_date']
                                          .toString()),
                                    ),
                                  ),
                                  TableCell(
                                    child: Padding(
                                      padding: EdgeInsets.all(8),
                                      child: Text(customers_data[index]
                                              ['exp_price']
                                          .toString()),
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
                  return Text('Data');
                }
              }),
        ],
      ),
    );
  }
}

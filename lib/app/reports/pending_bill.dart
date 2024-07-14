// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

import '../../components/crud.dart';
import '../../constant/linkapi.dart';

class PendingBill extends StatefulWidget {
  const PendingBill({super.key});

  @override
  State<PendingBill> createState() => _PendingBillState();
}

class _PendingBillState extends State<PendingBill> {
  @override
  void initState() {
    super.initState();
    Get_PendingBill();
  }

  Crud _crud = Crud();

  Future<List<dynamic>> Get_PendingBill() async {
    var response = await _crud.getRequests(linkpendingbill);

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
              "Incart Reports",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          FutureBuilder(
              future: Get_PendingBill(),
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
                  final PendingBill = snapshot.data!;
                  final length = PendingBill.length;
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
                            2: FlexColumnWidth(2),
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
                                      "order",
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
                                      "item",
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
                                      "date",
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
                                        PendingBill[index]['cart_bill_id'],
                                      ),
                                    ),
                                  ),
                                  TableCell(
                                    child: Padding(
                                      padding: EdgeInsets.all(8),
                                      child: Text(PendingBill[index]
                                              ['item_name']
                                          .toString()),
                                    ),
                                  ),
                                  TableCell(
                                    child: Padding(
                                      padding: EdgeInsets.all(8),
                                      child: Text(PendingBill[index]
                                              ['cart_date']
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

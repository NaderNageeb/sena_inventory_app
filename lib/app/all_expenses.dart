// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, void_checks

import 'package:flutter/material.dart';
import 'package:sena_inventory/components/Drawer.dart';

import '../components/crud.dart';
import '../constant/linkapi.dart';

class ViewExpenses extends StatefulWidget {
  const ViewExpenses({super.key});

  @override
  State<ViewExpenses> createState() => _ViewExpensesState();
}

class _ViewExpensesState extends State<ViewExpenses> {
  @override
  void initState() {
    super.initState();
    getExpenses();
  }

  Crud _crud = Crud();

  Future<List<dynamic>> getExpenses() async {
    var responce = await _crud.getRequests(linkgetexpenses);

    return responce['data'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Expenses"),
      ),
      drawer: MyDrawer(),
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
                  future: getExpenses(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else if (snapshot.hasData) {
                      final data = snapshot.data!;
                      final length = data.length;
                      return SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: DataTable(
                          columns: [
                            DataColumn(label: Text('Expenses')),
                            DataColumn(label: Text('Date')),
                            DataColumn(label: Text('Price')),
                          ],
                          rows: List<DataRow>.generate(
                            length,
                            (index) => DataRow(
                              cells: [
                                DataCell(onLongPress: () {
                                  return details();
                                }, Text(data[index]['exp_name'])),
                                DataCell(Text(data[index]['expe_date'])),
                                DataCell(Text(data[index]['exp_price'])),
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

details() {
  return Tooltip(
    child: Column(
      children: [
        InkWell(
          onTap: () {
            print("tabed");
          },
          child: Text("edit"),
        ),
      ],
    ),
  );
}

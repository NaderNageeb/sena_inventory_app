// // ignore_for_file: prefer_const_constructors, sort_child_properties_last, prefer_const_literals_to_create_immutables, must_be_immutable, prefer_final_fields

// import 'package:flutter/material.dart';
// import 'package:sena_inventory/components/crud.dart';
// import 'package:sena_inventory/constant/linkapi.dart';

// class Inventory extends StatefulWidget {
//   Inventory({super.key});

//   @override
//   State<Inventory> createState() => _InventoryState();
// }

// class _InventoryState extends State<Inventory> {
//   @override
//   void initState() {
//     super.initState();
//     getItems();
//   }

//   Crud _crud = Crud();

//   getItems() async {
//     var responce = await _crud.getRequests(linkgetitems);

//     print(responce['data']);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Inventory Stock"),
//         elevation: 0,
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           Navigator.of(context).pushNamed("additem");
//         },
//         child: Icon(
//           Icons.add,
//           color: Colors.white,
//         ),
//         backgroundColor: Color.fromARGB(255, 107, 131, 182),
//       ),
//       body: RefreshIndicator(
//         // semanticsLabel: "Loading",
//         onRefresh: () {
//           setState(() {});
//           return Future<void>.delayed(const Duration(seconds: 3));
//         },
//         child: Container(
//           margin: EdgeInsets.only(top: 5),
//           child: SingleChildScrollView(
//             // controller: controller,
//             child: Padding(
//               padding: EdgeInsets.all(10),
//               child: Table(
//                 border: TableBorder.all(color: Colors.white30),
//                 defaultVerticalAlignment: TableCellVerticalAlignment.middle,
//                 children: [
//                   TableRow(
//                     decoration: BoxDecoration(
//                       color: Color.fromARGB(255, 107, 131, 182),
//                       borderRadius: BorderRadius.only(
//                         topLeft: Radius.circular(10),
//                         topRight: Radius.circular(10),
//                       ),
//                     ),
//                     children: [
//                       TableCell(
//                         verticalAlignment: TableCellVerticalAlignment.middle,
//                         child: Padding(
//                           padding: EdgeInsets.all(8),
//                           child: Text(
//                             "Item",
//                             style: TextStyle(color: Colors.white),
//                           ),
//                         ),
//                       ),
//                       TableCell(
//                         verticalAlignment: TableCellVerticalAlignment.middle,
//                         child: Padding(
//                           padding: EdgeInsets.all(8),
//                           child: Text(
//                             "Quantity",
//                             style: TextStyle(color: Colors.white),
//                           ),
//                         ),
//                       ),
//                       TableCell(
//                         verticalAlignment: TableCellVerticalAlignment.middle,
//                         child: Padding(
//                           padding: EdgeInsets.all(8),
//                           child: Text(
//                             "Price",
//                             style: TextStyle(color: Colors.white),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                   // list Here
//                   ...List.generate(
//                     20,
//                     (index) => TableRow(children: [
//                       TableCell(
//                         child: Padding(
//                           padding: EdgeInsets.all(8),
//                           child: Text("cell1"),
//                         ),
//                       ),
//                       TableCell(
//                         child: Padding(
//                           padding: EdgeInsets.all(8),
//                           child: Text("cell2"),
//                         ),
//                       ),
//                       TableCell(
//                         child: Padding(
//                           padding: EdgeInsets.all(8),
//                           child: Text("cell3"),
//                         ),
//                       ),
//                     ]),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

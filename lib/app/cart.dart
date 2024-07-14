// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, prefer_interpolation_to_compose_strings, unnecessary_new, non_constant_identifier_names, use_build_context_synchronously, unused_local_variable, prefer_const_constructors_in_immutables, sort_child_properties_last, unrelated_type_equality_checks

import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:sena_inventory/components/Drawer.dart';

import '../components/crud.dart';
import '../components/custometextform.dart';
import '../components/valid.dart';
import '../constant/linkapi.dart';

class Cart extends StatefulWidget {
  Cart({super.key});

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  GlobalKey<FormState> formstate = GlobalKey();
  TextEditingController customer_name = TextEditingController();
  TextEditingController paidprice = TextEditingController();
  // TextEditingController totallprice = TextEditingController();

  List CartIdes = [];

  void initState() {
    super.initState();
    Get_Cart();
  }

  Crud _crud = Crud();

  Future<List<dynamic>> Get_Cart() async {
    var response = await _crud.getRequests(linkgetcart);

    return response['data'];
    // return response;
  }

  var total = "";

  var totalPrice = 0;

  var itemqty = "";
  var itemtotprice = "";

  plusQty(itemId, cartQty, itemQty) async {
    var responce = await _crud.postRequests(linkplus, {
      "item_id": itemId.toString(),
      "cartQty": cartQty.toString(),
      "itemQty": itemQty.toString()
    });

    if (responce['status'] == 'Qtynon') {
      // setState(() {});
      return ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          duration: Duration(seconds: 2),
          content: Text("Sorry No Avaliable Quantity !!"),
        ),
      );
    }
    if (responce['status'] == 'success') {
      setState(() {});
      // return ScaffoldMessenger.of(context).showSnackBar(
      //   SnackBar(
      //     duration: Duration(seconds: 2),
      //     content: Text("cart qty Updated"),
      //   ),
      // );
    }
    if (responce['status'] == 'Faild') {
      return ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          duration: Duration(seconds: 2),
          content: Text("Error !!"),
        ),
      );
    }
  }

  minusQty(itemId, cartQty, itemQty) async {
    var responce = await _crud.postRequests(linkminis, {
      "item_id": itemId.toString(),
    });

    if (responce['status'] == 'Qtynon') {
      // setState(() {});
      // return ScaffoldMessenger.of(context).showSnackBar(
      //   SnackBar(
      //     duration: Duration(seconds: 2),
      //     content: Text("Sorry No Avaliable Quantity !!"),
      //   ),
      // );
    }
    if (responce['status'] == 'success') {
      setState(() {
        
      });
      // return ScaffoldMessenger.of(context).showSnackBar(
      //   SnackBar(
      //     duration: Duration(seconds: 2),
      //     content: Text("cart qty Updated"),
      //   ),
      // );
    }
    if (responce['status'] == 'Faild') {
      return ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          duration: Duration(seconds: 2),
          content: Text("Error !!"),
        ),
      );
    }
  }

  Calculate(item_price, qty) {
    int? x = int.tryParse(qty);
    int? y = int.tryParse(item_price);

    var z = x! * y!;

    return "$z";
    // return Text("Total : " + "$z");
  }

  bool isLoading = false;
  checkout() async {
    // i used this code to remove [] from the list
    String myListString = CartIdes.join(',');

    bool isLoading = true;
    setState(() {});
    if (formstate.currentState!.validate()) {
      var responce = await _crud.postRequests(linkcheckout, {
        // "itemIdes": myListString,
        "cartIdes": CartIdes.join(',').toString(),
        "paidprice": paidprice.text,
        "totalPrice": totalPrice.toString(),
        "customer_name": customer_name.text
      });

      bool isLoading = false;

      if (responce['status'] == 'success') {
        return Alert(
          context: context,
          type: AlertType.success,
          title: "Success",
          desc: "Order Submited Success",
          buttons: [
            DialogButton(
              child: Text(
                "Ok",
                style: TextStyle(color: Colors.black, fontSize: 20),
              ),
              onPressed: () => Navigator.of(context).pushNamed("home"),
              width: 120,
            )
          ],
        ).show();
      }

      if (responce['status'] == 'qtyno') {
        return Alert(
          context: context,
          type: AlertType.warning,
          title: "Error",
          desc: "Not Enough Quantity",
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

      if (responce['status'] == 'Faild') {
        return Alert(
          context: context,
          type: AlertType.error,
          title: "Error",
          desc: "Check Out Faild",
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

    // print(myListString);
    // print(paidprice.text);
    // print(totalPrice.toString());
  }

  deleteItem(cart_id) async {
    // linkdelete
    var responce = await _crud.postRequests(linkdelete, {
      "cart_id": cart_id.toString(),
    });

    if (responce['status'] == 'success') {
      setState(() {});
      totalPrice = 0;

      // return ScaffoldMessenger.of(context).showSnackBar(
      //   SnackBar(
      //     duration: Duration(seconds: 2),
      //     content: Text("cart qty Updated"),
      //   ),
      // );
    }
    if (responce['status'] == 'Faild') {
      return ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          duration: Duration(seconds: 2),
          content: Text("Error !!"),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cart"),
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
                future: Get_Cart(),
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
                          totalPrice = 0;
                          CartIdes.clear();

                          for (var i = 0; i < data.length; i++) {
                            CartIdes.add(data[i]['cart_id']);
                            var totprice = data[i]['item_seale_price'];
                            var totqty = data[i]['qty'];
                            totalPrice += (int.tryParse(totprice)! *
                                int.tryParse(totqty)!);
                          }
// swep to delete
                          return Dismissible(
                            key: Key(data[i]['cart_id']),
                            direction: DismissDirection.endToStart,
                            onDismissed: (direction) async {
                              // Add your delete logic here
                              var cart_id = data[i]['cart_id'];
                              await deleteItem(cart_id);
                            },
                            background: Container(
                              color: Colors.red,
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 16.0),
                                  child:
                                      Icon(Icons.delete, color: Colors.white),
                                ),
                              ),
                            ),
                            child: Container(
                              height: 100,
                              padding: EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: Color.fromARGB(255, 246, 243, 243),
                              ),
                              margin: EdgeInsets.all(5),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(child: Text(data[i]['item_name'])),
                                  Expanded(
                                      child: Text(data[i]['item_seale_price'])),
                                  Expanded(
                                    child: TextButton(
                                      child: Text(data[i]['qty']),
                                      onLongPress: () async {
                                        var itemId = data[i]['item_id'];
                                        String cartQty = data[i]['qty'];
                                        String itemQty = data[i]['item_stock'];
                                        await minusQty(
                                            itemId, cartQty, itemQty);
                                      },
                                      onPressed: () async {
                                        var ItemId = data[i]['item_id'];
                                        int cartQty = int.parse(data[i]['qty']);
                                        int itemQty =
                                            int.parse(data[i]['item_stock']);
                                        await plusQty(ItemId, cartQty, itemQty);
                                      },
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                        "Total : ${Calculate(data[i]['item_seale_price'], data[i]['qty'])}"),
                                  ),
                                ],
                              ),
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
              if (totalPrice != 0)
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.all(1),
                        padding: EdgeInsets.symmetric(horizontal: 2),
                        // margin: EdgeInsets.only(top: 10),
                        height: 50,
                        child: ElevatedButton(
                          style: ButtonStyle(),
                          onPressed: () async {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text("Payment"),
                                      Divider(
                                        color: Colors.black,
                                        height: 5,
                                      )
                                    ],
                                  ),
                                  content: SizedBox(
                                    height: 150,
                                    child: Form(
                                      key: formstate,
                                      child: ListView(
                                        children: [
                                          CustomeFormFeild(
                                            valid: (val) {
                                              return validInput(val!, 1, 30);
                                            },
                                            onTab: () {},
                                            keyboardType: TextInputType.text,
                                            textInputAction:
                                                TextInputAction.next,
                                            myController: customer_name,
                                            label: "Customer Name",
                                            isPasswort: false,
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          CustomeFormFeild(
                                            valid: (val) {
                                              return validInput(val!, 1, 30);
                                            },
                                            onTab: () {},
                                            keyboardType: TextInputType.number,
                                            textInputAction:
                                                TextInputAction.done,
                                            myController: paidprice,
                                            label: "Paid Price",
                                            isPasswort: false,
                                          ),
                                        ],
                                      ),

                                      // // drop down list end
                                    ),
                                  ),
                                  actions: [
                                    Container(
                                      margin: EdgeInsets.only(top: 10),
                                      height: 50,
                                      child: ElevatedButton(
                                        style: ButtonStyle(),
                                        onPressed: () async {
                                          await checkout();
                                        },
                                        child: const Text(
                                          "Save",
                                          style: TextStyle(fontSize: 18),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(top: 10),
                                      height: 50,
                                      child: ElevatedButton(
                                        style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStatePropertyAll(
                                            Color.fromARGB(255, 222, 13, 13),
                                          ),
                                        ),
                                        onPressed: () async {
                                          Navigator.pop(context);
                                        },
                                        child: const Text(
                                          "Close",
                                          style: TextStyle(fontSize: 18),
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              },
                            );

                            // await checkout();
                            // await Add_Supplier();
                          },
                          child: Text(
                            "Check Out",
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                      ),
                    ),
                    //  Text(""),

                    Expanded(
                      child: Container(
                        margin: EdgeInsets.all(1),
                        padding: EdgeInsets.symmetric(horizontal: 2),
                        // margin: EdgeInsets.only(top: 10),
                        height: 50,
                        child: Container(
                          padding: EdgeInsets.all(10),
                          child: Text('Total : ' + totalPrice.toString()),
                        ),
                      ),
                    )

                    // Text("$gettotal")
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}

// class CheckOut extends StatefulWidget {
//   const CheckOut({super.key});

//   @override
//   State<CheckOut> createState() => _CheckOutState();
// }

// class _CheckOutState extends State<CheckOut> {
//   GlobalKey<FormState> formstate = GlobalKey();
//   TextEditingController new_item_name = TextEditingController();

//   void initState() {
//     super.initState();
//     Get_category();
//   }

//   Future<List<dynamic>> Get_category() async {
//     var response = await _crud.getRequests(linkgetcat);

//     return response['data'];
//   }

//   String _selectedOption = '';

//   Crud _crud = Crud();

//   @override
//   Widget build(BuildContext context) {
//     return AlertDialog(
//       title: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text("add Item"),
//           Divider(
//             color: Colors.black,
//             height: 5,
//           )
//         ],
//       ),
//       content: Container(
//         height: 150,
//         child: Form(
//           key: formstate,
//           child: Column(
//             children: [
//               CustomeFormFeild(
//                 valid: (val) {
//                   return validInput(val!, 1, 200);
//                 },
//                 onTab: () {},
//                 keyboardType: TextInputType.text,
//                 textInputAction: TextInputAction.done,
//                 myController: new_item_name,
//                 label: "Item Name",
//                 isPasswort: false,
//               ),
//               const SizedBox(
//                 height: 20,
//               ),
//               // drop down list start
//               Container(
//                 decoration: BoxDecoration(
//                   border: Border.all(
//                       color: Color.fromARGB(255, 152, 151, 151),
//                       style: BorderStyle.solid),
//                   borderRadius: BorderRadius.circular(10),
//                 ),
//                 child: FutureBuilder(
//                     future: Get_category(),
//                     builder: (context, snapshot) {
//                       if (snapshot.connectionState == ConnectionState.waiting) {
//                         return CircularProgressIndicator();
//                       } else if (snapshot.hasError) {
//                         return Text('Error: ${snapshot.error}');
//                       } else if (snapshot.hasData) {
//                         final items = snapshot.data!;
//                         final dropdownItems =
//                             items.map<DropdownMenuItem<String>>((item) {
//                           return DropdownMenuItem<String>(
//                             value: item['cat_name'],
//                             child: Text(item['cat_name']),
//                           );
//                         }).toList();
//                         return Padding(
//                           padding: const EdgeInsets.all(5.0),
//                           child: DropdownButton(
//                             isExpanded: true,
//                             padding: EdgeInsets.symmetric(horizontal: 5),
//                             borderRadius: BorderRadius.circular(10),
//                             hint: _selectedOption == ""
//                                 ? Text("Select Category")
//                                 : Text(_selectedOption),
//                             items: dropdownItems,
//                             onChanged: (String? value) {
//                               setState(() {
//                                 _selectedOption = value!;
//                               });
//                             },
//                           ),
//                         );
//                       } else {
//                         return Text('No items found');
//                       }
//                     }),
//               ),
//             ],
//           ),

//           // // drop down list end
//         ),
//       ),
//       actions: [
//         Container(
//           margin: EdgeInsets.only(top: 10),
//           height: 50,
//           child: ElevatedButton(
//             style: ButtonStyle(),
//             onPressed: () async {
//               // await AddOneItem();
//             },
//             child: const Text(
//               "Save",
//               style: TextStyle(fontSize: 18),
//             ),
//           ),
//         ),
//         Container(
//           margin: EdgeInsets.only(top: 10),
//           height: 50,
//           child: ElevatedButton(
//             style: ButtonStyle(
//               backgroundColor: MaterialStatePropertyAll(
//                 Color.fromARGB(255, 222, 13, 13),
//               ),
//             ),
//             onPressed: () async {
//               Navigator.pop(context);
//             },
//             child: const Text(
//               "Close",
//               style: TextStyle(fontSize: 18),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }

// getTotalPrice() {
//   for (int i = 0; i < _cartProductModel.length; i++) {
//     if (_cartProductModel.isEmpty) return totalPrice = 0;
//     totalPrice += (double.parse(_cartProductModel[i].price) *
//         _cartProductModel[i].quantity);
//   }
// }

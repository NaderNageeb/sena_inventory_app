// ignore_for_file: prefer_const_constructors, sort_child_properties_last, use_build_context_synchronously, non_constant_identifier_names, unused_local_variable, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import '../components/crud.dart';
import '../components/custometextform.dart';
import '../components/valid.dart';
import '../constant/linkapi.dart';
import 'additemP.dart';
import 'addsupP.dart';

class AddPurchase extends StatefulWidget {
  const AddPurchase({super.key});

  @override
  State<AddPurchase> createState() => _AddPurchaseState();
}

class _AddPurchaseState extends State<AddPurchase> {
  GlobalKey<FormState> formstate = GlobalKey();

  TextEditingController item_name = TextEditingController();
  TextEditingController quantity = TextEditingController();
  TextEditingController p_price = TextEditingController();
  TextEditingController s_price = TextEditingController();
  // TextEditingController desc = TextEditingController();
  TextEditingController sup_name = TextEditingController();
  TextEditingController purchase_date = TextEditingController();

  @override
  void initState() {
    super.initState();
    Get_items();
    getSuppliers();
  }

  String _selectedOption = '';
  String _selectedSupplierId = "";

  Crud _crud = Crud();

  bool isLoading = false;

  Future<List<dynamic>> getSuppliers() async {
    var responce = await _crud.getRequests(linkgetgetsuppliers);

    return responce['data'];
  }

  Future<List<dynamic>> Get_items() async {
    var response = await _crud.getRequests(linkgetitems);

    return response['data'];
  }

  Add_Purchase() async {
    bool isLoading = true;
    setState(() {});
    if (formstate.currentState!.validate()) {
      // print(_selectedOption);
      var responce = await _crud.postRequests(linkaddpurchase, {
        'item_name': _selectedOption,
        'quantity': quantity.text,
        'p_price': p_price.text,
        's_price': s_price.text,
        // 'desc': desc.text,
        'sup_name': _selectedSupplierId,
        'purchase_date': purchase_date.text
      });

      isLoading = false;

      setState(() {});
      if (responce['status'] == 'Exist') {
        return Alert(
          context: context,
          type: AlertType.warning,
          title: "Item Exist",
          desc: "Item Already Exist",
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
      if (responce['status'] == 'success') {
        return Alert(
          context: context,
          type: AlertType.success,
          title: "Success",
          desc: "Purchase completed successfully",
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
    } else {
      print("Form not valid");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Purchase"),
      ),
      body: isLoading == true
          ? CircularProgressIndicator(
              color: Color(0xFF79AED1),
            )
          : Container(
              padding: EdgeInsets.all(5),
              child: ListView(
                children: [
                  Container(
                    padding:
                        const EdgeInsets.only(top: 15, left: 20, right: 20),
                    child: Form(
                      key: formstate,
                      // autovalidateMode: AutovalidateMode.onUserInteraction,
                      child: Column(
                        children: [
                          // drop down list Item start
                          FutureBuilder(
                              future: Get_items(),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return CircularProgressIndicator();
                                } else if (snapshot.hasError) {
                                  return Text('Error: ${snapshot.error}');
                                } else if (snapshot.hasData) {
                                  final items = snapshot.data!;

                                  final dropdownItems = items
                                      .map<DropdownMenuItem<String>>((item) {
                                    return DropdownMenuItem<String>(
                                      value: item['item_name'],
                                      child: Text(item['item_name']),
                                    );
                                  }).toList();

                                  return Container(
                                    padding: EdgeInsets.symmetric(vertical: 8),
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Color.fromARGB(
                                                255, 127, 127, 127)),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    // margin: EdgeInsets.only(right: 15),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          // flex: ,
                                          child: IconButton.filled(
                                            onPressed: () {
                                              // Navigator.pushNamed(
                                              //     context, 'additem');
                                              showDialog(
                                                context: context,
                                                builder: (context) {
                                                  return AddItemFromP();
                                                },
                                              );
                                            },
                                            icon: Icon(Icons.add),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 6,
                                          child: DropdownButton(
                                            // isExpanded: true,
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 5),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            hint: _selectedOption == ""
                                                ? Text("Select Item")
                                                : Text(_selectedOption),
                                            items: dropdownItems,
                                            onChanged: (String? value) {
                                              setState(() {
                                                _selectedOption = value!;
                                              });
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                } else {
                                  return Text('No items found');
                                }
                              }),

                          // // drop down list end
                          const SizedBox(
                            height: 10,
                          ),
                          CustomeFormFeild(
                            valid: (val) {
                              return validInput(val!, 1, 200);
                            },
                            onTab: () {},
                            keyboardType: TextInputType.number,
                            textInputAction: TextInputAction.next,
                            myController: quantity,
                            label: "Quantity",
                            isPasswort: false,
                            prefixIcon: Icon(
                              Icons.format_list_numbered,
                              // color: Color.fromARGB(255, 92, 132, 188),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          CustomeFormFeild(
                            valid: (val) {
                              return validInput(val!, 1, 200);
                            },
                            onTab: () {},
                            keyboardType: TextInputType.number,
                            textInputAction: TextInputAction.next,
                            myController: p_price,
                            label: "Purchase Price",
                            isPasswort: false,
                            prefixIcon: Icon(
                              Icons.shopping_cart,
                              // color: Color.fromARGB(255, 92, 132, 188),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          CustomeFormFeild(
                            onTab: () {},
                            valid: (val) {
                              return validInput(val!, 2, 20);
                            },
                            keyboardType: TextInputType.number,
                            textInputAction: TextInputAction.next,
                            myController: s_price,
                            label: "seale price",
                            isPasswort: false,
                            prefixIcon: Icon(
                              Icons.shopping_cart_checkout_rounded,
                              // color: Color.fromARGB(255, 92, 132, 188),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          // CustomeFormFeild(
                          //   valid: (val) {
                          //     return validInput(val!, 1, 50);
                          //   },
                          //   onTab: () {},
                          //   keyboardType: TextInputType.text,
                          //   textInputAction: TextInputAction.next,
                          //   myController: desc,
                          //   label: "Description",
                          //   isPasswort: false,
                          //   prefixIcon: Icon(
                          //     Icons.description,
                          //     // color: Color.fromARGB(255, 92, 132, 188),
                          //   ),
                          // ),
                          const SizedBox(
                            height: 10,
                          ),

                          FutureBuilder(
                              future: getSuppliers(),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return CircularProgressIndicator();
                                } else if (snapshot.hasError) {
                                  return Text('Error: ${snapshot.error}');
                                } else if (snapshot.hasData) {
                                  final supplier_data = snapshot.data!;

                                  final dropdownItems = supplier_data
                                      .map<DropdownMenuItem<String>>(
                                          (supplier_data) {
                                    return DropdownMenuItem<String>(
                                      value: supplier_data['sup_name'],
                                      child: Text(supplier_data['sup_name']),
                                    );
                                  }).toList();

                                  return Container(
                                    padding: EdgeInsets.symmetric(vertical: 8),
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Color.fromARGB(
                                                255, 127, 127, 127)),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    // margin: EdgeInsets.only(right: 15),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          // flex: ,
                                          child: IconButton.filled(
                                            onPressed: () {
                                              // Navigator.pushNamed(
                                              //     context, 'additem');
                                              showDialog(
                                                context: context,
                                                builder: (context) {
                                                  return AddSupP();
                                                },
                                              );
                                            },
                                            icon: Icon(Icons.add),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 6,
                                          child: DropdownButton(
                                            // isExpanded: true,
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 5),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            hint: _selectedSupplierId == ""
                                                ? Text("Select Supplier")
                                                : Text(_selectedSupplierId),
                                            items: dropdownItems,
                                            onChanged: (String? value) {
                                              setState(() {
                                                _selectedSupplierId = value!;
                                              });
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                } else {
                                  return Text('No items found');
                                }
                              }),

                          SizedBox(
                            height: 10,
                          ),
                          TextField(
                            controller: purchase_date,
                            //editing controller of this TextField
                            decoration: InputDecoration(
                              label: Text("purchase Date"),
                              prefixIcon: Icon(Icons.date_range),
                              iconColor: Color.fromARGB(255, 11, 65, 118),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                            ),
                            readOnly:
                                true, //set it true, so that user will not able to edit text
                            onTap: () async {
                              DateTime? pickedDate = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime
                                      .now(), //DateTime.now() - not to allow to choose before today.
                                  lastDate: DateTime(2101));

                              if (pickedDate != null) {
                                print(
                                    pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                                String formattedDate =
                                    DateFormat('yyyy-MM-dd').format(pickedDate);
                                print(
                                    formattedDate); //formatted date output using intl package =>  2021-03-16
                                //you can implement different kind of Date Format here according to your requirement

                                setState(() {
                                  purchase_date.text =
                                      formattedDate; //set output date to TextField value.
                                });
                              } else {
                                print("Expire Date not Selected");
                              }
                            },
                          ),

                          const SizedBox(
                            height: 10,
                          ),

                          Container(
                            margin: EdgeInsets.only(top: 10),
                            height: 50,
                            child: ElevatedButton(
                              onPressed: () async {
                                await Add_Purchase();
                              },
                              child: const Text(
                                "Purchase",
                                style: TextStyle(fontSize: 18),
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
    );
  }
}

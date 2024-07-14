// ignore_for_file: prefer_const_constructors, sort_child_properties_last, use_build_context_synchronously, prefer_const_literals_to_create_immutables, non_constant_identifier_names, unused_local_variable, override_on_non_overriding_member

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import '../components/crud.dart';
import '../components/custometextform.dart';
import '../components/valid.dart';
import '../constant/linkapi.dart';

class Editpurchase extends StatefulWidget {
  final purchaseData;
  const Editpurchase({super.key, required this.purchaseData});

  @override
  State<Editpurchase> createState() => _EditpurchaseState();
}

class _EditpurchaseState extends State<Editpurchase> {
  GlobalKey<FormState> formstate = GlobalKey();

  TextEditingController item_name = TextEditingController();
  TextEditingController quantity = TextEditingController();
  TextEditingController p_price = TextEditingController();
  TextEditingController s_price = TextEditingController();
  // TextEditingController desc = TextEditingController();
  TextEditingController sup_name = TextEditingController();
  TextEditingController purchase_date = TextEditingController();
  @override
  var purchaseId = "";
  String _selectedOption = '';
  String _selectedSupplierId = "";

  void initState() {
    _selectedOption = widget.purchaseData['item_name'];
    item_name.text = widget.purchaseData['item_name'];
    quantity.text = widget.purchaseData['purchase_item_qty'];
    purchaseId = widget.purchaseData['purchase_id'];
    p_price.text = widget.purchaseData['purchase_price'];
    s_price.text = widget.purchaseData['purchase_sale_price'];
    _selectedSupplierId = widget.purchaseData['sup_name'];
    purchase_date.text = widget.purchaseData['purchase_date'];

    super.initState();
    Get_items();
    getSuppliers();
  }

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

  Edit_Purchase() async {
    bool isLoading = true;
    setState(() {});
    if (formstate.currentState!.validate()) {
      // print(_selectedOption);
      var responce = await _crud.postRequests(linkeditpurchase, {
        'purchase_id': purchaseId.toString(),
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
      if (responce['status'] == '') {
        return Alert(
          context: context,
          type: AlertType.warning,
          title: "Error",
          desc: "Nothing Updated",
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
          desc: "Updated Successfully",
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
    return AlertDialog(
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Edit Purchase"),
          Divider(
            color: Colors.black,
            height: 5,
          )
        ],
      ),
      content: Container(
        height: 400,
        child: ListView(
          children: [
            Form(
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

                          final dropdownItems =
                              items.map<DropdownMenuItem<String>>((item) {
                            return DropdownMenuItem<String>(
                              value: item['item_name'],
                              child: Text(item['item_name']),
                            );
                          }).toList();

                          return Container(
                            padding: EdgeInsets.symmetric(vertical: 8),
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: Color.fromARGB(255, 127, 127, 127)),
                                borderRadius: BorderRadius.circular(10)),
                            // margin: EdgeInsets.only(right: 15),
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 6,
                                  child: DropdownButton(
                                    // isExpanded: true,
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 5),
                                    borderRadius: BorderRadius.circular(5),
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
                              .map<DropdownMenuItem<String>>((supplier_data) {
                            return DropdownMenuItem<String>(
                              value: supplier_data['sup_name'],
                              child: Text(supplier_data['sup_name']),
                            );
                          }).toList();

                          return Container(
                            padding: EdgeInsets.symmetric(vertical: 8),
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: Color.fromARGB(255, 127, 127, 127)),
                                borderRadius: BorderRadius.circular(10)),
                            // margin: EdgeInsets.only(right: 15),
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 6,
                                  child: DropdownButton(
                                    // isExpanded: true,
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 5),
                                    borderRadius: BorderRadius.circular(10),
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

                  // Container(
                  //   margin: EdgeInsets.only(top: 10),
                  //   height: 50,
                  //   child: ElevatedButton(
                  //     onPressed: () async {
                  //       await Edit_Purchase();
                  //     },
                  //     child: const Text(
                  //       "Update",
                  //       style: TextStyle(fontSize: 18),
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            ),
          ],
        ),
      ),
      actions: [
        Container(
          margin: EdgeInsets.only(top: 10),
          height: 50,
          child: ElevatedButton(
            onPressed: () async {
              await Edit_Purchase();
            },
            child: const Text(
              "Update",
              style: TextStyle(fontSize: 18),
            ),
          ),
        ),
        // Container(
        //   margin: EdgeInsets.only(top: 10),
        //   height: 50,
        //   width: 100,
        //   child: ElevatedButton(
        //     style: ButtonStyle(
        //       backgroundColor: MaterialStatePropertyAll(
        //         Color.fromARGB(255, 222, 13, 13),
        //       ),
        //     ),
        //     onPressed: () async {
        //       // await DeleteCat();
        //     },
        //     child: const Text(
        //       "Delete",
        //       style: TextStyle(fontSize: 18),
        //     ),
        //   ),
        // ),
        Container(
          width: 98,
          margin: EdgeInsets.only(top: 10),
          height: 50,
          child: ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStatePropertyAll(
                Color.fromARGB(255, 192, 173, 173),
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
  }
}

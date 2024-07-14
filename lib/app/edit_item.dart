// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, unused_local_variable, sort_child_properties_last, use_build_context_synchronously, non_constant_identifier_names, override_on_non_overriding_member, annotate_overrides

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import '../components/crud.dart';
import '../components/custometextform.dart';
import '../components/valid.dart';
import '../constant/linkapi.dart';

class EditItem extends StatefulWidget {
  final itemdata;
  const EditItem({super.key, required this.itemdata});

  @override
  State<EditItem> createState() => _EditItemState();
}

class _EditItemState extends State<EditItem> {
  GlobalKey<FormState> formstate = GlobalKey();
  TextEditingController item_name = TextEditingController();
  TextEditingController quantity = TextEditingController();
  TextEditingController p_price = TextEditingController();
  TextEditingController s_price = TextEditingController();
  TextEditingController desc = TextEditingController();
  TextEditingController expire_date = TextEditingController();
  @override
  String _selectedOption = '';
  var itemId;
  void initState() {
    item_name.text = widget.itemdata['item_name'];
    quantity.text = widget.itemdata['item_stock'];
    p_price.text = widget.itemdata['item_pay_price'];
    s_price.text = widget.itemdata['item_seale_price'];
    desc.text = widget.itemdata['item_desc'];
    expire_date.text = widget.itemdata['item_expire_date'];
    itemId = widget.itemdata['item_id'];
    _selectedOption = widget.itemdata['cat_name'];

    super.initState();
    Get_category();
  }

  Crud _crud = Crud();

  bool isLoading = false;

  Future<List<dynamic>> Get_category() async {
    var response = await _crud.getRequests(linkgetcat);

    return response['data'];
  }

  EditItem() async {
    bool isLoading = true;
    setState(() {});
    if (formstate.currentState!.validate()) {
      var responce = await _crud.postRequests(linkEditItem, {
        'item_id': itemId,
        'item_name': item_name.text,
        'quantity': quantity.text,
        'p_price': p_price.text,
        's_price': s_price.text,
        'desc': desc.text,
        'expire_date': expire_date.text,
        'item_cat_id': _selectedOption
      });

      isLoading = false;

      setState(() {});
      if (responce['status'] == 'Faild') {
        return Alert(
          context: context,
          type: AlertType.error,
          title: "Error",
          desc: "Error  Updating",
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
          desc: "Item Updated Success",
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
          Text("Edit Item"),
          Divider(
            color: Colors.black,
            height: 2,
          )
        ],
      ),
      content: Container(
        // padding: EdgeInsets.all(5),
        width: 500,
        child: ListView(
          children: [
            Container(
              // padding: const EdgeInsets.only(top: 15, left: 20, right: 20),
              child: Form(
                key: formstate,
                // autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Column(
                  children: [
                    CustomeFormFeild(
                      valid: (val) {
                        return validInput(val!, 3, 30);
                      },
                      onTab: () {},
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.next,
                      myController: item_name,
                      label: "Item name",
                      isPasswort: false,
                      prefixIcon: Icon(
                        Icons.shopping_bag,
                        // color: Color.fromARGB(255, 92, 132, 188),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
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
                      height: 20,
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
                      height: 20,
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
                      height: 20,
                    ),
                    CustomeFormFeild(
                      valid: (val) {
                        return validInput(val!, 1, 50);
                      },
                      onTab: () {},
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.next,
                      myController: desc,
                      label: "Description",
                      isPasswort: false,
                      prefixIcon: Icon(
                        Icons.description,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    // drop down list start
                    FutureBuilder(
                        future: Get_category(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Center(child: CircularProgressIndicator());
                          } else if (snapshot.hasError) {
                            return Center(
                              child: Column(
                                children: [
                                  Image.asset(
                                    "assets/empty-cart.png",
                                    // height: 100,
                                    // width: 100,
                                  ),
                                  // Text("No Comments Yet"),
                                ],
                              ),
                            );
                            // return Text('Error: ${snapshot.error}');
                          } else if (snapshot.hasData) {
                            final items = snapshot.data!;

                            final dropdownItems =
                                items.map<DropdownMenuItem<String>>((item) {
                              return DropdownMenuItem<String>(
                                value: item['cat_name'],
                                child: Text(item['cat_name']),
                              );
                            }).toList();

                            return Container(
                              padding: EdgeInsets.symmetric(vertical: 8),
                              decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Color.fromARGB(255, 127, 127, 127),
                                  ),
                                  borderRadius: BorderRadius.circular(10)),
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 6,
                                    child: DropdownButton(
                                      // isExpanded: true,
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 5),
                                      borderRadius: BorderRadius.circular(10),
                                      hint: _selectedOption == ""
                                          ? Text("Select Category")
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
                      height: 20,
                    ),
                    TextField(
                      controller: expire_date,
                      //editing controller of this TextField
                      decoration: InputDecoration(
                        label: Text("Expire Date"),
                        prefixIcon: Icon(Icons.date_range),
                        iconColor: Color.fromARGB(255, 11, 65, 118),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
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
                            expire_date.text =
                                formattedDate; //set output date to TextField value.
                          });
                        } else {
                          print("Expire Date not Selected");
                        }
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
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
            style: ButtonStyle(),
            onPressed: () async {
              await EditItem();
            },
            child: const Text(
              "Edit",
              style: TextStyle(fontSize: 18),
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 10),
          height: 50,
          child: ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStatePropertyAll(
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
  }
}

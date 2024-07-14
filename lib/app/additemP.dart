// ignore_for_file: prefer_const_constructors, sort_child_properties_last, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import '../components/crud.dart';
import '../components/custometextform.dart';
import '../components/valid.dart';
import '../constant/linkapi.dart';

class AddItemFromP extends StatefulWidget {
  const AddItemFromP({super.key});

  @override
  State<AddItemFromP> createState() => _AddItemFromPState();
}

class _AddItemFromPState extends State<AddItemFromP> {
  
  GlobalKey<FormState> formstate = GlobalKey();
  TextEditingController new_item_name = TextEditingController();

  void initState() {
    super.initState();
    Get_category();
  }

  Future<List<dynamic>> Get_category() async {
    var response = await _crud.getRequests(linkgetcat);

    return response['data'];
  }

  String _selectedOption = '';

  Crud _crud = Crud();

  AddOneItem() async {
    // print(_selectedOption);
    if (formstate.currentState!.validate()) {
      var responce = await _crud.postRequests(linkaddoneitem,
          {'item_name': new_item_name.text, 'item_cat_id': _selectedOption});
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
          desc: "Item Added Success",
          buttons: [
            DialogButton(
              child: Text(
                "Ok",
                style: TextStyle(color: Colors.black, fontSize: 20),
              ),
              onPressed: () => Navigator.pushNamed(context, "AddPurchase"),
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
          desc: "Item Added Error",
          buttons: [
            DialogButton(
              child: Text(
                "Ok",
                style: TextStyle(color: Colors.black, fontSize: 20),
              ),
              onPressed: () => Navigator.pop(context),
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
        // ignore: prefer_const_literals_to_create_immutables
        children: [
          Text("add Item"),
          Divider(
            color: Colors.black,
            height: 5,
          )
        ],
      ),
      content: Container(
        height: 150,
        child: Form(
          key: formstate,
          child: Column(
            children: [
              CustomeFormFeild(
                valid: (val) {
                  return validInput(val!, 1, 200);
                },
                onTab: () {},
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.done,
                myController: new_item_name,
                label: "Item Name",
                isPasswort: false,
              ),
              const SizedBox(
                height: 20,
              ),
              // drop down list start
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                      color: Color.fromARGB(255, 152, 151, 151),
                      style: BorderStyle.solid),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: FutureBuilder(
                    future: Get_category(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return CircularProgressIndicator();
                      } else if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      } else if (snapshot.hasData) {
                        final items = snapshot.data!;
                        final dropdownItems =
                            items.map<DropdownMenuItem<String>>((item) {
                          return DropdownMenuItem<String>(
                            value: item['cat_name'],
                            child: Text(item['cat_name']),
                          );
                        }).toList();
                        return Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: DropdownButton(
                            isExpanded: true,
                            padding: EdgeInsets.symmetric(horizontal: 5),
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
                        );
                      } else {
                        return Text('No items found');
                      }
                    }),
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
              await AddOneItem();
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

// ignore_for_file: prefer_const_constructors, sort_child_properties_last, use_build_context_synchronously, avoid_print, non_constant_identifier_names, unused_local_variable

import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import '../components/crud.dart';
import '../components/custometextform.dart';
import '../components/valid.dart';
import '../constant/linkapi.dart';

class AddUser extends StatefulWidget {
  const AddUser({super.key});

  @override
  State<AddUser> createState() => _AddUserState();
}

class _AddUserState extends State<AddUser> {
  GlobalKey<FormState> formstate = GlobalKey();
  TextEditingController username = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  String _selectedOption = '';

  final Crud _crud = Crud();
  bool isLoading = false;
  Add_User() async {
    if (formstate.currentState!.validate()) {
      // print(_selectedOption);
      var responce = await _crud.postRequests(linkadduser, {
        'username': username.text,
        'password': password.text,
        'email': email.text,
        'type': _selectedOption
      });
      if (responce['status'] == 'Exist') {
        return Alert(
          context: context,
          type: AlertType.warning,
          title: "Exist",
          desc: "User Exist",
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
          desc: "User Added ",
          buttons: [
            DialogButton(
              child: Text(
                "Ok",
                style: TextStyle(color: Colors.black, fontSize: 20),
              ),
              onPressed: () => Navigator.of(context).popAndPushNamed("users"),
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
        title: Text('Add User'),
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
                          CustomeFormFeild(
                            valid: (val) {
                              return validInput(val!, 3, 30);
                            },
                            onTab: () {},
                            keyboardType: TextInputType.text,
                            textInputAction: TextInputAction.next,
                            myController: username,
                            label: "User Name",
                            isPasswort: false,
                            prefixIcon: Icon(
                              Icons.person,
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
                            keyboardType: TextInputType.text,
                            textInputAction: TextInputAction.done,
                            myController: email,
                            label: "email",
                            isPasswort: false,
                            prefixIcon: Icon(
                              Icons.email,
                              // color: Color.fromARGB(255, 92, 132, 188),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          //
                          Container(
                            padding: EdgeInsets.symmetric(vertical: 8),
                            decoration: BoxDecoration(
                                border: Border.all(
                                  color: Color.fromARGB(255, 127, 127, 127),
                                ),
                                borderRadius: BorderRadius.circular(10)),
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Icon(
                                    Icons.people,
                                    color: Colors.grey,
                                  ),
                                ),
                                Expanded(
                                  flex: 6,
                                  child: DropdownButton(
                                    // isExpanded: true,

                                    padding:
                                        EdgeInsets.symmetric(horizontal: 5),
                                    borderRadius: BorderRadius.circular(10),
                                    hint: _selectedOption == ""
                                        ? Text("Select Type")
                                        : Text(_selectedOption),
                                    items: <String>['admin', 'user']
                                        .map<DropdownMenuItem<String>>(
                                            (String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      );
                                    }).toList(),
                                    onChanged: (String? value) {
                                      setState(() {
                                        _selectedOption = value!;
                                      });
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),

                          //
                          const SizedBox(
                            height: 20,
                          ),
                          CustomeFormFeild(
                            valid: (val) {
                              return validInput(val!, 1, 200);
                            },
                            onTab: () {},
                            keyboardType: TextInputType.text,
                            textInputAction: TextInputAction.done,
                            myController: password,
                            label: "Password",
                            isPasswort: true,
                            prefixIcon: Icon(
                              Icons.lock,
                              // color: Color.fromARGB(255, 92, 132, 188),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 10),
                            height: 50,
                            child: ElevatedButton(
                              style: ButtonStyle(
                                  // backgroundColor: MaterialStatePropertyAll(
                                  //   // Color.fromARGB(255, 92, 132, 188),
                                  // ),
                                  ),
                              onPressed: () async {
                                await Add_User();
                              },
                              child: const Text(
                                "Add",
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

// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, sort_child_properties_last, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import '../components/crud.dart';
import '../components/custometextform.dart';
import '../components/valid.dart';
import '../constant/linkapi.dart';

class EditUser extends StatefulWidget {
  final UserData;
  EditUser({super.key, required this.UserData});

  @override
  State<EditUser> createState() => _EditUserState();
}

class _EditUserState extends State<EditUser> {
  GlobalKey<FormState> formstate = GlobalKey();
  TextEditingController username = TextEditingController();
  TextEditingController email = TextEditingController();

  String _selectedOption = '';
  var userId;
  void initState() {
    // UserData
    userId = widget.UserData['user_id'];
    username.text = widget.UserData['username'];
    email.text = widget.UserData['email'];
    _selectedOption = widget.UserData['type'];
    super.initState();
  }

  final Crud _crud = Crud();
  bool isLoading = false;

  EditUser() async {
    if (formstate.currentState!.validate()) {
      // print(_selectedOption);
      var responce = await _crud.postRequests(linkedituser, {
        'user_id': userId.toString(),
        'username': username.text,
        'email': email.text,
        'type': _selectedOption
      });
      if (responce['status'] == 'Faild') {
        return Alert(
          context: context,
          type: AlertType.warning,
          title: "Error",
          desc: "User Update Wrong",
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
          desc: "User Updated ",
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

  DeleteUser() async {
    if (formstate.currentState!.validate()) {
      // print(_selectedOption);
      var responce = await _crud.postRequests(linkedeluser, {
        'user_id': userId.toString(),
      });
      if (responce['status'] == 'Faild') {
        return Alert(
          context: context,
          type: AlertType.warning,
          title: "Error",
          desc: "User Not Deleted",
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
        setState(() {});
        return Alert(
          context: context,
          type: AlertType.success,
          title: "Success",
          desc: "User Deleted ",
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
    return AlertDialog(
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Edit User"),
          Divider(
            color: Colors.black,
            height: 5,
          )
        ],
      ),
      content: Container(
        height: 320,
        child: ListView(
          children: [
            Form(
              key: formstate,
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

                            padding: EdgeInsets.symmetric(horizontal: 5),
                            borderRadius: BorderRadius.circular(10),
                            hint: _selectedOption == ""
                                ? Text("Select Type")
                                : Text(_selectedOption),
                            items: <String>['admin', 'user']
                                .map<DropdownMenuItem<String>>((String value) {
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
                ],
              ),

              // // drop down list end
            ),
            Expanded(
              flex: 1,
              child: Container(
                margin: EdgeInsets.only(top: 10),
                height: 50,
                width: 30,
                child: ElevatedButton(
                  style: ButtonStyle(),
                  onPressed: () async {
                    await EditUser();
                  },
                  child: const Text(
                    "save",
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
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
                  await DeleteUser();
                },
                child: const Text(
                  "Delete",
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
                    Color.fromARGB(255, 195, 194, 194),
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
        ),
      ],
    );
  }
}

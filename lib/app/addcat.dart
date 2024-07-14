// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: prefer_const_constructors, sort_child_properties_last, use_build_context_synchronously, non_constant_identifier_names, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import '../components/crud.dart';
import '../components/custometextform.dart';
import '../components/valid.dart';
import '../constant/linkapi.dart';

class AddCat extends StatefulWidget {
  AddCat({
    Key? key,
  }) : super(key: key);

  @override
  State<AddCat> createState() => _AddCatState();
}

class _AddCatState extends State<AddCat> {
  GlobalKey<FormState> formstate = GlobalKey();
  TextEditingController cat_name = TextEditingController();
  TextEditingController cat_desc = TextEditingController();

  final Crud _crud = Crud();

  Add_Category() async {
    if (formstate.currentState!.validate()) {
      // print(_selectedOption);
      var responce = await _crud.postRequests(
          linkaddCat, {'cat_name': cat_name.text, 'cat_desc': cat_desc.text});
      if (responce['status'] == 'Exist') {
        return Alert(
          context: context,
          type: AlertType.warning,
          title: "Exist",
          desc: "Category  Exist",
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
          desc: "Category Added ",
          buttons: [
            DialogButton(
              child: Text(
                "Ok",
                style: TextStyle(color: Colors.black, fontSize: 20),
              ),
              onPressed: () => Navigator.of(context).popAndPushNamed("additem"),
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
          Text("New Category"),
          Divider(
            color: Colors.black,
            height: 5,
          )
        ],
      ),
      content: Container(
        height: 180,
        child: Form(
          key: formstate,
          child: Column(
            children: [
              CustomeFormFeild(
                valid: (val) {
                  return validInput(val!, 1, 20);
                },
                onTab: () {},
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.next,
                myController: cat_name,
                label: "Category Name",
                isPasswort: false,
              ),
              SizedBox(
                height: 10,
              ),
              CustomeFormFeild(
                valid: (val) {
                  return validInput(val!, 1, 20);
                },
                onTab: () {},
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.done,
                myController: cat_desc,
                label: "Description",
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
              await Add_Category();
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

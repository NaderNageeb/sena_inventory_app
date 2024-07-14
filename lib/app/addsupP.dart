// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, sort_child_properties_last, use_build_context_synchronously, sized_box_for_whitespace, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import '../components/crud.dart';
import '../components/custometextform.dart';
import '../components/valid.dart';
import '../constant/linkapi.dart';

class AddSupP extends StatefulWidget {
  const AddSupP({super.key});

  @override
  State<AddSupP> createState() => _AddSupPState();
}

class _AddSupPState extends State<AddSupP> {
  GlobalKey<FormState> formstate = GlobalKey();
  TextEditingController Supplier_name = TextEditingController();
  TextEditingController Supplier_phone = TextEditingController();

  final Crud _crud = Crud();
  bool isLoading = false;

  Add_Supplier() async {
    setState(() {});
    if (formstate.currentState!.validate()) {
      // print(_selectedOption);
      var responce = await _crud.postRequests(linkaddsup,
          {'sup_name': Supplier_name.text, 'sup_phone': Supplier_phone.text});

      isLoading = false;

      setState(() {});
      if (responce['status'] == 'Exist') {
        return Alert(
          context: context,
          type: AlertType.warning,
          title: "Exist",
          desc: "Supplier Already Exist",
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
          desc: "Supplier Added ",
          buttons: [
            DialogButton(
              child: Text(
                "Ok",
                style: TextStyle(color: Colors.black, fontSize: 20),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
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
          Text("New Supplier"),
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
                  return validInput(val!, 1, 20);
                },
                onTab: () {},
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.done,
                myController: Supplier_name,
                label: "Name",
                isPasswort: false,
              ),
              const SizedBox(
                height: 20,
              ),
              CustomeFormFeild(
                valid: (val) {
                  return validInput(val!, 1, 20);
                },
                onTab: () {},
                keyboardType: TextInputType.phone,
                textInputAction: TextInputAction.done,
                myController: Supplier_phone,
                label: "Phone",
                isPasswort: false,
                prefixIcon: Icon(
                  Icons.phone,
                  // color: Color.fromARGB(255, 92, 132, 188),
                ),
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
              await Add_Supplier();
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

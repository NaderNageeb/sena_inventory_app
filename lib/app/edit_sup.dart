// ignore_for_file: prefer_const_constructors, sort_child_properties_last, use_build_context_synchronously, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import '../components/crud.dart';
import '../components/custometextform.dart';
import '../components/valid.dart';
import '../constant/linkapi.dart';

class EditSup extends StatefulWidget {
  final subData;
  const EditSup({super.key, required this.subData});

  @override
  State<EditSup> createState() => _EditSupState();
}

class _EditSupState extends State<EditSup> {
  GlobalKey<FormState> formstate = GlobalKey();
  TextEditingController Supplier_name = TextEditingController();
  TextEditingController Supplier_phone = TextEditingController();

  var sup_id;

  @override
  void initState() {
    sup_id = widget.subData['sup_id'];
    Supplier_name.text = widget.subData['sup_name'];
    Supplier_phone.text = widget.subData['sup_phone'];
    super.initState();
  }

  final Crud _crud = Crud();
  bool isLoading = false;

  EditSupplier() async {
    setState(() {});
    if (formstate.currentState!.validate()) {
      // print(_selectedOption);
      var responce = await _crud.postRequests(linkeditsub, {
        'sup_id': sup_id.toString(),
        'sup_name': Supplier_name.text,
        'sup_phone': Supplier_phone.text
      });

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
          desc: "Supplier Updated ",
          buttons: [
            DialogButton(
              child: Text(
                "Ok",
                style: TextStyle(color: Colors.black, fontSize: 20),
              ),
              onPressed: () {
                Navigator.pushNamed(context, "suppliers");
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
          Text("Edit Supplier"),
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
          child: ListView(
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
              await EditSupplier();
            },
            child: const Text(
              "Update",
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

// ignore_for_file: prefer_const_constructors, sort_child_properties_last, use_build_context_synchronously, unused_local_variable, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import '../components/crud.dart';
import '../components/custometextform.dart';
import '../components/valid.dart';
import '../constant/linkapi.dart';

class AddSuppliers extends StatefulWidget {
  const AddSuppliers({super.key});

  @override
  State<AddSuppliers> createState() => _AddSuppliersState();
}

class _AddSuppliersState extends State<AddSuppliers> {
  
  GlobalKey<FormState> formstate = GlobalKey();
  TextEditingController Supplier_name = TextEditingController();
  TextEditingController Supplier_phone = TextEditingController();

  final Crud _crud = Crud();
  bool isLoading = false;

  Add_Supplier() async {
    bool isLoading = true;
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
              onPressed: () =>
                  Navigator.of(context).popAndPushNamed("suppliers"),
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
        title: Text('Add Supplier'),
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
                            myController: Supplier_name,
                            label: "Supplier name",
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
                          const SizedBox(
                            height: 20,
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
                                await Add_Supplier();
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

// ignore_for_file: prefer_const_constructors, sort_child_properties_last, use_build_context_synchronously, avoid_print, non_constant_identifier_names, unused_local_variable

import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import '../components/crud.dart';
import '../components/custometextform.dart';
import '../components/valid.dart';
import '../constant/linkapi.dart';

class AddCategory extends StatefulWidget {
  const AddCategory({super.key});

  @override
  State<AddCategory> createState() => _AddCategoryState();
}

class _AddCategoryState extends State<AddCategory> {
  GlobalKey<FormState> formstate = GlobalKey();
  TextEditingController cat_name = TextEditingController();
  TextEditingController cat_desc = TextEditingController();

  final Crud _crud = Crud();
  bool isLoading = false;
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
              onPressed: () =>
                  Navigator.of(context).popAndPushNamed("category"),
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
        title: Text('Add Category'),
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
                            myController: cat_name,
                            label: "Name",
                            isPasswort: false,
                            prefixIcon: Icon(
                              Icons.category,
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
                            myController: cat_desc,
                            label: "Description",
                            isPasswort: false,
                            prefixIcon: Icon(
                              Icons.file_open,
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
                                await Add_Category();
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

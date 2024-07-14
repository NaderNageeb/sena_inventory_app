// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, sort_child_properties_last, use_build_context_synchronously, sized_box_for_whitespace, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import '../components/crud.dart';
import '../components/custometextform.dart';
import '../components/valid.dart';
import '../constant/linkapi.dart';

class EditCat extends StatefulWidget {
  final CatData;
  const EditCat({super.key, required this.CatData});

  @override
  State<EditCat> createState() => _EditCatState();
}

class _EditCatState extends State<EditCat> {
  GlobalKey<FormState> formstate = GlobalKey();
  TextEditingController cat_name = TextEditingController();
  TextEditingController cat_desc = TextEditingController();

  var catId;
  void initState() {
    cat_name.text = widget.CatData['cat_name'];
    cat_desc.text = widget.CatData['cat_desc'].toString();
    catId = widget.CatData['cat_id'];
    super.initState();
  }

  final Crud _crud = Crud();
  bool isLoading = false;

  Update_cat() async {
    setState(() {});
    if (formstate.currentState!.validate()) {
      // print(_selectedOption);
      var responce = await _crud.postRequests(linkeditcat, {
        'cat_id': catId,
        'cat_name': cat_name.text,
        'cat_desc': cat_desc.text
      });

      isLoading = false;

      setState(() {});
      if (responce['status'] == 'Faild') {
        return Alert(
          context: context,
          type: AlertType.warning,
          title: "Erorr",
          desc: "Category Not Update",
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
          desc: "Category Updated ",
          buttons: [
            DialogButton(
              child: Text(
                "Ok",
                style: TextStyle(color: Colors.black, fontSize: 20),
              ),
              onPressed: () {
                Navigator.popAndPushNamed(context, 'category');
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

  DeleteCat() async {
    setState(() {});
    if (formstate.currentState!.validate()) {
      // print(_selectedOption);
      var responce = await _crud.postRequests(linkdelcat, {
        'cat_id': catId,
      });

      isLoading = false;

      setState(() {});
      if (responce['status'] == 'Faild') {
        return Alert(
          context: context,
          type: AlertType.warning,
          title: "Erorr",
          desc: " Nothing Deleted",
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
          desc: "Category Deleted ",
          buttons: [
            DialogButton(
              child: Text(
                "Ok",
                style: TextStyle(color: Colors.black, fontSize: 20),
              ),
              onPressed: () {
                Navigator.popAndPushNamed(context, 'category');
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
          Text("Edit Cat"),
          Divider(
            color: Colors.black,
            height: 5,
          )
        ],
      ),
      content: Container(
        height: 200,
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
              Container(
                margin: EdgeInsets.only(top: 10),
                height: 50,
                width: 98,
                child: ElevatedButton(
                  style: ButtonStyle(),
                  onPressed: () async {
                    await Update_cat();
                  },
                  child: const Text(
                    "Save",
                    style: TextStyle(fontSize: 18),
                  ),
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
          width: 100,
          child: ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStatePropertyAll(
                Color.fromARGB(255, 222, 13, 13),
              ),
            ),
            onPressed: () async {
              await DeleteCat();
            },
            child: const Text(
              "Delete",
              style: TextStyle(fontSize: 18),
            ),
          ),
        ),
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

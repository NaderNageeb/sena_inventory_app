// ignore_for_file: prefer_const_constructors, prefer_final_fields, unused_field, non_constant_identifier_names, sort_child_properties_last, use_build_context_synchronously, unused_local_variable

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:sena_inventory/components/custometextform.dart';
import 'package:sena_inventory/components/valid.dart';

import '../components/crud.dart';
import '../constant/linkapi.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() => _ExpensesState();
}

class _ExpensesState extends State<Expenses> {
  GlobalKey<FormState> formstate = GlobalKey();
  TextEditingController expenses_name = TextEditingController();
  TextEditingController expenses_price = TextEditingController();
  TextEditingController expenses_date = TextEditingController();

  Crud _crud = Crud();

  bool isLoading = false;

  AddExpenses() async {
    bool isLoading = true;
    setState(() {});
    if (formstate.currentState!.validate()) {
      var responce = await _crud.postRequests(linkexpenses, {
        "expenses_name": expenses_name.text,
        "expenses_price": expenses_price.text,
        "expenses_date": expenses_date.text
      });

      isLoading = false;

      setState(() {});
      if (responce['status'] == 'Exist') {
        return Alert(
          context: context,
          type: AlertType.warning,
          title: "Exist",
          desc: "Expenses Exist",
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
          desc: "Expenses Added ",
          buttons: [
            DialogButton(
              child: Text(
                "Ok",
                style: TextStyle(color: Colors.black, fontSize: 20),
              ),
              onPressed: () =>
                  Navigator.of(context).popAndPushNamed("view_expenses"),
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
        title: Text("Expenses"),
        elevation: 0,
      ),
      body: isLoading == true
          ? CircularProgressIndicator()
          : Container(
              padding: EdgeInsets.all(5),
              child: ListView(
                children: [
                  Container(
                    padding: EdgeInsets.all(5),
                    margin: EdgeInsets.all(5),
                    child: Text(
                        "Expenses include any amounts paid directly, such as salaries, electricity bills, etc...."),
                  ),
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
                              return validInput(val!, 2, 100);
                            },
                            onTab: () {},
                            keyboardType: TextInputType.text,
                            textInputAction: TextInputAction.next,
                            myController: expenses_name,
                            label: "Expense name",
                            isPasswort: false,
                            prefixIcon: Icon(
                              Icons.description,
                              // color: Color.fromARGB(255, 92, 132, 188),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          CustomeFormFeild(
                            valid: (val) {
                              return validInput(val!, 3, 20);
                            },
                            // keyboardType: TextInputType.none,
                            onTab: () {},
                            keyboardType: TextInputType.number,
                            textInputAction: TextInputAction.done,
                            myController: expenses_price,
                            label: "Expense price",
                            isPasswort: false,
                            prefixIcon: Icon(
                              Icons.attach_money_sharp,
                              // color: Color.fromARGB(255, 92, 132, 188),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          TextField(
                            controller: expenses_date,
                            //editing controller of this TextField
                            decoration: InputDecoration(
                              label: Text("Expenses Date"),
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
                                  expenses_date.text =
                                      formattedDate; //set output date to TextField value.
                                });
                              } else {
                                print("Expenses Date not Selected");
                              }
                            },
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
                                await AddExpenses();
                              },
                              child: const Text(
                                "Save",
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

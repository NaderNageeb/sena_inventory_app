// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace, use_build_context_synchronously, sort_child_properties_last, unused_import

import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:sena_inventory/components/custometextform.dart';
import 'package:sena_inventory/main.dart';

import '../../components/alerts.dart';
import '../../components/crud.dart';
import '../../components/valid.dart';
import '../../constant/linkapi.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  GlobalKey<FormState> formstate = GlobalKey();
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();

  Crud _crud = Crud();
  bool isLoading = false;

  loginUser() async {
    if (formstate.currentState!.validate()) {
      isLoading = true;
      setState(() {});
      var responce = await _crud.postRequests(linkLogin, {
        'username': username.text,
        'password': password.text,
      });
      isLoading = false;
      setState(() {});

      if (responce['status'] == 'success') {
        sharedPref.setString('user_id', responce['data']['user_id'].toString());
        sharedPref.setString('username', responce['data']['username']);
        sharedPref.setString('email', responce['data']['email']);
        sharedPref.setString('type', responce['data']['type'].toString());
        return Navigator.of(context)
            .pushNamedAndRemoveUntil("home", (route) => false);
      } else {
        return Alert(
          context: context,
          type: AlertType.error,
          title: "Login Error",
          desc: "Wrong User Name Or Password",
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

        //
        // return showDialog(
        //   context: context,
        //   builder: (context) {
        //     return AlertFailed(
        //       message: "Wrong User Name or Password",
        //       // routename: "login",
        //     );
        //   },
        // );
      }
    } else {
      print("Form not valid");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: isLoading == true
          ? Center(
              child: CircularProgressIndicator(
                color: Colors.black,
              ),
            )
          : ListView(
              children: [
                Center(
                  child: Container(
                    padding: EdgeInsets.all(5),
                    margin: EdgeInsets.only(top: 60),
                    width: 200,
                    height: 200,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("assets/inv.ico"),
                      ),
                    ),
                  ),
                ),
                // Center(
                //   child: Text(
                //     "Just Go For It",
                //     style: TextStyle(fontStyle: FontStyle.italic, fontSize: 20),
                //   ),
                // ),
                Container(
                  padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
                  child: Form(
                    key: formstate,
                    child: Column(
                      children: [
                        CustomeFormFeild(
                          valid: (val) {
                            return validInput(val!, 3, 20);
                          },
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.next,
                          myController: username,
                          label: "User name",
                          isPasswort: false,
                          prefixIcon: Icon(
                            Icons.person,
                            // color: Color.fromARGB(255, 92, 132, 188),
                          ),
                          onTab: () {},
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        CustomeFormFeild(
                          valid: (val) {
                            return validInput(val!, 3, 8);
                          },
                          textInputAction: TextInputAction.done,
                          myController: password,
                          label: "Password",
                          isPasswort: true,
                          prefixIcon: Icon(
                            Icons.lock,
                            // color: Color.fromARGB(255, 92, 132, 188),
                          ),
                          onTab: () {},
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 20),
                          height: 50,
                          width: 150,
                          child: ElevatedButton(
                            // style: ButtonStyle(
                            //     backgroundColor: MaterialStatePropertyAll(
                            //         Color(0xff0B4CA6))),
                            onPressed: () async {
                              await loginUser();
                            },
                            child: const Text(
                              "Login",
                              style: TextStyle(fontSize: 18),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}

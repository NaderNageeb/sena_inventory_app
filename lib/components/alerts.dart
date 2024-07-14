// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, must_be_immutable

import 'package:flutter/material.dart';

class AlertSuccess extends StatelessWidget {
  String message;
  String routename;

  AlertSuccess({super.key, required this.message, required this.routename});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      content: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
        ),
        height: 80,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "$message Success",
                  style: TextStyle(fontSize: 15, color: Colors.green),
                ),
                Icon(
                  Icons.check,
                  color: Colors.green,
                )
              ],
            ),
            Divider(
              height: 1,
              color: Colors.black,
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pushNamed(routename);
                // route;
              },
              child: Text(
                "Ok",
                style: TextStyle(color: Colors.black),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AlertWarning extends StatelessWidget {
  String message;

  AlertWarning({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      content: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
        ),
        height: 80,
        child: Center(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    message,
                    style: TextStyle(fontSize: 15, color: Colors.yellow[700]),
                  ),
                  Icon(
                    Icons.warning,
                    color: Colors.yellow[700],
                  )
                ],
              ),
              Divider(
                height: 1,
                color: Colors.black,
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  // route;
                },
                child: Text(
                  "Ok",
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AlertFailed extends StatelessWidget {
  String message;

  AlertFailed({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      content: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
        ),
        height: 110,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 210,
                  child: Text(
                    message,
                    style: TextStyle(fontSize: 15, color: Colors.red),
                  ),
                ),
                Icon(
                  Icons.cancel,
                  color: Colors.red,
                )
              ],
            ),
            Divider(
              height: 1,
              color: Colors.black,
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                // route;
              },
              child: Text(
                "Ok",
                style: TextStyle(color: Colors.black),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomeAlert extends StatelessWidget {
  String message;



  CustomeAlert({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      content: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
        ),
        height: 80,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "$message Success",
                  style: TextStyle(fontSize: 15, color: Colors.green),
                ),
                Icon(
                  Icons.check,
                  color: Colors.green,
                )
              ],
            ),
            Divider(
              height: 1,
              color: Colors.black,
            ),
            TextButton(
              onPressed: () {
                // Navigator.of(context).pushNamed(routename);
                Navigator.of(context).pop();
              },
              child: Text(
                "Ok",
                style: TextStyle(color: Colors.black),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

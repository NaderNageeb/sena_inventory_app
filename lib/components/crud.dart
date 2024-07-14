// ignore_for_file: unused_local_variable

import 'dart:io';

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:path/path.dart';

class Crud {
  getRequests(String url) async {
    // static delay
    // Future.delayed(
    //   Duration(seconds: 2),
    // );

    try {
      var responce = await http.get(Uri.parse(url));
      if (responce.statusCode == 200) {
        var responcebody = jsonDecode(responce.body);
        return responcebody;
      } else {
        print("Error  ${responce.statusCode}");
      }
    } catch (e) {
      print("error catch $e");
    }
  }

  postRequests(String url, Map data) async {
    try {
      var responce = await http.post(Uri.parse(url), body: data);
      if (responce.statusCode == 200) {
        var responcebody = jsonDecode(responce.body);
        return responcebody;
      } else {
        print("Error  ${responce.statusCode}");
      }
    } catch (e) {
      print("error catch $e");
    }
  }

//Uplode image function 
  postReuestWithFile(String url, Map data, File file) async {
    // MultipartRequest : used this request to uploade file
    var request = http.MultipartRequest("POST", Uri.parse(url));
    // file.length():make me to get the file length;
    var length = await file.length();
    // http.ByteStream(file.openRead() : make me to open and read file to see the stream
    //http.ByteStream(file.openRead(): تجعلني اقراء تدفق البيانات
    // basename(path) : bring me the file name from the path that saved into
    var stream = http.ByteStream(file.openRead());
    var multiPartFile = http.MultipartFile("file", stream, length,
        filename: basename(file.path));
    request.files.add(multiPartFile);
    data.forEach((key, value) {
      request.fields[key] = value;
    });
    var myrequest = await request.send();
    var responce = await http.Response.fromStream(myrequest);
       if (myrequest.statusCode == 200) {
        var responcebody = jsonDecode(responce.body);
        return responcebody;
      } else {
        print("Error  ${myrequest.statusCode}");
      }
  }
}

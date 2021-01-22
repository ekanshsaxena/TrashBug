/*Image*/
import 'dart:async';
import 'dart:typed_data';
import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';

import '../main.dart';

class TestImage extends StatefulWidget {
  @override
  TestImageState createState() {
    return TestImageState();
  }
}

class TestImageState extends State<TestImage> {
  addData() async {
    var url = "http://128.199.16.159:8448/";
    Dio dio = new Dio();
    String filename1 = _aadhar == null ? " " : _aadhar.path.split('/').last;
    FormData formData = new FormData.fromMap({
      "file": _aadhar == null
          ? ""
          : await MultipartFile.fromFile(_aadhar.path,
              filename: filename1,
              contentType: MediaType('image', "png/jpeg/jpg")),
    });
    final response = await dio.post(url, data: formData);
    if (response.statusCode == 200) {
      setState(() {
        _bytedimage = base64Decode(json.decode(response.data)["img"]);
        error = "successful";
        _isLoading = false;
        statusAadhar = "No File Choosen";
        _aadhar = null;
      });
      //Navigator.push(context, MaterialPageRoute(builder: (context) => MainPage()));

    } else {
      setState(() {
        _isLoading = false;
      });
      print(response.toString());
    }
  }

  // ignore: slash_for_doc_comments
  /*********************************************************DECLARE VARIABLES*********************************************************/
  final _formKey = GlobalKey<FormState>();
  String error = '';
  bool _isLoading = false;
  String statusAadhar = "No File Choosen";
  File _aadhar;
  Uint8List _bytedimage;
  String imageStr;

  @override
  Widget build(BuildContext context) {
    Future chooseAadhar() async {
      // ignore: deprecated_member_use
      var img = await ImagePicker.pickImage(source: ImageSource.gallery);
      setState(() {
        _aadhar = img;
        statusAadhar = "File Choosen";
      });
    }

    return Scaffold(
      backgroundColor: Colors.blue[50],
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text("Form"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            return Navigator.pushAndRemoveUntil(context,
                MaterialPageRoute(builder: (context) {
              return MyApp();
            }), (route) => false);
          },
        ),
      ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(
                valueColor: new AlwaysStoppedAnimation<Color>(Colors.blue),
              ),
            )
          : Form(
              key: _formKey,
              child: new ListView(
                shrinkWrap: true,
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                children: <Widget>[
                  SizedBox(height: 30.0),

                  //------------------------Aadhar---------------------------------
                  Padding(padding: EdgeInsets.only(top: 10)),
                  Text(
                    statusAadhar,
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  OutlineButton(
                    onPressed: () {
                      chooseAadhar();
                    },
                    child: Text("Upload Image"),
                  ),

                  //************************Submit Button**************************
                  new Container(
                      padding: const EdgeInsets.only(
                          left: 110.0, right: 130.0, top: 10.0),
                      child: new RaisedButton(
                        child: const Text("Submit"),
                        onPressed: () {
                          if (_formKey.currentState.validate()) {
                            setState(() {
                              _isLoading = true;
                            });
                            addData();
                          }
                        },
                      )),
                  SizedBox(height: 12.0),
                  Center(
                    child: Text(
                      error,
                      style: TextStyle(color: Colors.green, fontSize: 18.0),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      //crossAxisAlignment: CrossAxisAlignment.,
                      children: <Widget>[
                        Expanded(
                          child: Container(
                            constraints: BoxConstraints(maxHeight: 40),
                            child: RaisedButton(
                              elevation: 8.0,
                              color: Color.fromRGBO(217, 37, 80, 1),
                              child: Text(
                                "IMAGE",
                                style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                              onPressed: () async {
                                await showDialog(
                                    context: context,
                                    builder: (_) => AadharImageDialog(
                                          //bytedimage: _bytedimage,
                                          btimg: _bytedimage,
                                        ));
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}

// ignore: must_be_immutable
class AadharImageDialog extends StatelessWidget {
  Uint8List btimg;
  //String imageStr;
  AadharImageDialog({this.btimg});
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        width: double.infinity,
        // decoration: BoxDecoration(
        //     image: DecorationImage(
        //         image: Image.memory(btimg),
        //         fit: BoxFit.contain)),
        child: new ListTile(
          leading: new Image.memory(btimg),
          title: new Text("image"),
        ),
      ),
    );
  }
}

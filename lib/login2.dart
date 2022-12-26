import 'dart:ffi';
import 'dart:ui';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:project_pos/bikin_file.dart';
import 'package:project_pos/service/SP_service/SP_service.dart';
import 'package:project_pos/service/API_service/API_service.dart';
import 'package:dio/dio.dart';
import 'package:relative_scale/relative_scale.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import 'package:project_pos/auth_service.dart';
import 'package:project_pos/globals.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RamayanaLogin2 extends StatefulWidget {
  @override
  _RamayanaLogin2 createState() => _RamayanaLogin2();
}

class _RamayanaLogin2 extends State<RamayanaLogin2> {

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _user_name = '';
  String _password = '';
  static UserData userData = UserData();

  loginPressed() async {
    if (_user_name.isNotEmpty && _password.isNotEmpty) {
      http.Response response = await AuthServices.login(_user_name, _password);

      Map responseMap = jsonDecode(response.body);
      print('UYUY 44');
      print(responseMap['status']);
      print('UYUY 55');
      print(response.statusCode);
      if (responseMap['status'] == 200) {
        await userData.setUser(data: responseMap);

        SharedPreferences pref = await SharedPreferences.getInstance();
        pref.setString("username", "${userData.getUsernameID()}");
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => BikinFile()),
                (Route<dynamic> route) => false);
        print('Masuk ke sini Profil');
      } else {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => RamayanaLogin2()),
                (Route<dynamic> route) => true);
        print('Masuk ke Sini Ramayana');
      }
    }
  }

  void showWarning() {}

  @override
  Widget build(BuildContext context) {
    return RelativeBuilder(builder: (context, height, width, sy, sx)
    {
      return Scaffold(
        body: Stack(
          children: <Widget>[
            Container(
              height: 768,
              // width: 650,
              // color: Colors.red,
              // margin: EdgeInsets.only(left: 400),
              decoration: BoxDecoration(
                color: Colors.redAccent,
              ),
              child: Image.asset('assets/ui_no.png',
                fit: BoxFit.fill,),
            ),
            Container(
              height: 300,
              width: 230,
              // color: Colors.red,
              margin: EdgeInsets.only(left: 40, top: 160),
              child: Form(
                key: _formKey, 
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      onChanged: (value) {
                        _user_name = value;
                      },
                      style: TextStyle(color: Colors.black, fontSize: 25),
                      validator: RequiredValidator(errorText: "Wajib Diisi!"),
                      keyboardType: TextInputType.multiline,
                      decoration: InputDecoration(
                        errorStyle: TextStyle(color: Colors.black),
                        labelStyle: TextStyle(color: Colors.black),
                        prefixIcon: Icon(
                          Icons.person,
                          color: Colors.black,
                        ),
                        hintText: 'Username',
                        hintStyle: TextStyle(color: Colors.black),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                    ),
                    SizedBox(height: 25),
                    TextFormField(
                      onChanged: (value) {
                        _password = value;
                      },
                      obscureText: true,
                      style: TextStyle(color: Colors.black, fontSize: 25),
                      validator: RequiredValidator(errorText: "Wajib Diisi!"),
                      keyboardType: TextInputType.multiline,
                      decoration: InputDecoration(
                          errorStyle: TextStyle(color: Colors.black),
                          labelStyle: TextStyle(color: Colors.black),
                          prefixIcon: Icon(
                            Icons.lock,
                            color: Colors.black,
                          ),
                          hintText: 'Password',
                          hintStyle: TextStyle(color: Colors.black),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30)
                          )
                      ),
                    ),
                    SizedBox(height: 50),
                    MaterialButton(
                        height: 50,
                        minWidth: 200,
                        padding: EdgeInsets.symmetric(),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: Text(
                          'Sign In',
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                        color: Colors.red,
                        onPressed: () async {
                          if (_formKey.currentState!.validate()){
                            loginPressed();
                          };
                        }
                    ),

                  ],
                ),
              ),
            )

          ],
        ),
      );
    }
    );
  }
}

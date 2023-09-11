import 'dart:convert';

import 'package:day53/bottomnabbar/orderpage.dart';

import 'package:day53/widget/common_widget.dart';
import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:http/http.dart' as http;
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:shared_preferences/shared_preferences.dart';
class Loginn extends StatefulWidget {
  const Loginn({Key? key}) : super(key: key);

  @override
  State<Loginn> createState() => _LoginnState();
}

class _LoginnState extends State<Loginn> {
  TextEditingController _emController = TextEditingController();
  TextEditingController _passController = TextEditingController();
  final GlobalKey<FormState> _fromkey = GlobalKey();
  bool isObsecure = true;



  getLogin() async {
    try {
      setState(() {
        isLoading = true;
      });
      SharedPreferences sharedPreferences =
      await SharedPreferences.getInstance();
      String link = "${baseUrl}sign-in";
      var map = Map<String, dynamic>();
      map["email"] = _emController.text.toString();
      map["password"] = _passController.text.toString();
      var responce = await http.post(Uri.parse(link), body: map);
      var data = jsonDecode(responce.body);
      setState(() {
        isLoading = false;
      });
      print("access token is ${data["access_token"]}");
      if (data["access_token"] != null) {
        sharedPreferences.setString("token", data["access_token"]);
        print("saved token is ${sharedPreferences.getString("token")}");
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => OrderPage()),
                (route) => false);
      } else {
        showInToast("Email or Password doesn't match");
      }
    } catch (e) {
      print(e);
    }
  }

  bool isLoading = false;

  @override
  void dispose() {
    // TODO: implement dispose
    _emController.dispose();
    _passController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isLoading == true,
      blur: 0.5,
      opacity: 0.5,
      child: Scaffold(
        backgroundColor: Colors.white54.withOpacity(.8),
        appBar: AppBar(
          title: Text('SignIn'),
          centerTitle: true,
          actions: [Icon(Icons.local_fire_department_outlined)],
        ),
        body: Container(
            decoration: BoxDecoration(),
            child: Padding(
              padding: EdgeInsets.only(top: 100, left: 15, right: 15),
              child: Form(
                key: _fromkey,
                child: ListView(
                  children: [
                    //Center(child: Text("Login", style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold, color: Colors.white),)),
                    SizedBox(
                      height: 50,
                    ),

                    TextField(
                      controller: _emController,
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            width: 3,
                            color: Color(0xff7B81EC),
                          ),
                          borderRadius: BorderRadius.circular(50.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            width: 3,
                            color: Color(0xff7B81EC),
                          ),
                          borderRadius: BorderRadius.circular(50.0),
                        ),
                        hintText: "Email",
                        suffixIcon: Icon(
                          Icons.email_outlined,
                          color: Colors.black54,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: _passController,
                      obscureText: isObsecure,
                      obscuringCharacter: "•",
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please Enter Password';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            width: 3,
                            color: Color(0xff7B81EC),
                          ),
                          borderRadius: BorderRadius.circular(50.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            width: 3,
                            color: Color(0xff7B81EC),
                          ),
                          borderRadius: BorderRadius.circular(50.0),
                        ),
                        hintText: "Password",
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              isObsecure = !isObsecure;
                            });
                          },
                          icon: Icon(
                            isObsecure == true
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: Colors.black54,
                          ),
                        ),
                      ),
                    ),

                    SizedBox(
                      height: 20,
                    ),

                    InkWell(
                      onTap: () {
                        if (_fromkey.currentState!.validate()) {
                          getLogin();
                        } else {
                          showInToast("Enter all fields");
                        }
                      },
                      child: Container(
                        height: 55,
                        child: Center(
                            child: Text(
                              "Login",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700),
                            )),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(colors: [
                            Color(0xff5660CD),
                            Color(0xff7B81EC),
                          ]),
                          borderRadius: BorderRadius.circular(50),
                        ),
                      ),
                    ),

                    SizedBox(
                      height: 10,
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Don't have an account? ",
                          style: TextStyle(
                              color: Colors.grey,
                              fontSize: 16,
                              fontWeight: FontWeight.w400),
                        ),
                        TextButton(
                          onPressed: () {},
                          child: Text(
                            "Sign Up",
                            style: TextStyle(
                                color: Color(0xff7B81EC),
                                fontSize: 20,
                                fontWeight: FontWeight.w700),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            )),
      ),
    );
  }
}

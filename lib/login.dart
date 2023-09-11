import 'dart:convert';

import 'package:day53/bottomnabbar/bottomnavbar.dart';
import 'package:day53/signup.dart';
import 'package:day53/widget/common_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final GlobalKey<FormState> _fromkey = GlobalKey();
  bool isObsecure = true;

  TextEditingController _emailcontroller = TextEditingController();
  TextEditingController _passwordcontroller = TextEditingController();

  getLogin() async {
    try {
      setState(() {
        isLoading = true;
      });
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      String link = "${baseUrl}sign-in";
      var map = Map<String, dynamic>();
      map["email"] = _emailcontroller.text.toString();
      map["password"] = _passwordcontroller.text.toString();
      var responce = await http.post(Uri.parse(link), body: map);
      var data = jsonDecode(responce.body);
      setState(() {
        isLoading = false;
      });
      //print("access token is ${data["access_token"]}");
      if (data["access_token"] != null) {
        sharedPreferences.setString("token", data["access_token"]);
        //print("saved token is ${sharedPreferences.getString("token")}");
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => BottomNavBarDemo()),
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
    _emailcontroller.dispose();
    _passwordcontroller.dispose();
    super.dispose();
  }

  // getlogin()async{
  //    try{
  //      setState(() {
  //        isloading = true;
  //      });
  //      SharedPreferences sharedpreference = await SharedPreferences.getInstance();
  //      String link = "${baseUrl}sign-in";
  //      var map = Map<String,dynamic>();
  //
  //      map["email"] = _emailcontroller.text.toString();
  //      map["password"] = _passwordcontroller.text.toString();
  //
  //      var responce = await http.post(Uri.parse(link), body: map);
  //      var data = jsonDecode(responce.body);
  //      setState(() {
  //        isloading = false;
  //      });
  //      print("access token is ${data["access_token"]}");
  //      if (data["access_token"] != null) {
  //        sharedpreference.setString("token", data["access_token"]);
  //        print("saved token is ${sharedpreference.getString("token")}");
  //        Navigator.of(context).pushAndRemoveUntil(
  //            MaterialPageRoute(builder: (context) => HomePage()),
  //                (route) => false);
  //      } else {
  //        showInToast("Email or Password doesn't match");
  //      }
  //    }catch(e){
  //      print(e);
  //    }
  //    isobsecure = false;
  //    //
  //    // @override
  //    // void dispose() {
  //    //   // TODO: implement dispose
  //    //   _emailcontroller.dispose();
  //    //   _passwordcontroller.dispose();
  //    //   super.dispose();
  //    // }
  //
  // }

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
            padding: EdgeInsets.all(20),
            child: Form(
              key: _fromkey,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    //Icon(Icons.abc),
                    Text(
                      "Log In Here",
                      style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    CircleAvatar(
                      radius: 80,
                      backgroundImage: NetworkImage(
                          'https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8dXNlciUyMHByb2ZpbGV8ZW58MHx8MHx8&w=1000&q=80'),
                      backgroundColor: Colors.grey.withOpacity(.6),
                      // child: Icon(
                      //   Icons.local_fire_department_outlined,
                      //   size: 100,
                      //   color: Color.fromARGB(255, 174, 140, 30),
                      // ),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                  CustomeTextFieldd(Controller: _emailcontroller,
                  hintText: "Enter Email",
                    icon: Icons.email_outlined,
                    leveltext: "Email",

                  )
                    ,
                    SizedBox(
                      height: 20,
                    ),
                    // TextField(
                    //   controller: _passwordcontroller,
                    // ),
                    TextFormField(
                      //obscureText: true,
                      controller: _passwordcontroller,
                      obscureText: isObsecure,
                      obscuringCharacter: "*",
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please Enter Password';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              isObsecure = !isObsecure;
                            });
                          },
                          icon: Icon(
                            isObsecure == false
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: Colors.black54,
                          ),
                        ),
                        prefixIcon: Icon(Icons.key_off_outlined),
                        border: OutlineInputBorder(),
                        labelText: 'Password',
                        hintText: 'Enter Your Password',
                      ),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    // MaterialButton(
                    //
                    //   //elevation: 10,
                    //   shape: RoundedRectangleBorder(
                    //       borderRadius: BorderRadius.circular(15)),
                    //   height: 60,
                    //   minWidth: MediaQuery.of(context).size.width * .5,
                    //   color:  Color(0xffFABC3D),
                    //   onPressed: () {
                    //     if (_fromkey.currentState!.validate()) {
                    //       getLogin();
                    //     } else {
                    //       showInToast("Enter all fields");
                    //     }
                    //   },
                    //   child: Text(
                    //     'Sign In',
                    //     style: TextStyle(
                    //         fontSize: 20,
                    //         color: Colors.black,
                    //         fontWeight: FontWeight.bold),
                    //   ),
                    // ),
                    MaterialButton(
                      elevation: 10,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                      height: 60,
                      minWidth: MediaQuery.of(context).size.width * .5,
                      color: Color(0xffFABC3D),
                      onPressed: () {
                        if (_fromkey.currentState!.validate()) {
                          getLogin();
                        } else {
                          showInToast("wrong");
                        }
                      },
                      child: Text(
                        'SignIn',
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(height: 20),
                    GestureDetector(
                        onTap: () {
                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: (context) => SignUp()));
                        },
                        child: Text(
                          "Don't have an account? Sign up",
                          style: TextStyle(fontSize: 12),
                        ))
                  ],
                ),
              ),
            ),
          )),
    );
  }
}

// ignore: must_be_immutable
class CustomeTextFieldd extends StatelessWidget {
  CustomeTextFieldd( {this.leveltext, this.hintText, required this.Controller,this.icon});

  String ? leveltext;
  String? hintText;
     IconData? icon;
  final TextEditingController Controller;

  @override
  Widget build(BuildContext context) {

    return TextField(
      controller: Controller,
      decoration: InputDecoration(
        // fillColor: Colors.yellow,
        prefixIcon: Icon(icon),
        border: OutlineInputBorder(),
        labelText: leveltext,
        hintText: hintText,
      ),
    );
  }
}

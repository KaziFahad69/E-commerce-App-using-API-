
import 'package:day53/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController _emailcontroller = TextEditingController();
  TextEditingController _passwordcontroller = TextEditingController();
  TextEditingController _phonecontroller = TextEditingController();
  TextEditingController _namecontroller = TextEditingController();





  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          //backgroundColor: Colors.black,

          appBar: AppBar(
            title: Text('SignUp'),
            centerTitle: true,
            actions: [Icon(Icons.local_fire_department_outlined)],
          ),
          body:
          Stack(
            children: [
              Container(

                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage("https://images.unsplash.com/photo-1611068813580-b07ef920964b?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8d2FsbHBhcGVyJTIwZm9yJTIwbW9iaWxlfGVufDB8fDB8fA%3D%3D&w=1000&q=80"),
                      fit: BoxFit.cover
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  height: 500,
                  decoration: BoxDecoration(

                    color: Colors.white,
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(30),topRight: Radius.circular(30)),
                  ),

                  padding: EdgeInsets.all(20),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        //Icon(Icons.abc),
                        Text(
                          "Sign Up Here",
                          style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),

                        // CircleAvatar(
                        //   radius: 80,
                        //
                        //   // backgroundImage: NetworkImage(
                        //   //     'https://t3.ftcdn.net/jpg/03/46/83/96/360_F_346839683_6nAPzbhpSkIpb8pmAwufkC7c5eD7wYws.jpg'),
                        //   backgroundColor: Colors.grey.withOpacity(.6),
                        //   child: Icon(
                        //     Icons.local_fire_department_outlined,
                        //     size: 100,
                        //     color: Color.fromARGB(255, 174, 140, 30),
                        //   ),
                        // ),
                        SizedBox(
                          height: 40,
                        ),
                        TextField(
                          controller: _namecontroller,
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.person),
                            border: OutlineInputBorder(),
                            labelText: 'User Name',
                            hintText: 'Enter Your Name',
                          ),
                        ),
                        // TextField(
                        //   controller: _emailcontroller,
                        // ),
                        SizedBox(
                          height: 20,
                        ),
                        // TextField(
                        //   controller: _passwordcontroller,
                        // ),
                        TextField(
                          // obscureText: true,
                          controller: _phonecontroller,
                          decoration: InputDecoration(
                            //suffixIcon: Icon(Icons.phone_android_outlined),
                            prefixIcon: Icon(Icons.phone_android_outlined),
                            border: OutlineInputBorder(),
                            labelText: 'Phone',
                            hintText: 'Enter Your Phone Number',
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextField(
                          controller: _emailcontroller,
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.mail_lock_outlined),
                            border: OutlineInputBorder(),
                            labelText: 'User email',
                            hintText: 'Enter Your Email Address',
                          ),
                        ),
                        // TextField(
                        //   controller: _emailcontroller,
                        // ),
                        SizedBox(
                          height: 20,
                        ),
                        // TextField(
                        //   controller: _passwordcontroller,
                        // ),
                        TextField(
                          obscureText: true,
                          controller: _passwordcontroller,
                          decoration: InputDecoration(
                            suffixIcon: Icon(Icons.remove_red_eye_rounded),
                            prefixIcon: Icon(Icons.key_off_outlined),
                            border: OutlineInputBorder(),
                            labelText: 'Password',
                            hintText: 'Enter Your Password',
                          ),
                        ),
                        SizedBox(
                          height: 40,
                        ),

                        MaterialButton(
                          elevation: 10,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15)),
                          height: 60,
                          minWidth: MediaQuery.of(context).size.width * .5,
                          color:  Color(0xffFABC3D),
                          onPressed: () {


                          },
                          child: Text(
                            'Sign Up',
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(height: 20),
                        GestureDetector(
                            onTap: (){
                              Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>SignIn()));
                            }
                            ,
                            child: Text("Already have an account? Log in",style: TextStyle(fontSize: 12),))
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        )
    );
  }
}

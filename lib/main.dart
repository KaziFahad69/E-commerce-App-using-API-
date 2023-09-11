import 'package:day53/bottomnabbar/bottomnavbar.dart';
import 'package:day53/page/splashscreen.dart';
import 'package:day53/provider/adminprofile_provider.dart';
import 'package:day53/provider/categoryprovider.dart';
import 'package:day53/provider/orderprovider.dart';
import 'package:day53/provider/productprovider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context)=>OrderProvider()),
        ChangeNotifierProvider(create: (context)=>CategoryProvider()),
        ChangeNotifierProvider(create: (context)=>ProductProvider()),
        ChangeNotifierProvider(create: (context)=>AdminProvider()),
       // ChangeNotifierProvider(create: (context)=>PriceProvider()),
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false, title: 'Flutter Demo',
          home:
          //SignIn()
          //BottomNavBarDemo()
          SplashScreen()
          //OrderPage()
          ),
    );
  }
}

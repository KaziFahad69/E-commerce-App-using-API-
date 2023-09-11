import 'dart:convert';

import 'package:day53/design/app_color.dart';
import 'package:day53/design/custom_textstyle.dart';
import 'package:day53/model/ordermodel.dart';
import 'package:day53/provider/orderprovider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;
import 'package:jiffy/jiffy.dart';
import 'package:provider/provider.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({Key? key}) : super(key: key);

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  @override
  void initState() {
    // TODO: implement initState
    Provider.of<OrderProvider>(context, listen: false).getOrderData();
    super.initState();
  }

  // Map<String, dynamic>? orderMap;
  //
  // fetchorderdata() async {
  //   String orderUrl = "https://apihomechef.antopolis.xyz/api/admin/all/orders";
  //
  //   var orderresponse = await http.get(Uri.parse(orderUrl));
  //
  //   var forecastResponce = await http.get(Uri.parse(orderUrl));
  //   orderMap = Map<String, dynamic>.from(jsonDecode(orderresponse.body));
  //
  //   setState(() {});
  //    //print("eeeeeeeeeee${orderMap![0]}");
  // }
//   String link = "https://apihomechef.antopolis.xyz/api/admin/all/orders";
//   String token = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwczpcL1wvYXBpaG9tZWNoZWYuYW50b3BvbGlzLnh5elwvYXBpXC9hZG1pblwvc2lnbi1pbiIsImlhdCI6MTY3MDgxNDUzMywiZXhwIjoxNjgzNzc0NTMzLCJuYmYiOjE2NzA4MTQ1MzMsImp0aSI6IkdCdlYzOHprODdydlB4TDAiLCJzdWIiOjEsInBydiI6IjIzYmQ1Yzg5NDlmNjAwYWRiMzllNzAxYzQwMDg3MmRiN2E1OTc2ZjcifQ.0L4IAjVSNGQ7QKyYqSG863G92DDZGtG5skZomLtFeGs";
//   List<OrderModel> alldata = [];
//   //List<User> userdata = [];
//   late OrderModel model;
//  // late User model2;
//
//   Future<List<OrderModel>> fetchData() async {
//     final response = await http.get(Uri.parse(link), headers: {
// "Accept":"application/json",
//       "Authorization":"Bearer $token"
//     });
//     var data = jsonDecode(response.body);
//     if (response.statusCode == 200) {
//       print(data);
//       for (var i in data) {
//         alldata.add(OrderModel.fromJson(i));
//       }
//       return alldata;
//     } else {
//       return alldata;
//     }
//   }

  // Future fetchData() async {
  //   try {
  //     var response = await http.get(Uri.parse(link), headers: {
  //       "Accept":"application/json",
  //      "Authorization":"Bearer $token"
  //     });
  //     print('Status Code is ${response.statusCode}');
  //     if (response.statusCode == 200) {
  //       final item = jsonDecode(response.body);
  //       for (var i in item["main"]) {
  //         model = Empty(
  //           id: i["id"],
  //           user: i["user"],
  //           price: i["price"],
  //           quantity: i["quantity"],
  //           orderDateAndTime: i["orderDateAndTime"],
  //         );
  //         setState(() {
  //           alldata.add(model);
  //         });
  //       }
  //       for (var j in item) {
  //         model2 = User(id: j["id"], name: j["name"]);
  //         setState(() {
  //           userdata.add(model2);
  //         });
  //       }
  //     } else {
  //       print('hoynai');
  //     }
  //   } catch (e) {
  //     print("probelm is: $e");
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    final orderList = Provider.of<OrderProvider>(context).orderList;

    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.deepPurple,
      appBar: AppBar(
        title: Text("Order"),
        centerTitle: true,
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              ListView.separated(
                  separatorBuilder: (_, index) => SizedBox(
                        height: 2,
                      ),
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: orderList.length,
                  itemBuilder: (context, index) {
                    var clr =
                        orderList[index].orderStatus!.orderStatusCategory!.id;
                    return Container(
                      padding: EdgeInsets.all(15),
                      margin: EdgeInsets.all(10),
                      height: 100,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.blueGrey),
                      child: Row(
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Icon(
                                clr == 1
                                    ? Icons.arrow_circle_right_outlined
                                    : clr == 2
                                        ? Icons.arrow_circle_right_outlined
                                        : Icons.arrow_circle_right_outlined,
                                color: clr == 1
                                    ? Colors.red
                                    : clr == 2
                                        ? Colors.yellow
                                        : Colors.green,
                                size: 40,
                              ),
                              Text(
                              "Id: ${orderList[index].id}",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 17,color: Colors.white),
                              ),
                            ],
                          ),SizedBox(width: 30,),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${orderList[index].user!.name}",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 17,color: Colors.white),
                              ),
                              Text("Price: ${orderList[index].price}",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 17,color: Colors.white),
                              ),
                            ],
                          ),
                          Spacer(),
                          Column(

                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                "Quantity:  ${orderList[index].quantity}",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 17,color: Colors.white),
                              ),
                              Text("${Jiffy(orderList[index].orderDateAndTime).format("do MMM yy")}",style: TextStyle(fontSize: 14,color: Colors.white)),
                              Text("${Jiffy(orderList[index].orderDateAndTime).format("h : mm aa")}",style: TextStyle(fontSize: 14,color: Colors.white))
                            ],
                          ),
                        ],
                      ),
                    );
                  })
            ],
          ),
        ),
      ),
    )
        // Scaffold(
        //   appBar: AppBar(
        //     backgroundColor: AppColor.kbgcolor,
        //     elevation: 0,
        //     title: Text(
        //       "Order",
        //       style: TextStyle(color: Colors.white, fontSize: 26),
        //     ),
        //     centerTitle: true,
        //   ),
        //   body: SingleChildScrollView(
        //     child: Column(
        //       children: [
        //         ListView.builder(
        //             shrinkWrap: true,
        //             itemCount: orderList.length,
        //             itemBuilder: (context, index) {
        //               var clr =
        //                   orderList[index].orderStatus!.orderStatusCategory!.id;
        //               return Padding(
        //                 padding:
        //                 EdgeInsets.only(top: 10, left: 10, right: 10),
        //                 child: Center(
        //                   child: Container(
        //                     padding: EdgeInsets.only(
        //                         top: 15, left: 15, right: 15, bottom: 15),
        //                     height: 100,
        //                     decoration: BoxDecoration(
        //                       borderRadius: BorderRadius.circular(15),
        //                       color: Colors.white,
        //                       boxShadow: [
        //                         BoxShadow(
        //                           color: Colors.black54,
        //                           offset: const Offset(
        //                             5.0,
        //                             5.0,
        //                           ), //Offset
        //                           blurRadius: 10.0,
        //                           spreadRadius: 2.0,
        //                         ), //BoxShadow
        //                         BoxShadow(
        //                           color: Colors.white,
        //                           offset: const Offset(0.0, 0.0),
        //                           blurRadius: 0.0,
        //                           spreadRadius: 0.0,
        //                         ), //BoxShadow
        //                       ],
        //                     ),
        //                     child: Column(
        //                       children: [
        //                         Row(
        //                           children: [
        //                             Expanded(
        //                                 flex: 2,
        //                                 child: Column(
        //                                   crossAxisAlignment:
        //                                   CrossAxisAlignment.start,
        //                                   children: [
        //                                     Icon(
        //                                       clr == 1
        //                                           ? Icons.snowmobile_sharp
        //                                           : clr == 2
        //                                           ? Icons.abc
        //                                           : Icons.zoom_in_map_sharp,
        //                                       color: clr == 1
        //                                           ? Colors.red
        //                                           : clr == 2
        //                                           ? Colors.green
        //                                           : Colors.blue,
        //                                     ),
        //                                     Text(
        //                                         "Order Id: " +
        //                                             orderList[index].id.toString(),
        //                                         style: myStyle(16, Colors.cyan,
        //                                             FontWeight.w700)),
        //                                   ],
        //                                 )),
        //                             Expanded(
        //                                 flex: 2,
        //                                 child: Column(
        //                                   crossAxisAlignment:
        //                                   CrossAxisAlignment.start,
        //                                   children: [
        //                                     Text(
        //                                         "Name:${orderList[index].user!.name} ",
        //                                         style: myStyle(14, Colors.teal,
        //                                             FontWeight.w700)),
        //                                     SizedBox(
        //                                       height: 25,
        //                                     ),
        //                                     Text("Price: ${orderList[index].price}",
        //                                         style: myStyle(
        //                                             16,
        //                                             AppColor.kbgcolor,
        //                                             FontWeight.w700)),
        //                                   ],
        //                                 )),
        //                           ],
        //                         ),
        //                       ],
        //                     ),
        //                   ),
        //                 ),
        //               );
        //             })
        //       ],
        //     ),
        //   ),
        // ),
        );
  }
}

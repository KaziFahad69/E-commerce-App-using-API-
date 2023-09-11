import 'dart:convert';

import 'package:day53/model/adminmodel.dart';
import 'package:day53/model/categorymodel.dart';
import 'package:day53/model/ordermodel.dart';
import 'package:day53/model/productmodel.dart';
import 'package:day53/widget/common_widget.dart';
import 'package:http/http.dart'as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';

// Rest of your code


class CustomeHttpRequest{


 static FutureOr<Map<String, String>> getHeaderWithToken() async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var header = {
      "Accept": "application/json",
      "Authorization": "bearer ${sharedPreferences.getString("token")}"
    };
    //print("saved token is: ${sharedPreferences.getString("token")}");
    return header;
  }

   static FutureOr<List<OrderModel>> fetchallorderData() async {
    List<OrderModel> orderList = [];
    OrderModel orderModel;
    String uriLink = "${baseUrl}all/orders";
    var response = await http.get(Uri.parse(uriLink),
    headers: await CustomeHttpRequest.getHeaderWithToken());
   // print ("data arrrrrr${response.body}");
    var data = jsonDecode(response.body);
    for(var i in data){
      orderModel = OrderModel.fromJson(i);
      orderList.add(orderModel);
    }
    return orderList;
  }

 static FutureOr<List<AdminProfile>> fetchadminProfileData() async {
   List<AdminProfile> adminprofileList = [];
   AdminProfile adminProfile;
   String uriLink = "${baseUrl}profile";
   var response = await http.get(Uri.parse(uriLink),
       headers: await CustomeHttpRequest.getHeaderWithToken());
    print ("data arrrrrr${response.body}");
   var data = jsonDecode(response.body);
   for(var i in data){
     adminProfile = AdminProfile.fromJson(i);
     adminprofileList.add(adminProfile);
   }
   return adminprofileList;
 }



  static FutureOr<List<CategoryModel>> featchallcategory() async {
    List<CategoryModel> categoryList = [];
    CategoryModel categoryModel;
    String uriLink = "${baseUrl}category";
    var response = await http.get(Uri.parse(uriLink),
        headers: await CustomeHttpRequest.getHeaderWithToken());
    //print ("data ar${response.body}");
    var data = jsonDecode(response.body);
    for(var i in data){
      categoryModel = CategoryModel.fromJson(i);
      categoryList.add(categoryModel);
    }
    return categoryList;

  }

  static FutureOr<List<ProductModel>> featchproduct() async {
    List<ProductModel> productList = [];
    ProductModel productModel;
    String uriLink = "${baseUrl}products";
    var response = await http.get(Uri.parse(uriLink),
        headers: await CustomeHttpRequest.getHeaderWithToken());
    //print ("data arrrrrr${response.body}");
    var data = jsonDecode(response.body);
    for(var i in data){
      productModel = ProductModel.fromJson(i);
      productList.add(productModel);
    }
    return productList;

  }

  static FutureOr<List<Price>> featchprice() async {
    List<Price> priceList = [];
    Price price;
    String uriLink = "${baseUrl}products";
    var response = await http.get(Uri.parse(uriLink),
        headers: await CustomeHttpRequest.getHeaderWithToken());
    print ("data op${response.body}");
    var data = jsonDecode(response.body);
    for(var i in data){
      price = Price.fromJson(i);
      priceList.add(price);
    }
    return priceList;

  }
 FutureOr<dynamic> deleteProduct({required int id}) async {
   String link = "${baseUrl}product/$id/delete";
   var responce =
   await http.delete(Uri.parse(link), headers: await getHeaderWithToken());
   var data = jsonDecode(responce.body);
   return data;
 }
 //category delete thik korte hobe
 FutureOr<dynamic> delectcategory({required int id}) async {
   String link = "${baseUrl}category/$id/delete";
   var responce =
   await http.delete(Uri.parse(link), headers: await getHeaderWithToken());
   var data = jsonDecode(responce.body);
   return data;
 }
}



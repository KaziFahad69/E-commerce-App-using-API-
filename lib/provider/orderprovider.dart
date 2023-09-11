import 'package:day53/model/ordermodel.dart';
import 'package:day53/widget/customhttp.dart';
import 'package:flutter/cupertino.dart';



class OrderProvider with ChangeNotifier{
  List<OrderModel> orderList = [];
  getOrderData() async{
    orderList = await CustomeHttpRequest.fetchallorderData();
    notifyListeners();
  }


}
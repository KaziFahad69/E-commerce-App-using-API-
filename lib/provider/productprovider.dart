import 'package:day53/model/productmodel.dart';
import 'package:day53/widget/customhttp.dart';
import 'package:flutter/cupertino.dart';

class ProductProvider with ChangeNotifier{
  List<ProductModel> productList = [];
  getProductData() async{
    productList = await CustomeHttpRequest.featchproduct();
    notifyListeners();
  }
  deleteProductItem( int index){
  productList.removeAt(index);
  notifyListeners();

}
// class PriceProvider with ChangeNotifier{
//   List<Price> priceList = [];
//   getPriceData() async{
//     priceList = await CustomeHttpRequest.featchprice();
//     notifyListeners();
//   }
// }

}
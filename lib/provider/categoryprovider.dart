import 'package:day53/model/categorymodel.dart';
import 'package:day53/widget/customhttp.dart';
import 'package:flutter/cupertino.dart';

class CategoryProvider with ChangeNotifier{
  List<CategoryModel> categoryList = [];
  getCategoryData() async{
    categoryList = await CustomeHttpRequest.featchallcategory();
    notifyListeners();
  }
  //category delete in complete
  deleteCategoryItem( int index){
    categoryList.removeAt(index);
    notifyListeners();

  }

}
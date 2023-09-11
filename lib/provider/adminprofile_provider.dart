

import 'package:day53/model/adminmodel.dart';
import 'package:day53/widget/customhttp.dart';
import 'package:flutter/cupertino.dart';

class AdminProvider with ChangeNotifier{
  List<AdminProfile> adminprofileList = [];
  getAdminProfileData() async{
    adminprofileList = await CustomeHttpRequest.fetchadminProfileData();
    notifyListeners();
  }


}
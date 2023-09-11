import 'package:day53/model/adminmodel.dart';
import 'package:day53/provider/adminprofile_provider.dart';
import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';
import 'package:provider/provider.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}


class _ProfileState extends State<Profile> {
  @override
  void initState() {
    // TODO: implement initState
    Provider.of<AdminProvider>(context, listen: false).getAdminProfileData();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final adminprofileList = Provider.of<AdminProvider>(context).adminprofileList;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.green,
        body:
        Container(
          child: SingleChildScrollView(
            child: Column(
              children: [
                ListView.separated(
                    separatorBuilder: (_, index) => SizedBox(
                      height: 2,
                    ),
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: adminprofileList.length,
                    itemBuilder: (context, index) {
                      // var clr =
                      //     adminprofile[index].orderStatus!.orderStatusCategory!.id;
                      return Container(
                        padding: EdgeInsets.all(15),
                        margin: EdgeInsets.all(10),
                        height: 100,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.blueGrey),
                        child: Row(
                          children: [
                            Text(
                              "Id: ${adminprofileList[0].name}",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 17,color: Colors.white),
                            ),
                              ],
                        ),
                      );
                    })
              ],
            ),
          ),
        ),

      ),
    );
  }
}

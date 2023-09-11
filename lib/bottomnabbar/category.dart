import 'package:day53/model/ordermodel.dart';
import 'package:day53/page/add_category_page.dart';
import 'package:day53/page/editcategory_page.dart';
import 'package:day53/provider/categoryprovider.dart';
import 'package:day53/provider/orderprovider.dart';
import 'package:day53/widget/common_widget.dart';
import 'package:day53/widget/customhttp.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart'as http;

class Category extends StatefulWidget {
  const Category({Key? key}) : super(key: key);

  @override
  State<Category> createState() => _CategoryState();
}


class _CategoryState extends State<Category> {

  void initState() {
    // TODO: implement initState
    Provider.of<CategoryProvider>(context, listen: false).getCategoryData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool isLoading = false;
    final categoryList = Provider.of<CategoryProvider>(context).categoryList;
    //print("bla bla bla: ${categoryList}");
    return ModalProgressHUD(
      inAsyncCall: isLoading == true,
      opacity: .5,
      blur: .5,
      child: SafeArea(
        child: Scaffold(
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => AddCategory()))
                    .then((value) =>
                    Provider.of<CategoryProvider>(context, listen: false)
                        .getCategoryData());
              },
              child: Icon(Icons.add),
            ),
          backgroundColor: Colors.deepPurple,
          appBar: AppBar(
            title: Text("Category"),
            centerTitle: true,
          ),
          body:categoryList.isEmpty?spinkit:
         Container(


           margin: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
           child: GridView.builder(


               gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                 childAspectRatio: .71,
                   mainAxisSpacing: 10,
                   crossAxisSpacing: 10,
                   crossAxisCount: 2),
               itemCount: categoryList.length,
               shrinkWrap: true,

               itemBuilder: (context,index){
             return Stack(
               children: [
                 Container(
                   padding: EdgeInsets.symmetric(horizontal: 3),
                   decoration: BoxDecoration(
                     borderRadius: BorderRadius.circular(20),
                       border: Border.all(color: Colors.yellow,width: 3)
                   ),
                   child: Column(
                     children: [
                       Container(
                         margin: EdgeInsets.only(top: 5),
                         height: 150,
                         decoration: BoxDecoration(
                             image: DecorationImage(image: NetworkImage("${imageUrl}${categoryList[index].image}",),fit: BoxFit.cover),
                           borderRadius: BorderRadius.circular(10),
                          // border: Border.all(color: Colors.black,width: 2)
                         ),

                       ),
                       SizedBox(height: 15,),
                       Text("${categoryList[index].name}",style: TextStyle(fontWeight: FontWeight.w700,fontSize: 17,color: Colors.white),),

                       Card(
                         color: Colors.pink.withOpacity(.8),

                         shape:
                         RoundedRectangleBorder(

                           side: BorderSide(
                   color: Colors.black,
                             width: 3
                   ),
                           borderRadius: BorderRadius.all(Radius.circular(15)),
                         ),


                         elevation: 15,
                         shadowColor: Colors.pink,
                         child: Row(
                           mainAxisAlignment:
                           MainAxisAlignment.spaceBetween,
                           children: [
                             IconButton(
                                 onPressed: () {
                                   Navigator.of(context)
                                       .push(MaterialPageRoute(
                                       builder: (context) =>
                                           EditCategory(
                                               categoryModel:
                                               categoryList[
                                               index])))
                                       .then((value) =>
                                       Provider.of<CategoryProvider>(
                                           context,
                                           listen: false)
                                           .getCategoryData());
                                 },
                                 icon: Icon(Icons.edit)),
                             IconButton(
                                 onPressed: () async {
                                   setState(() {
                                     isLoading = true;
                                   });
                                   dynamic result =
                                   await CustomeHttpRequest()
                                       .delectcategory(
                                       id: categoryList[index]
                                           .id!
                                           .toInt());
                                   setState(() {
                                     isLoading = false;
                                   });
                                   if (result["error"] != null) {
                                     showInToast("${result["error"]}");
                                   } else {
                                     showInToast("${result["message"]}");
                                     setState(() {
                                       categoryList.removeAt(index);
                                     });

                                     Provider.of<CategoryProvider>(context, listen: false).deleteCategoryItem(index);
                                   }

                                   print(
                                       "our result isssssssssssssssss ${result["error"]}");
                                 },
                                 icon: Icon(Icons.delete)),
                           ],
                         ),
                       ),

                     ],
                   ),
                 ),
                 Positioned(
                     right: 10,
                     bottom: MediaQuery.of(context).size.height*.11,
                     child: Container(
                       padding: EdgeInsets.all(5),
                       height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                          color: Colors.amber,
                          shape: BoxShape.circle
                        ),
                         child:Container(

                             decoration: BoxDecoration(
                               shape: BoxShape.circle,
                 image: DecorationImage(image: NetworkImage("${imageUrl}${categoryList[index].icon}"),fit: BoxFit.cover))
                 ),

                         ))
               ],
             );
               }),
         )
        ),
      ),
    );
  }
}

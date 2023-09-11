import 'dart:io';


import 'package:day53/design/custom_textstyle.dart';
import 'package:day53/login.dart';
import 'package:day53/model/categorymodel.dart';

import 'package:day53/widget/common_widget.dart';
import 'package:day53/widget/customhttp.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

// Rest of your code


// ignore: must_be_immutable
class EditCategory extends StatefulWidget {
  CategoryModel? categoryModel;
  EditCategory({Key? key, required this.categoryModel}) : super(key: key);

  @override
  State<EditCategory> createState() => _EditCategoryState();
}

class _EditCategoryState extends State<EditCategory> {
  bool isLoading = false;
  TextEditingController? nameController;
  // TextEditingController? orginalPriceController;
  // TextEditingController? discountPriceController;
  // TextEditingController? discountTypeController;
  // TextEditingController? quantityController;
  @override
  void initState() {
    // TODO: implement initState
    nameController = TextEditingController(text: widget.categoryModel!.name);
    // orginalPriceController = TextEditingController(
    //     text: widget.productModel!.price![0].originalPrice.toString());
    // discountPriceController = TextEditingController(
    //     text: widget.productModel!.price![0].discountedPrice.toString());
    // quantityController = TextEditingController(
    //     text: widget.productModel!.stockItems![0].quantity.toString());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final weidth = MediaQuery.of(context).size.width;
    return SafeArea(
      child: ModalProgressHUD(
        inAsyncCall: isLoading == true,
        opacity: 0.5,
        blur: 0.5,
        child: Scaffold(
          body: Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Text("Edit Category",style: myStyle(30, Colors.black,FontWeight.bold),),
                    SizedBox(height: 20,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Choose Image here: ",style: myStyle(18, Colors.black),),
                        Stack(
                          //overflow: Overflow.visible,
                          children: [
                            Container(
                              height: 150,
                              width: 200,
                              decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.05),
                                borderRadius: BorderRadius.all(Radius.circular(5)),
                              ),
                              child: image == null
                                  ? InkWell(
                                  onTap: () {
                                    // getImageformGallery();
                                  },
                                  child: Image.network(
                                      "${imageUrl}${widget.categoryModel!.image}"))
                                  : Container(
                                height: 150,
                                width: 200,
                                child: Image.file(image!),
                              ),
                            ),
                            Positioned(
                              bottom: 0,
                              left: weidth * 0.35,
                              child: TextButton(
                                onPressed: () {
                                  getImageformGallery();
                                },
                                child: Container(
                                  height: 40,
                                  width: 40,
                                  decoration: BoxDecoration(
                                      borderRadius:
                                      BorderRadius.all(Radius.circular(50)),
                                      color: Colors.black,
                                      border: Border.all(
                                          color: Colors.black, width: 1.5)),
                                  child: Center(
                                    child: Container(
                                      height: 20,
                                      width: 20,
                                      child: Icon(Icons.edit),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 20,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                      Text("Choose Icon here: ",style: myStyle(20, Colors.black),),
                        Stack(
                          //overflow: Overflow.visible,
                          children: [
                            Container(
                              height: 150,
                              width: 200,
                              decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.05),
                                borderRadius: BorderRadius.all(Radius.circular(5)),
                              ),
                              child: image2 == null
                                  ? InkWell(
                                  onTap: () {
                                    // getImageformGallery();
                                  },
                                  child: Image.network(
                                      "${imageUrl}${widget.categoryModel!.icon}"))
                                  : Container(
                                height: 150,
                                width: 200,
                                child: Image.file(image2!),
                              ),
                            ),
                            Positioned(
                              bottom: 0,
                              left: weidth * 0.35,
                              child: TextButton(
                                onPressed: () {
                                  getsecondImageformGallery();
                                },
                                child: Container(
                                  height: 40,
                                  width: 40,
                                  decoration: BoxDecoration(
                                      borderRadius:
                                      BorderRadius.all(Radius.circular(50)),
                                      color: Colors.black,
                                      border: Border.all(
                                          color: Colors.black, width: 1.5)),
                                  child: Center(
                                    child: Container(
                                      height: 20,
                                      width: 20,
                                      child: Icon(Icons.edit),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 40,),
                    CustomeTextFieldd(
                      Controller: nameController!,
                      leveltext: "Enter product Name",
                      icon: Icons.abc,
                    ),
                    SizedBox(height: 20,),
                    // CustomeTextFieldd(
                    //   Controller: orginalPriceController!,
                    //   leveltext: "Enter product Price",
                    //   icon: Icons.price_change,
                    // ),
                    // CustomeTextFieldd(
                    //   Controller: discountPriceController!,
                    //   leveltext: "Enter Discount Price",
                    //   icon: Icons.abc,
                    // ),
                    // CustomeTextFieldd(
                    //   Controller: quantityController!,
                    //   leveltext: "Enter Quantity",
                    //   icon: Icons.abc,
                    // ),

                    TextButton(
                      onPressed: () {
                        updateCategory();
                      },

                      child:

                      Container(
                        alignment: Alignment.center,
                        width: MediaQuery.of(context).size.width*.7,
                        height: 50,
                        decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: Colors.black,width: 3)
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                        child: const Text(
                          'Update Category',
                          style: TextStyle(color: Colors.white, fontSize: 20.0),
                        ),
                      ),
                    ),
                  ],
                ),
              )),
        ),

      ),
    );
  }

  updateCategory() async {
    try {
      if (mounted) {
        setState(() {
          isLoading = true;
        });
        String uriLink = "${baseUrl}category/${widget.categoryModel!.id}/update";
        var request = http.MultipartRequest("POST", Uri.parse(uriLink));
        request.headers.addAll(await CustomeHttpRequest.getHeaderWithToken());
        request.fields["name"] = nameController!.text.toString();
        // request.fields["category_id"] =
        //     widget.categoryModel!.foodItemCategory![0].id.toString();
        // request.fields["quantity"] = quantityController!.text.toString();
        // request.fields["original_price"] =
        //     orginalPriceController!.text.toString();
        // request.fields["discounted_price"] =
        //     discountPriceController!.text.toString();
        // request.fields["discount_type"] = "fixed";
        if (image != null) {
          var photo = await http.MultipartFile.fromPath("image", image!.path);
          request.files.add(photo);
        }if (image2 != null) {
          var photo2 = await http.MultipartFile.fromPath("icon", image2!.path);
          request.files.add(photo2);
        }
        var responce = await request.send();
        setState(() {
          isLoading = false;
        });
        var responceData = await responce.stream.toBytes();
        var responceString = String.fromCharCodes(responceData);
        print("responce bodyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyy ${responceString}");
        print(
            "Status code issss${responce.statusCode} ${request.fields} ${request.files.toString()}");
        if (responce.statusCode == 200) {
          showInToast("Product Uploaded Succesfully");
          Navigator.of(context).pop();
        } else {
          showInToast("Something wrong, try again plz bro");
        }
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      print(e);
      showInToast("Something wrong");
    }
  }

  File? image;
  File? image2;
  final picker = ImagePicker();

  FutureOr getImageformGallery() async {
    print('on the way of gallery');
    final pickedImage = await picker.pickImage(source: ImageSource.camera);
    setState(() {
      if (pickedImage != null) {
        image = File(pickedImage.path);
        print('image found');
        print('${image!.path}');
      } else {
        print('no image found');
      }
    });
  }
  FutureOr getsecondImageformGallery() async {
    print('on the way of iicon');
    final pickedImage2 = await picker.pickImage(source: ImageSource.camera);
    setState(() {
      if (pickedImage2 != null) {
        image2 = File(pickedImage2.path);
        print('image found');
        print('${image2!.path}');
      } else {
        print('no image found');
      }
    });
  }
}

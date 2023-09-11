import 'dart:io';

import 'package:day53/design/custom_textstyle.dart';
import 'package:day53/login.dart';
import 'package:day53/model/categorymodel.dart';
import 'package:day53/provider/categoryprovider.dart';
import 'package:day53/widget/common_widget.dart';
import 'package:day53/widget/customhttp.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'dart:async';


// Rest of your code

class AddProduct extends StatefulWidget {
  const AddProduct({Key? key}) : super(key: key);

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  String? categoryType;
  TextEditingController nameController = TextEditingController();
  TextEditingController orginalPriceController = TextEditingController();
  TextEditingController discountPriceController = TextEditingController();
  TextEditingController discountTypeController = TextEditingController();
  TextEditingController quantityController = TextEditingController();
  @override
  void initState() {
    Provider.of<CategoryProvider>(context, listen: false).getCategoryData();
    super.initState();
  }
  bool isLoading = true;
  uploadProduct() async {
    if (mounted) {
      setState(() {
        isLoading = true;
      });
      String uriLink = "${baseUrl}product/store";
      var request = http.MultipartRequest("POST", Uri.parse(uriLink));
      request.headers.addAll(await CustomeHttpRequest.getHeaderWithToken());
      request.fields["name"] = nameController.text.toString();
      request.fields["category_id"] = categoryType.toString();
      request.fields["quantity"] = quantityController.text.toString();
      request.fields["original_price"] = orginalPriceController.text.toString();
      request.fields["discounted_price"] =
          discountPriceController.text.toString();
      request.fields["discount_type"] = "fixed";
      var photo = await http.MultipartFile.fromPath("image",image!.path);
      request.files.add(photo);
      var responce = await request.send();
      var responceData = await responce.stream.toBytes();
      var responceString = String.fromCharCodes(responceData);
      print("responce bodyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyy ${responceString}");
      print(
          "Status code issss${responce.statusCode} ${request.fields} ${request.files.toString()}");
      if (responce.statusCode == 201) {
        showInToast("Product Uploaded Succesfully");

        Navigator.of(context).pop();
      } else {
        showInToast("Something wrong, try again plz bro");
      }
    }
  }
  List<CategoryModel> categoryList = [];
  @override
  Widget build(BuildContext context) {
    categoryList = Provider.of<CategoryProvider>(context).categoryList;
    final height = MediaQuery.of(context).size.height;
    final weidth = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        body: Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Text("Add New Product",style: myStyle(25, Colors.black,FontWeight.w700),),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    margin: EdgeInsets.symmetric(horizontal: 0, vertical: 10),
                    decoration: BoxDecoration(
                        color: Colors.blueGrey,
                        border: Border.all(color: Colors.grey, width: 0.2),
                        borderRadius: BorderRadius.circular(10.0)),
                    height: 60,
                    child: Center(
                      child: DropdownButtonFormField<String>(
                        isExpanded: true,
                        icon: Icon(
                          Icons.keyboard_arrow_down,
                          size: 30,
                        ),
                        decoration: InputDecoration.collapsed(hintText: ''),
                        value: categoryType,
                        hint: Text(
                          'Select Category',
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(color: Colors.black, fontSize: 16),
                        ),
                        onChanged: (String? newValue) {
                          setState(() {
                            categoryType = newValue;
                            print("my Category is $categoryType");

                            // print();
                          });
                        },
                        validator: (value) =>
                        value == null ? 'field required' : null,
                        items: categoryList.map((item) {
                          return   DropdownMenuItem(
                            child:   Text(
                              "${item.name}",
                              style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                            value: item.id.toString(),
                          );
                        }).toList() ??
                            [],
                      ),
                    ),
                  ),
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
                            getImageformGallery();
                          },
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.image,
                                  color: Colors.blueGrey,
                                  size: 40,
                                ),
                                Text(
                                  "Select",
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                      color:
                                      Colors.blueGrey.withOpacity(0.5)),
                                ),
                              ],
                            ),
                          ),
                        )
                            : Container(
                          height: 150,
                          width: 200,
                          child: Image.file(image!),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        left: weidth * 0.4,
                        child: Visibility(
                          visible: isImageVisiable,
                          child: MaterialButton(
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
                      ),
                    ],
                  ),
                  Sizedbox(height:20),
                  CustomeTextFieldd(Controller: nameController,
                  leveltext: "Enter Name",
                    icon: Icons.abc,
                    hintText:" Enter Your Name",
                  ),
Sizedbox(height:10),
                  CustomeTextFieldd(
                    Controller: orginalPriceController,
                    leveltext: "Enter product Price",
                    icon: Icons.price_change,
                  ),
                  Sizedbox(height:10),
                  CustomeTextFieldd(
                    Controller: discountPriceController,
                    leveltext: "Enter Discount Price",
                    icon: Icons.abc,
                  ),
                  Sizedbox(height:10),
                  CustomeTextFieldd(
                    Controller: quantityController,
                    leveltext: "Enter Quantity",
                    icon: Icons.abc,
                  ),
SizedBox(height: 40,),
                  TextButton(
                    onPressed: () {
                      uploadProduct();
                    },
                    child: Container(
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
                        'ADD',
                        style: TextStyle(color: Colors.white, fontSize: 13.0),
                      ),
                    ),
                  ),
                ],
              ),
            )),
      ),
    );
  }

  File? image;
  final picker = ImagePicker();
  bool isImageVisiable = false;

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
}

class Sizedbox extends StatelessWidget {
Sizedbox({this.height});
double ? height;

  @override
  Widget build(BuildContext context) {
    return     SizedBox(height: height ,);
  }
}

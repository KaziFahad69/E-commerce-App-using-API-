import 'dart:io';


import 'package:day53/design/custom_textstyle.dart';
import 'package:day53/login.dart';
import 'package:day53/model/productmodel.dart';
import 'package:day53/widget/common_widget.dart';
import 'package:day53/widget/customhttp.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

// Rest of your code


class EditProduct extends StatefulWidget {
  ProductModel? productModel;
  EditProduct({Key? key, required this.productModel}) : super(key: key);

  @override
  State<EditProduct> createState() => _EditProductState();
}

class _EditProductState extends State<EditProduct> {
  bool isLoading = false;
  TextEditingController? nameController;
  TextEditingController? orginalPriceController;
  TextEditingController? discountPriceController;
  TextEditingController? discountTypeController;
  TextEditingController? quantityController;
  @override
  void initState() {
    // TODO: implement initState
    nameController = TextEditingController(text: widget.productModel!.name);
    orginalPriceController = TextEditingController(
        text: widget.productModel!.price![0].originalPrice.toString());
    discountPriceController = TextEditingController(
        text: widget.productModel!.price![0].discountedPrice.toString());
    quantityController = TextEditingController(
        text: widget.productModel!.stockItems![0].quantity.toString());
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
                    Text("Edit Product",style: myStyle(30, Colors.black,FontWeight.bold),),
                    SizedBox(height: 20,),
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
                                      "${imageUrl}${widget.productModel!.image}"))
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
                    SizedBox(height: 20,),
                    CustomeTextFieldd(
                      Controller: nameController!,
                      leveltext: "Enter product Name",
                      icon: Icons.abc,
                    ),
                    SizedBox(height: 20,),
                    CustomeTextFieldd(
                      Controller: orginalPriceController!,
                      leveltext: "Enter product Price",
                      icon: Icons.price_change,
                    ),
                    SizedBox(height: 20,),
                    CustomeTextFieldd(
                      Controller: discountPriceController!,
                      leveltext: "Enter Discount Price",
                      icon: Icons.abc,
                    ),
                    SizedBox(height: 20,),
                    CustomeTextFieldd(
                      Controller: quantityController!,
                      leveltext: "Enter Quantity",
                      icon: Icons.abc,
                    ),
SizedBox(height: 20,),
                    TextButton(
                      onPressed: () {
                        updateProduct();
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
                          'Update Pcroduct',
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

  updateProduct() async {
    try {
      if (mounted) {
        setState(() {
          isLoading = true;
        });
        String uriLink = "${baseUrl}product/${widget.productModel!.id}/update";
        var request = http.MultipartRequest("POST", Uri.parse(uriLink));
        request.headers.addAll(await CustomeHttpRequest.getHeaderWithToken());
        request.fields["name"] = nameController!.text.toString();
        request.fields["category_id"] =
            widget.productModel!.foodItemCategory![0].id.toString();
        request.fields["quantity"] = quantityController!.text.toString();
        request.fields["original_price"] =
            orginalPriceController!.text.toString();
        request.fields["discounted_price"] =
            discountPriceController!.text.toString();
        request.fields["discount_type"] = "fixed";
        if (image != null) {
          var photo = await http.MultipartFile.fromPath("image", image!.path);
          request.files.add(photo);
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
}

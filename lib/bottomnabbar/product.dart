import 'package:day53/page/add_product_page.dart';
import 'package:day53/page/edit_product.dart';
import 'package:day53/provider/productprovider.dart';
import 'package:day53/widget/common_widget.dart';
import 'package:day53/widget/customhttp.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';

class Product extends StatefulWidget {
  const Product({Key? key}) : super(key: key);

  @override
  State<Product> createState() => _ProductState();
}

class _ProductState extends State<Product> {
  @override
  void initState() {
    // TODO: implement initState
    Provider.of<ProductProvider>(context, listen: false).getProductData();
   // Provider.of<PriceProvider>(context, listen: false).getPriceData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool isLoading = false;
    final productList = Provider.of<ProductProvider>(context).productList;
  //  final priceList = Provider.of<PriceProvider>(context).priceList;
    return ModalProgressHUD(
      inAsyncCall: isLoading==true,
      opacity: .5,
      blur: .5,
      child:

      SafeArea(
        child: Scaffold(
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => AddProduct()))
                    .then((value) =>
                        Provider.of<ProductProvider>(context, listen: false)
                            .getProductData());
              },
              child: Icon(Icons.add),
            ),
            backgroundColor: Colors.deepPurple,
            appBar: AppBar(
              title: Text("Product"),
              centerTitle: true,
            ),
            body: productList.isEmpty
                ? spinkit
                : Container(
                    margin: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                    child: GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            childAspectRatio: .58,
                            mainAxisSpacing: 5,
                            crossAxisSpacing: 20,
                            crossAxisCount: 2),
                        itemCount: productList.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return Container(
                            margin: EdgeInsets.only(top: 15),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: Colors.green, width: 4)),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Container(
                                  margin: EdgeInsets.only(top: 15),
                                  height: 180,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: NetworkImage(
                                          "${imageUrl}${productList[index].image}",
                                        ),
                                        fit: BoxFit.cover),
                                    borderRadius: BorderRadius.circular(10),
                                    //border: Border.all(color: Colors.black,width: 2)
                                  ),
                                ),
                                Text(
                                  "${productList[index].name}",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 17,
                                      color: Colors.white),
                                ),
                                Text(
                                  "Price: ${productList[index].price![0].originalPrice}",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 17,
                                      color: Colors.white),
                                ),
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
                                                        EditProduct(
                                                            productModel:
                                                                productList[
                                                                    index])))
                                                .then((value) =>
                                                    Provider.of<ProductProvider>(
                                                            context,
                                                            listen: false)
                                                        .getProductData());
                                          },
                                          icon: Icon(Icons.edit)),
                                      IconButton(
                                          onPressed: () async {
                                            setState(() {
                                              isLoading = true;
                                            });
                                            dynamic result =
                                                await CustomeHttpRequest()
                                                    .deleteProduct(
                                                        id: productList[index]
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
                                                productList.removeAt(index);
                                              });

                                              Provider.of<ProductProvider>(context, listen: false).deleteProductItem(index);
                                            }

                                            print(
                                                "our result isssssssssssssssss ${result["error"]}");
                                          },
                                          icon: Icon(Icons.delete)),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          );
                        }),
                  )),
      ),
    );
  }
}

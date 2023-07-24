import 'package:e_commerce_firebase/e_commerce/view/add_product_screen/model/product_model.dart';
import 'package:e_commerce_firebase/e_commerce/view/helper_class/firebase_helper.dart';
import 'package:e_commerce_firebase/e_commerce/view/helper_class/notification_helper.dart';
import 'package:e_commerce_firebase/e_commerce/view/home_screen/view/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:sizer/sizer.dart';

class AddProduct extends StatefulWidget {
  const AddProduct({Key? key}) : super(key: key);

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  TextEditingController txtname = TextEditingController();
  TextEditingController txtprice = TextEditingController();
  TextEditingController txtdesc = TextEditingController();
  TextEditingController txtcategory = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "Shopify",
            style: TextStyle(fontSize: 22, color: Colors.black),
          ),
          actions: [
            IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.search,
                size: 25,
              ),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(10),
          child: SingleChildScrollView(
            child: Column(
              children: [
                //name
                SizedBox(
                  height: 2.h,
                ),
                buildTextFormField("Name", txtname,1),
                //image
                SizedBox(height: 2.h,),
                Container(
                  height: 25.h,
                  width: 100.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(color: Colors.deepOrange),
                  ),
                  alignment: Alignment.center,
                  child: Text("Add Image"),
                ),
                //price
                SizedBox(
                  height: 2.h,
                ),
                buildTextFormField("Price", txtprice,1),
                //desc
                SizedBox(
                  height: 2.h,
                ),
                buildTextFormField("Description", txtdesc,4),
                //category
                SizedBox(
                  height: 2.h,
                ),
                buildTextFormField("Category", txtcategory,1),
              ],
            ),
          ),
        ),
        bottomNavigationBar:
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          InkWell(
            onTap: () {
              FirebaseHelper.firebaseHelper.insertData(ProductModel(
                name: txtname.text,
                img: "https://luxurysales.in/cdn/shop/products/2020_06_17_11_51_IMG_3662_grande.jpg",
                price: txtprice.text,
                desc: txtdesc.text,
                cate: txtcategory.text,
              ));
              Get.back();
              NotificationHelper.helper.showSimpleNotification();
            },
            child: Container(
              height: 6.h,
              width: 35.w,
              margin: EdgeInsets.all(15),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.deepOrange,
                boxShadow: [BoxShadow(color: Colors.deepOrange, blurRadius: 5)],
              ),
              alignment: Alignment.center,
              child: Text(
                "Add Product",
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
          ),
        ]),
      ),
    );
  }

  TextFormField buildTextFormField(name, c1,max) {
    return TextFormField(
      controller: c1,
      maxLines: max,
      decoration: InputDecoration(
        border: InputBorder.none,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.deepOrange),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.deepOrange, width: 2),
        ),
        label: Text("Product $name"),
        hintText: "Product $name",
      ),
    );
  }
}

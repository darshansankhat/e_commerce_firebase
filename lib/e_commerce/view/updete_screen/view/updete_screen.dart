import 'package:e_commerce_firebase/e_commerce/view/add_product_screen/model/product_model.dart';
import 'package:e_commerce_firebase/e_commerce/view/helper_class/firebase_helper.dart';
import 'package:e_commerce_firebase/e_commerce/view/home_screen/view/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:sizer/sizer.dart';

class UpdeteProduct extends StatefulWidget {
  const UpdeteProduct({Key? key}) : super(key: key);

  @override
  State<UpdeteProduct> createState() => _UpdeteProductState();
}

class _UpdeteProductState extends State<UpdeteProduct> {
  TextEditingController txtname = TextEditingController();
  TextEditingController txtimage = TextEditingController();
  TextEditingController txtprice = TextEditingController();
  TextEditingController txtdesc = TextEditingController();
  TextEditingController txtcategory = TextEditingController();
  String? image;
  String? id = "";

  @override
  void initState() {
    super.initState();
    ProductModel model = Get.arguments;

    txtname = TextEditingController(text: "${model.name}");
     txtprice = TextEditingController(text: "${model.price}");
     txtdesc = TextEditingController(text: "${model.desc}");
    txtcategory = TextEditingController(text: "${model.cate}");
    image=model.img;
    id = model.id;
  }

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
                  child: Image.network(image!),
                ),
                //image
                SizedBox(height: 2.h,),
                buildTextFormField("Add Image", txtimage, 1),
                //price
                SizedBox(
                  height: 2.h,
                ),
                buildTextFormField("Price", txtprice,1),
                //category
                SizedBox(
                  height: 2.h,
                ),
                buildTextFormField("Category", txtcategory,1),
                //desc
                SizedBox(
                  height: 2.h,
                ),
                buildTextFormField("Description", txtdesc,4),
              ],
            ),
          ),
        ),
        bottomNavigationBar:
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          InkWell(
            onTap: () {
             ProductModel model= ProductModel(
                name: txtname.text,
                img: txtimage.text,
                price: txtprice.text,
                desc: txtdesc.text,
                cate: txtcategory.text,
                id: id,
              );
              FirebaseHelper.firebaseHelper.updateData(model);
              Get.back();
            },
            child: Container(
              height: 6.h,
              width: 40.w,
              margin: EdgeInsets.all(15),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.deepOrange,
                boxShadow: [BoxShadow(color: Colors.deepOrange, blurRadius: 5)],
              ),
              alignment: Alignment.center,
              child: Text(
                "Update Product",
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

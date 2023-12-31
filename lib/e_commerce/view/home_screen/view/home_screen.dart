import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_firebase/e_commerce/view/add_product_screen/model/product_model.dart';
import 'package:e_commerce_firebase/e_commerce/view/helper_class/firebase_helper.dart';
import 'package:e_commerce_firebase/e_commerce/view/helper_class/notification_helper.dart';
import 'package:e_commerce_firebase/e_commerce/view/home_screen/controller/HomeController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:sizer/sizer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeController controller = Get.put(HomeController());

  @override
  void initState() {
    super.initState();
    controller.userDetails = FirebaseHelper.firebaseHelper.userDetails();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            "Shopify",
            style: TextStyle(fontSize: 22, color: Colors.black),
          ),
          actions: [
            IconButton(
              onPressed: () {
                NotificationHelper.helper.bigPictureNotification();
              },
              icon: const Icon(
                Icons.search,
                size: 25,
              ),
            ),
          ],
        ),
        body: StreamBuilder(
          stream: FirebaseHelper.firebaseHelper.selectData(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text("${snapshot.error}");
            } else if (snapshot.hasData) {
              QuerySnapshot<Map<String, dynamic>>? qs = snapshot.data;
              // List<QueryDocumentSnapshot> qsList = qs!.docs;
              List<ProductModel> productList = [];

              for (var x in snapshot.data!.docs) {
                // Map m1 = x.data() as Map;
                // String? id = x.id;
                // String? name = m1['name'];
                // String? image = m1['image'];
                // String? price = m1['price'];
                // String? desc = m1['description'];
                // String? cate = m1['category'];

                ProductModel model = ProductModel(
                  name: x['name'],
                  img: x['image'],
                  price: x['price'],
                  desc: x['description'],
                  cate: x['category'],
                  id: x.id,
                );

                productList.add(model);
              }

              return ListView.builder(
                itemCount: productList.length,
                itemBuilder: (context, index) {
                  print(productList[index].id);
                  return GestureDetector(
                    onDoubleTap: () {
                      Get.toNamed('update', arguments: productList[index]);
                    },
                    child: Container(
                      width: 100.w,
                      color: Colors.white,
                      child: Padding(
                        padding: EdgeInsets.all(10.sp),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Image.network(
                                  "${productList[index].img}",
                                  height: 100,
                                  width: 100,
                                ),
                                SizedBox(
                                  width: 15.sp,
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${productList[index].name}",
                                      style: const TextStyle(
                                          fontSize: 20, color: Colors.black),
                                    ),
                                    Text(
                                      "₹ ${productList[index].price}",
                                      style: const TextStyle(
                                          fontSize: 18, color: Colors.green),
                                    ),
                                    Text(
                                      // overflow: TextOverflow.ellipsis,
                                      "${productList[index].cate}",
                                      style: const TextStyle(
                                          fontSize: 15,
                                          color: Colors.deepOrange),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            // SizedBox(
                            //   width: 5.sp,
                            // ),
                            // Column(
                            //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            //   children: [
                            //     Container(
                            //       width: 100.sp,
                            //       child: Text(
                            //         overflow: TextOverflow.ellipsis,
                            //         "${productList[index].desc}",
                            //         style: TextStyle(
                            //             fontSize: 15, color: Colors.black38),
                            //       ),
                            //     ),
                            //     Text(
                            //       "⭐⭐⭐⭐",
                            //       style: TextStyle(fontSize: 18),
                            //     ),
                            //   ],
                            // ),
                            SizedBox(
                              width: 5.sp,
                            ),
                            PopupMenuButton(
                              itemBuilder: (context) {
                                return [
                                  PopupMenuItem(
                                    onTap: () {
                                      FirebaseHelper.firebaseHelper
                                          .deleteData(productList[index].id);
                                      NotificationHelper.helper
                                          .showSoundNotification();
                                    },
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        const Icon(
                                          Icons.delete,
                                          color: Colors.red,
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        const Text("Delete")
                                      ],
                                    ),
                                  ),
                                ];
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            }
            return const Center(child: CircularProgressIndicator());
          },
        ),
        drawer: Drawer(
          width: 70.w,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Column(
              children: [
                //image
                controller.userDetails!['photo'] == null
                    ? const CircleAvatar(
                        radius: 55,
                        backgroundImage: AssetImage("assets/images/p.png"),
                      )
                    : CircleAvatar(
                        radius: 55,
                        backgroundImage:
                            NetworkImage("${controller.userDetails!['photo']}"),
                      ),
                // pickimage
                controller.userDetails!['photo'] == null
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.camera,
                              size: 25,
                            ),
                          ),
                          SizedBox(
                            width: 2.w,
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.photo,
                              size: 25,
                            ),
                          ),
                        ],
                      )
                    : Container(),
                // detail
                const SizedBox(
                  height: 10,
                ),
                buildListTile(Icons.person,
                    "${controller.userDetails!['name'] ?? 'Name not verify'}"),
                buildListTile(Icons.email,
                    "${controller.userDetails!['email'] ?? 'Email not verify'}"),
                buildListTile(Icons.phone,
                    "${controller.userDetails!['phone'] ?? 'Phone number not verify'}"),
                //sign out
                SizedBox(
                  height: 30.h,
                ),
                ElevatedButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              CircleAvatar(radius: 35,child: Icon(Icons.admin_panel_settings_outlined)),
                              const Text(
                                "Ecommerce Admin App !",
                                style: TextStyle(
                                    fontSize: 20, color: Colors.black,fontWeight: FontWeight.bold),
                              ),
                              const Text(
                                "Are you sure to signout\n the admine app",
                                style: TextStyle(
                                    fontSize: 15, color: Colors.black38),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 10,),
                             ElevatedButton(onPressed: () async {
                              String msg = await FirebaseHelper.firebaseHelper.signOut();
                              if(msg=="SignOut Successfully")
                                {
                                  Get.offAllNamed("/");
                                }
                              else
                                {
                                  Get.snackbar("", "$msg",colorText: Colors.black,backgroundColor: Colors.blue.shade50);
                                }
                             }, child: const Text("Sign Out"),),
                            ],
                          ),
                        );
                      },
                    );
                  },
                  child: const Text("Sign Out"),
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InkWell(
              onTap: () {
                Get.toNamed("add");
              },
              child: Container(
                height: 6.h,
                width: 25.w,
                margin: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.deepOrange,
                    boxShadow: [
                      const BoxShadow(color: Colors.deepOrange, blurRadius: 3)
                    ]),
                child: const Icon(Icons.add, size: 30, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }

  ListTile buildListTile(IconData i1, String data) {
    return ListTile(
      leading: Icon(
        i1,
      ),
      title: Text(
        "$data",
        style: const TextStyle(fontSize: 15, color: Colors.black),
      ),
    );
  }

  TextFormField buildTextFormField(name, c1, max) {
    return TextFormField(
      controller: c1,
      maxLines: max,
      decoration: InputDecoration(
        border: InputBorder.none,
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.deepOrange),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.deepOrange, width: 2),
        ),
        label: Text("Product $name"),
        hintText: "Product $name",
      ),
    );
  }
}

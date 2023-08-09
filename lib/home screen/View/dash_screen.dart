import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_firebase/Controller/home_controller.dart';
import 'package:ecommerce_firebase/Model/product_model.dart';
import 'package:ecommerce_firebase/utils/notification_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../utils/firebase_helper.dart';
import 'add_product.dart';
class DashScreen extends StatefulWidget {
  const DashScreen({Key? key}) : super(key: key);

  @override
  State<DashScreen> createState() => _DashScreenState();
}

HomeController controller = Get.put(HomeController());
class _DashScreenState extends State<DashScreen> {
  TextEditingController txtname = TextEditingController();
  TextEditingController txtprice = TextEditingController();
  TextEditingController txtcate = TextEditingController();
  TextEditingController txtimg = TextEditingController();
  TextEditingController txtdisc = TextEditingController();

  @override
  void initState() {
    controller.userDatails.value= FirebaseHelper.helper.userDetaile();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("hk Digital"),
          actions: [
            IconButton(onPressed: () {
              NotificationHelper.notificationHelper.showBigPictureNotification();
            },icon: Icon(Icons.notification_add_outlined)),
            IconButton(onPressed: () {
              NotificationHelper.notificationHelper.timenotification();
            }, icon: Icon(Icons.timer_sharp))
          ],
        ),
        drawer: Drawer(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                SizedBox(
                  height: 3.h,
                ),
                controller.userDatails['photo'] != null ?
                CircleAvatar(
                        radius: 50.sp,
                        backgroundImage:
                            NetworkImage("${controller.userDatails['photo']}"),
                      )
                    : Container(
                        height: 50.h,
                        width: 50.h,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                        ),
                  child: Icon(Icons.person,size: 50.sp,),
                      ),
                SizedBox(
                  height: 2.h,
                ),
                Container(
                  height: controller.userDatails['name'] != null?18.sp:0,
                  child: Text(
                    controller.userDatails['name'] != null
                        ? "${controller.userDatails['name']}"
                        : "",
                    style:
                        TextStyle(fontSize: 15.sp, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  height: 2.h,
                ),
                Container(
                  height: controller.userDatails['phone'] != null?18.sp:0,
                  child: Text(
                    controller.userDatails['phone'] != null
                        ? "${controller.userDatails['phone']}"
                        : "",
                    style:
                        TextStyle(fontSize: 13.sp, fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  height: controller.userDatails['email'] != null?18.sp:0,
                  alignment: Alignment.center,
                  child: Text(
                    controller.userDatails['email'] != null
                        ? "${controller.userDatails['email']}"
                        : "",
                    style:
                    TextStyle(fontSize: 13.sp, fontWeight: FontWeight.bold),
                  ),
                ),
                Divider(),
                OutlinedButton(
                  onPressed: () {
                    FirebaseHelper.helper.logOut();
                    Get.snackbar('Successfully Logout', '',
                        margin: EdgeInsets.all(10));
                    Get.offAllNamed("signin");
                  },
                  child: Text("Log Out"),
                ),
              ],
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: StreamBuilder(
            stream: FirebaseHelper.helper.readProductData(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Center(
                  child: Text("${snapshot.error}"),
                );
              } else if (snapshot.hasData) {
                QuerySnapshot<Map<String, dynamic>>? qs = snapshot.data;
                List qsList = qs!.docs;
                List<ProductModel> productList = [];
                // List catList = [];

                // for(int i=0;i<productList.length;i++)
                //   {
                //     catList.add(productList.);
                //     print("================${catList.length}");
                //   }

                for (var x in qsList) {
                  Map m1 = x.data();
                  String? id = x.id;
                  String? name = m1['name'];
                  int? price = m1['price'];
                  String? category = m1['category'];
                  String? image = m1['image'];
                  String? desc = m1['desc'];

                  ProductModel m = ProductModel(
                      name: name,
                      price: price,
                      cate: category,
                      img: image,id: id,
                      desc: desc);

                  productList.add(m);
                }
                return GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,mainAxisExtent: 35.h),
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onLongPress: () {
                        showDialog(context: context, builder: (context) {
                          txtname = TextEditingController(text: productList[index].name);
                          txtprice = TextEditingController(text: "${int.parse("${productList[index].price}")}");
                          txtcate = TextEditingController(text: productList[index].cate);
                          txtimg = TextEditingController(text: productList[index].img);
                          txtdisc = TextEditingController(text: productList[index].desc);
                          return AlertDialog(
                            title: Text('Update'),
                            content: SingleChildScrollView(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  SizedBox(height: 20),
                                  buildTextField(hint: "Name", contro: txtname),
                                  SizedBox(height: 10),
                                  buildTextField(hint: "Price", contro: txtprice),
                                  SizedBox(height: 10),
                                  buildTextField(hint: "Category", contro: txtcate),
                                  SizedBox(height: 10),
                                  buildTextField(hint: "Image link", contro: txtimg),
                                  SizedBox(height: 10),
                                  buildTextField(hint: "Description", contro: txtdisc),
                                  SizedBox(height: 10),
                                  ElevatedButton(
                                      onPressed: () async {
                                        ProductModel model = ProductModel(
                                          name: txtname.text,
                                          price: int.parse(txtprice.text),
                                          cate: txtcate.text,
                                          img: txtimg.text,
                                          desc: txtdisc.text,
                                          id: productList[index].id
                                        );
                                        FirebaseHelper.helper.updateData(model);
                                        Get.back();
                                      },
                                      child: Text("Update"))
                                ],
                              ),
                            ),
                          );
                        },);
                      },
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            height: 25.h,
                            width: 40.w,
                            alignment: Alignment.topLeft,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15.sp),
                                image: DecorationImage(
                                  image: NetworkImage("${productList[index].img}")
                                ),
                                color: Colors.grey.shade100),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  height: 4.h,
                                  width: 4.h,
                                  margin: EdgeInsets.all(10),
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.black),
                                  child: Icon(
                                    Icons.favorite_border_outlined,
                                    color: Colors.white,
                                  ),
                                ),
                        PopupMenuButton(itemBuilder: (context) {
                          return [
                            PopupMenuItem(child: Text("Delete"),onTap: () {
                              print('============${productList[index].id}');
                              FirebaseHelper.helper.deleteData('${productList[index].id}');
                            },),
                          ];

                        },),

                        ],
                            ),
                          ),
                          Padding(
                            padding:  EdgeInsets.symmetric(horizontal: 20.sp),
                            child: Text(
                              "${productList[index].name}",
                              style: TextStyle(
                                  fontSize: 13.sp,
                                  fontWeight: FontWeight.bold),maxLines: 1,
                            ),
                          ),
                          Padding(
                            padding:  EdgeInsets.symmetric(horizontal: 20.sp),
                            child: Text(
                              "${productList[index].desc}",
                              style: TextStyle(
                                  fontSize: 11.sp,
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w500),maxLines: 1,
                            ),
                          ),
                          Text(
                            "₹${productList[index].price}",
                            style: TextStyle(
                                fontSize: 13.sp,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    );
                  },
                  itemCount: productList.length,
                );
              }
              return Center(
                child: CircularProgressIndicator(),
              );
            },
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Get.toNamed('add',arguments: 0);
          },
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}

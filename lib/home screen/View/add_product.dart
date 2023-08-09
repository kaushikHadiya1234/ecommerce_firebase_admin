import 'package:ecommerce_firebase/Model/product_model.dart';
import 'package:ecommerce_firebase/utils/firebase_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:sizer/sizer.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({Key? key}) : super(key: key);

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}
TextField buildTextField({required hint, required contro}) {
  return TextField(
    controller: contro,
    decoration: InputDecoration(
        contentPadding: EdgeInsets.all(12.sp),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.sp),
          borderSide: BorderSide(color: Color(0xff811e1e)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.sp),
          borderSide: BorderSide(color: Color(0xff811e1e)),
        ),
        hintText: "$hint",
        label: Text("Product $hint")),
  );
}
class _AddProductScreenState extends State<AddProductScreen> {
  TextEditingController txtname = TextEditingController();
  TextEditingController txtprice = TextEditingController();
  TextEditingController txtcate = TextEditingController();
  TextEditingController txtimg = TextEditingController();
  TextEditingController txtdisc = TextEditingController();
  String? id;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
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
                    );
                    FirebaseHelper.helper.insert(model);
                    Get.back();
                  },
                  child: Text("Add"))
            ],
          ),
        ),
      ),
    );
  }


}

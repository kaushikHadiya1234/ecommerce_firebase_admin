import 'package:ecommerce_firebase/utils/firebase_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController txtuser = TextEditingController();
  TextEditingController txtEmail = TextEditingController();
  TextEditingController txtPassword = TextEditingController();
  TextEditingController txtconformPassword = TextEditingController();

  var txtkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Form(
        key: txtkey,
        child: Scaffold(
          body: Stack(
            children: [
              SingleChildScrollView(
                physics: NeverScrollableScrollPhysics(),
                child: Container(
                  height: 100.h,
                  width: 100.w,
                  child: Column(
                    children: [
                      Align(
                          alignment: Alignment.topLeft,
                          child: Image.asset(
                            'assets/images/r1.png',
                            height: 24.h,
                          )),
                      Spacer(),
                      Align(
                          alignment: Alignment.bottomRight,
                          child: Image.asset(
                            'assets/images/r2.png',
                            height: 20.h,
                          )),
                    ],
                  ),
                ),
              ),
              SingleChildScrollView(
                physics: NeverScrollableScrollPhysics(),
                child: Container(
                  height: 100.h,
                  width: 100.w,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(height: 6.h),
                        Text(
                          "Lets Get Started!",
                          style: TextStyle(
                              fontSize: 18.sp,
                              color: Color(0xff801C1C),
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "Create an account to get all features",
                          style: TextStyle(
                              fontSize: 10.sp,
                              color: Colors.grey,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 2.h,
                        ),
                        buildtextfiled(
                            label: 'User name',
                            contro: txtuser,
                            hide: false,
                            hint: "username"),
                        SizedBox(
                          height: 2.h,
                        ),
                        buildtextfiled(
                            label: 'Email',
                            contro: txtEmail,
                            hide: false,
                            hint: "Email"),
                        SizedBox(
                          height: 2.h,
                        ),
                        buildtextfiled(
                            label: 'Password',
                            contro: txtPassword,
                            hide: true,
                            hint: "Password"),
                        SizedBox(
                          height: 2.h,
                        ),
                        buildtextfiled(
                            label: 'Conform Password',
                            contro: txtconformPassword,
                            hide: true,
                            hint: "cPassword"),
                        SizedBox(
                          height: 15,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Row(
                            children: [
                              Icon(
                                Icons.check_box,
                                color: Color(0xff801C1C),
                              ),
                              SizedBox(width: 8),
                              Expanded(
                                child: Container(
                                  child: Text(
                                    "By registering, you are agreeing with our Terms of Use and Privacy Policy",
                                    style: TextStyle(
                                        fontSize: 11.sp, color: Colors.black),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 30),
                        Container(
                          height: 6.5.h,
                          width: 90.w,
                          alignment: Alignment.bottomCenter,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Color(0xffa83939)),
                          child: InkWell(
                            onTap: () async {
                              if (txtkey.currentState!.validate()) {
                                String? msg = await FirebaseHelper.helper
                                    .signUp(txtEmail.text, txtPassword.text);
                                Get.snackbar('$msg', 'Please quick login',
                                    margin: EdgeInsets.all(10),
                                    backgroundColor: Colors.red.shade100);
                                if (msg == "Success") {
                                  Get.offAllNamed('signin');
                                }
                              }
                            },
                            child: Container(
                              height: 6.h,
                              width: 90.w,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Color(0xff811e1e)),
                              child: Text(
                                "Sign Up",
                                style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 5.h,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'you have already account?',
                              style: TextStyle(
                                  fontSize: 11.sp, color: Color(0xff000000)),
                            ),
                            SizedBox(width: 5),
                            InkWell(
                              onTap: () {
                                Get.back();
                              },
                              child: Text(
                                'Sign In',
                                style: TextStyle(
                                    fontSize: 12.sp,
                                    color: Color(0xff801C1C),
                                    fontWeight: FontWeight.bold),
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 1.h,
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Padding buildtextfiled({label, contro, hide, hint}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: TextFormField(
        validator: (value) {
          if (hint == "username") {
            if (value!.isEmpty) {
              return "Enter the user name";
            }
          } else if (hint == "Email") {
            if (value!.isEmpty) {
              return "Enter the Email";
            } else if (value.isEmail) {
            } else {
              return "Enter the valid Email";
            }
          } else if (hint == "Password") {
            if (value!.isEmpty) {
              return "Enter the Password";
            } else if (value.length < 8) {
              return "Enter the atlist 8 digit password";
            }
          } else if (hint == "cPassword") {
            if (value!.isEmpty) {
              return "Enter the conform Password";
            } else if (value != txtPassword.text) {
              return "Enter the same password";
            }
          }
        },
        obscureText: hide,
        controller: contro,
        decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            contentPadding: EdgeInsets.all(16),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(color: Color(0xff000000)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(color: Color(0xff000000)),
            ),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide(color: Color(0xff000000))),
            label: Text("$label")),
      ),
    );
  }
}

import 'package:ecommerce_firebase/utils/firebase_helper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {

  TextEditingController txtEmail = TextEditingController();
  TextEditingController txtPassword = TextEditingController();
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
                child: Container(
                  height: 100.h,
                  width: 100.w,
                  child: Column(
                    children: [
                      Align(
                          alignment: Alignment.topLeft,
                          child: Image.asset(
                            'assets/images/b1.png',
                            height: 30.h,
                          )),
                      Spacer(),
                      Align(
                          alignment: Alignment.bottomRight,
                          child: Image.asset(
                            'assets/images/b2.png',
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
                        SizedBox(height: 5.h),
                        Text(
                          "Welcome back!",
                          style: TextStyle(
                              fontSize: 18.sp,
                              color: Color(0xff801C1C),
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 5.h,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15.0),
                          child: TextFormField(
                            controller: txtEmail,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Enter the Email";
                              } else if (value.isEmail) {
                              } else {
                                return "Enter the valid Email";
                              }
                            },
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
                                    borderSide:
                                    BorderSide(color: Color(0xff000000))),
                                label: Text("Email")),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15.0),
                          child: TextFormField(
                            controller: txtPassword,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Enter the Password";
                              } else if (value.length < 8) {
                                return "Enter the atlist 8 digit password";
                              }
                            },
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
                                    borderSide:
                                    BorderSide(color: Color(0xff000000))),
                                label: Text("Password")),
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15.0),
                          child: Row(
                            children: [
                              Icon(
                                Icons.check_box,
                                color: Color(0xff801C1C),
                              ),
                              SizedBox(width: 8),
                              Text(
                                "Remember me",
                                style: TextStyle(
                                    fontSize: 11.sp, color: Colors.black),
                              ),
                              Spacer(),
                              Text(
                                'Forgot password?',
                                style: TextStyle(
                                    fontSize: 12.sp,
                                    color: Color(0xff801C1C),
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 30),
                        InkWell(
                          onTap: () async {
                            if(txtkey.currentState!.validate())
                              {
                                String? msg = await FirebaseHelper.helper.signIn(txtEmail.text, txtPassword.text);

                                if(msg=="Success")
                                {
                                  Get.offAllNamed('dash');
                                  Get.snackbar('Success', 'Please quick login',
                                      margin: EdgeInsets.all(10),
                                      backgroundColor: Colors.red.shade100);
                                }
                                else
                                  {
                                    Get.snackbar('Wrong', 'Please check Email and Password',
                                        margin: EdgeInsets.all(10),
                                        backgroundColor: Colors.red.shade100);
                                  }

                              }
                          },
                          child: Container(
                            height: 6.5.h,
                            width: 90.w,
                            alignment: Alignment.bottomCenter,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Color(0xffa83939)),
                            child: Container(
                              height: 6.h,
                              width: 90.w,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Color(0xff811e1e)),
                              child: Text(
                                "Login",
                                style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 5.h,),
                        Text('Or connect with',style: TextStyle(fontSize: 12.sp,color: Color(0xff000000)),),
                        SizedBox(height: 1.h,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            InkWell(onTap: () async {
                              String msg = await FirebaseHelper.helper.googleSignIn();

                              if(msg=="Success")
                                {
                                  Get.snackbar('Sucess', 'Welcome to your app',margin: EdgeInsets.all(10));
                                  Get.offAllNamed('dash');
                                }

                            },child: Image.asset('assets/images/g.png',height: 5.h)),
                            SizedBox(width: 5.w,),
                            Image.asset('assets/images/face.png',height: 9.h,),
                            SizedBox(width: 5.w,),
                            IconButton(onPressed: () async {
                             String? msg=await FirebaseHelper.helper.SignInGuest();
                             print('=================$msg');

                             if(msg=="Success")
                               {
                                 Get.offAllNamed('dash');
                                 Get.snackbar('Success', 'Welcome to your app',margin: EdgeInsets.all(10));
                               }
                             else
                               {
                                 Get.snackbar('Failed', 'Please try again',margin: EdgeInsets.all(10));
                               }

                            }, icon: Icon(Icons.person_rounded,size: 4.7.h,))
                          ],
                        ),
                        SizedBox(height: 1.h,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Don’t have an account?',style: TextStyle(fontSize: 11.sp,color: Color(0xff000000)),),
                            InkWell(
                              onTap: () {
                                Get.toNamed('signup');
                              },
                                child: Text('Sign Up',style: TextStyle(fontSize: 12.sp,color: Color(0xff801C1C),fontWeight: FontWeight.bold),))
                          ],
                        ),
                        SizedBox(height: 1.h,),
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
}

import 'package:flutter/material.dart';
import 'package:letshelp/screens/first_page.dart';
import 'package:letshelp/utils/user_type_enums.dart';
import 'package:letshelp/widgets/tad_button.dart';
import 'package:letshelp/widgets/tad_form_field.dart';
import 'package:provider/provider.dart';
import '../provider/auth_provider.dart';
import '../theme/colors.dart';
import '../utils/global_key.dart';
import 'ceate_acount.dart';

class Login extends StatelessWidget {
  Login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Consumer<Auth>(
        builder: (context, auth, _) => Scaffold(
          body: SingleChildScrollView(
            child: Center(
              child: Column(children: [
                Container(
                  child: Stack(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 20,
                        ),
                        height: height * 0.5 - 58,
                        decoration: BoxDecoration(
                            color: kTeal400,
                            borderRadius: BorderRadius.only(
                                bottomRight: Radius.circular(35),
                                bottomLeft: Radius.circular(35))),
                      ),
                      Positioned(
                        top: height * .14,
                        left: width * 0.15,
                        child: Container(
                          alignment: Alignment.center,
                          margin: EdgeInsets.symmetric(
                            horizontal: 30,
                          ),
                          height: height * 0.25 - 40,
                          width: width * 0.6,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                              // borderRadius: BorderRadius.all(Radius.circular(80)),
                              boxShadow: [
                                BoxShadow(
                                    offset: Offset(0, 5),
                                    blurRadius: 40,
                                    color: kTeal400.withOpacity(0.30))
                              ]),
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child: Image.asset(
                                "assets/images/logo.png",
                                fit: BoxFit.fill,
                              )),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: height * 0.07,
                ),
                Form(
                  key: RIKeys.loginFormKey,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: width * .13),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TadFormFeild(
                            controller: auth.email_login,
                            label: "البريد الإلكتروني",
                            hintText: "example@example.com",
                            validation: (val) {
                              val = auth.email_login.text;
                              if (!val.contains("@")) {
                                return "عنوان بريد غير صالح";
                              }
                              if (val.isEmpty) {
                                return "هذا الحقل مطلوب";
                              } else {
                                return null;
                              }
                            },
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * .04,
                          ),
                          TadFormFeild(
                            isPassword: true,
                            icon: Icons.lock_outline,
                            controller: auth.password_login,
                            label: "كلمة المرور",
                            validation: (val) {
                              val = auth.email_login.text;
                              if (val.length < 8) {
                                return "كلمة السر قصيرة جدا";
                              }
                              if (val.isEmpty) {
                                return "هذا الحقل مطلوب";
                              } else {
                                return null;
                              }
                            },
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * .04,
                          ),
                          auth.isLoading
                              ? CircularProgressIndicator()
                              : TadButton(
                                  radius: 15,
                                  text: "تسجيل الدخول",
                                  onPress: () async {
                                    if (RIKeys.loginFormKey.currentState!
                                        .validate()) {
                                      await auth.login().then((value) {
                                        if (auth.isAuth == null) {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            SnackBar(
                                              backgroundColor: Colors.redAccent,
                                              duration: Duration(seconds: 10),
                                              content: Container(
                                                child: Expanded(
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                        "${auth.loginMessagesError}",
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color:
                                                                Colors.white),
                                                      ),
                                                      Icon(
                                                        auth.loginMessagesError ==
                                                                "الرجاء اكمال الملف الشخصي"
                                                            ? Icons.edit
                                                            : Icons
                                                                .wifi_off_outlined,
                                                        color: Colors.white,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          );
                                        }
                                        if (auth.isAuth == true) {
                                          Navigator.pushAndRemoveUntil(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      FirstPage()),
                                              (route) => false);
                                        } else if (auth.isAuth == false) {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            SnackBar(
                                              backgroundColor: Colors.redAccent,
                                              duration: Duration(seconds: 10),
                                              content: Container(
                                                child: Expanded(
                                                  child: Text(
                                                    auth.loginMessagesError!,
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          );
                                        }
                                      });
                                    }
                                  },
                                ),
                          auth.user != null
                              ? auth.user.userType == UserType.needVerifyEmail
                                  ? Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "لم يصلني رمز التحقق :",
                                          style: TextStyle(color: Colors.red),
                                        ),
                                        TextButton(
                                            onPressed: () async {
                                              await auth
                                                  .resendCode()
                                                  .then((value) {
                                                if (value) {
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(
                                                    SnackBar(
                                                      backgroundColor: kTeal400,
                                                      duration:
                                                          Duration(seconds: 10),
                                                      content: Container(
                                                        child: Text(
                                                          "تم ارسال الكود بنجاح",
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                      ),
                                                    ),
                                                  );
                                                } else {
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(
                                                    SnackBar(
                                                      backgroundColor:
                                                          Colors.redAccent,
                                                      duration:
                                                          Duration(seconds: 10),
                                                      content: Container(
                                                        child: Text(
                                                          "حدث خطأ ما خلال إعادة الإرسال",
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                      ),
                                                    ),
                                                  );
                                                }
                                              });
                                            },
                                            child: Text(
                                              " إعادة الإرسال",
                                              style: TextStyle(
                                                color: kTeal400,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20,
                                              ),
                                            )),
                                      ],
                                    )
                                  : Container()
                              : Container(),

                          Center(
                            child: ElevatedButton(
                              style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                      Colors.redAccent)),
                              child: Text(
                                "تسجيل الدخول بواسطة Google",
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                              onPressed: () async {
                                auth.googleSignIn.signIn().then((result) {
                                  result!.authentication
                                      .then((googleKey) async {
                                    print(
                                        "the token is : ${googleKey.accessToken}");
                                    if (googleKey.accessToken != null) {
                                      await auth
                                          .googleLogin(googleKey.accessToken!);
                                    }
                                  }).catchError((e) {
                                    print('inner error');
                                  });
                                }).catchError((e) {
                                  print('error occured');
                                });
                              },
                            ),
                          ),
                          // TadButton(
                          //   text: 'تسجيل الخروج من google ',
                          //   onPress: () async {
                          //
                          //   },
                          // ),
                          SizedBox(
                            height: 5,
                          ),
                          Container(
                            decoration: BoxDecoration(),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "ليس لديك حساب ؟",
                                  style: TextStyle(
                                      color: kTeal400,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * .02,
                                ),
                                TextButton(
                                  child: Text(
                                    "إنشاء حساب",
                                    style: TextStyle(
                                        color: kTeal400,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                CreateAccount()));
                                  },
                                ),
                              ],
                            ),
                          ),

                          TextButton(
                              onPressed: () async {
                                await auth.loginAsGuest().then((value) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => FirstPage(),
                                    ),
                                  );
                                });
                              },
                              child: Text(
                                "دخول كزائر",
                                style: TextStyle(
                                    color: kTeal400,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold),
                              )),
                        ]),
                  ),
                ),
              ]),
            ),
          ),
        ),
      ),
    );
  }
}

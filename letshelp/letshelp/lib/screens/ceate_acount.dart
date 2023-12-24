import 'package:flutter/material.dart';
import 'package:letshelp/screens/login.dart';
import 'package:letshelp/widgets/tad_button.dart';
import 'package:letshelp/widgets/tad_form_field.dart';
import 'package:provider/provider.dart';
import '../provider/auth_provider.dart';
import '../theme/colors.dart';
import '../utils/global_key.dart';

class CreateAccount extends StatelessWidget {
  const CreateAccount({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Consumer<Auth>(
      builder: (context, auth, _) => Scaffold(
          body: Directionality(
        textDirection: TextDirection.rtl,
        child: SingleChildScrollView(
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
              Padding(
                padding: EdgeInsets.symmetric(horizontal: width * .13),
                child: Form(
                  key: RIKeys.formKey,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Builder(
                          builder: (context) => TadFormFeild(
                            controller: auth.acoountName,
                            label: "اسم الحساب ",
                            validation: (value) {
                              value = auth.acoountName.text;
                              if (value.isEmpty) {
                                return 'هذا الحقل مطلوب';
                              } else if (value.length < 2) {
                                return 'الاسم قصير جدا';
                              } else {
                                return null;
                              }
                            },
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * .04,
                        ),
                        TadFormFeild(
                          controller: auth.email,
                          label: "االبريد الإلكتروني",
                          validation: (value) {
                            value = auth.email.text;
                            if (value.isEmpty) {
                              return 'هذا الحقل مطلوب';
                            } else if (!value.contains("@") ||
                                !value.contains(".")) {
                              return "عنوان البريد الالكتروني  غير صالح";
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
                          controller: auth.password,
                          label: "كلمة المرور",
                          validation: (value) {
                            value = auth.password.text;
                            if (value.isEmpty) {
                              return 'هذا الحقل مطلوب';
                            } else if (value.length < 9) {
                              return "يجب ان لاتقل كلمة المرور عن 8 محارف";
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
                            controller: auth.passwordConfirm,
                            label: "تأكيد كلمة المرور",
                            validation: (value) {
                              value = auth.passwordConfirm.text;
                              if (value.isEmpty) {
                                return 'هذا الحقل مطلوب';
                              } else if (value != auth.password.text) {
                                return 'لايوجد تطابق بكلمات المرور';
                              } else {
                                return null;
                              }
                            }),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * .04,
                        ),
                        Consumer<Auth>(
                          builder: (context, auth, _) => auth.isRegisterLoading
                              ? CircularProgressIndicator(
                                  color: kTeal400,
                                )
                              : TadButton(
                                  radius: 15,
                                  verticalPadding: 20,
                                  text: "تسجيل معلومات الحساب",
                                  onPress: () async {
                                    if (RIKeys.formKey.currentState!
                                        .validate()) {
                                      auth.signup().then((value) {
                                        if (value == true) {
                                          Navigator.pop(context);
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            SnackBar(
                                              backgroundColor: kTeal400,
                                              duration: Duration(seconds: 10),
                                              content: Container(
                                                child: Text(
                                                  "تم انشاء حساب الرجاء التحقق من الايميل للتفعيل ",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                            ),
                                          );
                                        } else {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            SnackBar(
                                              backgroundColor: Colors.redAccent,
                                              duration: Duration(seconds: 10),
                                              content: Container(
                                                child: Expanded(
                                                  child: Text(
                                                    auth.registerErrorMessage!,
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
                        ),
                        SizedBox(
                          height: 5,
                        ),
                      ]),
                ),
              ),
            ]),
          ),
        ),
      )),
    );
  }
}

import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:letshelp/provider/auth_provider.dart';
import 'package:letshelp/provider/map_provider.dart';
import 'package:letshelp/screens/login.dart';
import 'package:letshelp/screens/map.dart';
import 'package:letshelp/utils/global_key.dart';
import 'package:letshelp/widgets/tad_form_field.dart';
import 'package:letshelp/widgets/tad_snackbar_error.dart';
import 'package:provider/provider.dart';

import '../theme/colors.dart';

class CompleteProfile extends StatelessWidget {
  const CompleteProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<String> gender = ["ذكر", "انثى"];
    String hintText = gender[0];
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: kTeal400,
            title: Text("يرجى إكمال الملف الشخصي"),
            centerTitle: true,
          ),
          body: Consumer<Auth>(
            builder: (context, authProvider, _) => SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.all(15),
                child: Form(
                  key: RIKeys.completeProfileKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Card(
                        elevation: 15,
                        child: Container(
                          width: double.infinity,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                " تعديل معلومات الحساب:",
                                style: TextStyle(
                                    color: kTeal400,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 23),
                              ),
                              Container(
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(color: kGrey400),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "معلومات الحساب",
                                        style: TextStyle(
                                          color: kTeal444,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        "ستظهر هذه المعلومات لمستخدمي وزوار التطبيق في صفحة الحساب الخاصة بك",
                                        style: TextStyle(
                                          color: kTeal444,
                                        ),
                                      ),
                                      Divider(
                                        thickness: 3,
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            "يمكنك مراجعة سياسة الخصوصية من هنا",
                                            style: TextStyle(
                                              color: kTeal444,
                                            ),
                                          ),
                                          TextButton(
                                              onPressed: () {},
                                              child: Text(
                                                "سياسة الخصوصية",
                                                style: TextStyle(
                                                  color: kTeal400,
                                                ),
                                              ))
                                        ],
                                      ),
                                    ],
                                  )),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TadFormFeild(
                                  validation: (val) {
                                    val = authProvider.fullNameContoller.text;
                                    if (val.isEmpty) {
                                      return "هذا الحقل مطلوب";
                                    } else if (val.length < 2) {
                                      return "الاسم قصير جدا";
                                    } else {
                                      return null;
                                    }
                                  },
                                  controller: authProvider.fullNameContoller,
                                  stringHelperText: "اسم الحساب",
                                  isColumn: true,
                                  isRequierd: true,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Card(
                        elevation: 15,
                        child: Container(
                          width: double.infinity,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "تعديل المعلومات الشخصية",
                                style: TextStyle(
                                    color: kTeal400,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 23),
                              ),
                              Container(
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(color: kGrey400),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "المعلومات الشخصية",
                                        style: TextStyle(
                                          color: kTeal444,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        "لن نقوم بشاركة هذه المعلومات مع الاخرين بل ستظهر فقط لمدراء الموقع وسنستخدمها فقط للتواصل معك",
                                        style: TextStyle(
                                          color: kTeal444,
                                        ),
                                      ),
                                      Divider(
                                        thickness: 3,
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            "يمكنك مراجعة سياسة الخصوصية من هنا",
                                            style: TextStyle(
                                              color: kTeal444,
                                            ),
                                          ),
                                          TextButton(
                                              onPressed: () {},
                                              child: Text(
                                                "سياسة الخصوصية",
                                                style: TextStyle(
                                                  color: kTeal400,
                                                ),
                                              ))
                                        ],
                                      )
                                    ],
                                  )),
                              SizedBox(
                                height: 20,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    TadFormFeild(
                                      validation: (val) {
                                        val = authProvider
                                            .firstNameController.text;
                                        if (val.isEmpty) {
                                          return "هذا الحقل مطلوب";
                                        } else if (val.length < 2) {
                                          return "الاسم قصير جدا";
                                        } else {
                                          return null;
                                        }
                                      },
                                      controller:
                                          authProvider.firstNameController,
                                      stringHelperText: "الاسم الأول",
                                      isColumn: true,
                                      isRequierd: true,
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    TadFormFeild(
                                      validation: (val) {
                                        val =
                                            authProvider.lastNameContoller.text;
                                        if (val.isEmpty) {
                                          return "هذا الحقل مطلوب";
                                        } else if (val.length < 2) {
                                          return "الاسم قصير جدا";
                                        } else {
                                          return null;
                                        }
                                      },
                                      controller:
                                          authProvider.lastNameContoller,
                                      stringHelperText: "الاسم الاخير ",
                                      isColumn: true,
                                      isRequierd: true,
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    TadFormFeild(
                                      validation: (val) {
                                        val =
                                            authProvider.emaillController.text;
                                        if (val.isEmpty) {
                                          return "هذا الحقل مطلوب";
                                        } else if (!val.contains("@") ||
                                            !val.contains(".")) {
                                          return "عنوان البريد الالكتروني غصير صالح";
                                        } else {
                                          return null;
                                        }
                                      },
                                      controller: authProvider.emaillController,
                                      isColumn: true,
                                      stringHelperText:
                                          "عنوان البريد الإلكتروني الخاص بالتواصل",
                                      isRequierd: true,
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    TadFormFeild(
                                      controller:
                                          authProvider.phoneNumberCotroller,
                                      isColumn: true,
                                      stringHelperText: "رقم الهاتف",
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Text(
                                      "الجنس",
                                      style: TextStyle(color: kTeal400),
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          border: Border.all(color: kTeal400)),
                                      width: double.infinity,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                            flex: 8,
                                            child: DropdownButton<dynamic>(
                                              items: gender
                                                  .map(
                                                    (e) => DropdownMenuItem<
                                                        dynamic>(
                                                      value: e,
                                                      child: Text(
                                                        e,
                                                      ),
                                                    ),
                                                  )
                                                  .toList(),
                                              onChanged: (val) {
                                                print(val);
                                                authProvider.genderController
                                                    .text = val;
                                              },
                                            ),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: Padding(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 10),
                                                child: Text(hintText)),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    DateTimePicker(
                                      errorFormatText: "تاريخ ميلاد غير صالح",
                                      errorInvalidText: "تاريخ ميلاد غير صالح",
                                      style: TextStyle(color: kTeal400),
                                      decoration: InputDecoration(
                                          fillColor: kTeal400,
                                          icon: Icon(
                                            Icons.cake,
                                            color: kTeal400,
                                          )),
                                      cursorColor: kTeal400,
                                      calendarTitle: "تاريخ الميلاد",
                                      type: DateTimePickerType.date,
                                      initialValue: DateTime.now().toString(),
                                      firstDate: DateTime(2022),
                                      lastDate: DateTime(2023),
                                      icon: const Icon(Icons.event),
                                      dateLabelText: 'Date',
                                      timeLabelText: "Hour",
                                      selectableDayPredicate: (date) {
                                        return true;
                                      },
                                      onChanged: (val) {
                                        DateTime.parse(val);
                                      },
                                      validator: (val) {
                                        return null;
                                      },
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Consumer<MapProvider>(
                                      builder: (context, mapProvider, _) =>
                                          Column(
                                        children: mapProvider.data.isEmpty
                                            ? [
                                                ElevatedButton(
                                                  style: ButtonStyle(
                                                      backgroundColor:
                                                          MaterialStateProperty
                                                              .all(kTeal400)),
                                                  onPressed: () async {
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                MapScreen()));

                                                    await mapProvider
                                                        .initState();
                                                  },
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceAround,
                                                    children: [
                                                      Text(
                                                        "اختيار العنوان من الخريطة   (مطلوب)",
                                                      ),
                                                      Icon(Icons.map)
                                                    ],
                                                  ),
                                                )
                                              ]
                                            : [
                                                TadFormFeild(
                                                  validation: (val) {
                                                    val = authProvider
                                                        .countryName.text;
                                                    if (val.isEmpty) {
                                                      return "هذا الحقل مطلوب";
                                                    } else if (val.length < 2) {
                                                      return "الاسم قصير جدا";
                                                    }
                                                  },
                                                  controller:
                                                      authProvider.countryName,
                                                  readOnly: true,
                                                  isColumn: true,
                                                  isRequierd: true,
                                                  stringHelperText: "البلد",
                                                ),
                                                SizedBox(
                                                  height: 20,
                                                ),
                                                TadFormFeild(
                                                  validation: (val) {
                                                    val = authProvider
                                                        .cityName.text;
                                                    if (val.isEmpty) {
                                                      return "هذا الحقل مطلوب";
                                                    }
                                                  },
                                                  controller:
                                                      authProvider.cityName,
                                                  readOnly: true,
                                                  isColumn: true,
                                                  isRequierd: true,
                                                  stringHelperText: "المدينة",
                                                ),
                                                SizedBox(
                                                  height: 20,
                                                ),
                                                TadFormFeild(
                                                  validation: (val) {
                                                    val = authProvider
                                                        .streetName.text;
                                                    if (val.isEmpty) {
                                                      return "هذا الحقل مطلوب";
                                                    }
                                                  },
                                                  controller:
                                                      authProvider.streetName,
                                                  isColumn: true,
                                                  isRequierd: true,
                                                  stringHelperText: "العنوان",
                                                ),
                                                Center(
                                                  child: InkWell(
                                                    child: Container(
                                                      padding:
                                                          EdgeInsets.all(5.2),
                                                      decoration: BoxDecoration(
                                                        border: Border.all(
                                                            color: kTeal400,
                                                            width: 2),
                                                      ),
                                                      child: InkWell(
                                                        onTap: () async {
                                                          Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                  builder:
                                                                      (context) =>
                                                                          MapScreen()));

                                                          await mapProvider
                                                              .initState();
                                                        },
                                                        child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .center,
                                                            children: [
                                                              Text(
                                                                "تعديل الموقع",
                                                                style:
                                                                    TextStyle(
                                                                  color:
                                                                      kTeal400,
                                                                ),
                                                              ),
                                                              Icon(
                                                                Icons.edit,
                                                                color: kTeal400,
                                                              )
                                                            ]),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                      ),
                                    ),
                                    Center(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: ElevatedButton(
                                            style: ButtonStyle(
                                                backgroundColor:
                                                    MaterialStateProperty.all(
                                                        kTeal400)),
                                            child: Text("ارسال المعلومات"),
                                            onPressed: () async {
                                              if (authProvider.countryName.text
                                                      .isEmpty ||
                                                  authProvider
                                                      .cityName.text.isEmpty) {
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(SnackBar(
                                                        content: Text(
                                                            "الرجاء تحديد العنوان من الخريطة ")));
                                              } else if (RIKeys
                                                  .completeProfileKey
                                                  .currentState!
                                                  .validate()) {
                                                authProvider
                                                    .completeProfile()
                                                    .then((value) {
                                                  if (value) {
                                                    MySnackBar(
                                                        text: authProvider
                                                            .completeProfileMessage,
                                                        type: MySnackBarType
                                                            .success,
                                                        context: context);
                                                    Navigator.pushAndRemoveUntil(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder:
                                                                (context) =>
                                                                    Login()),
                                                        (route) => false);
                                                  } else {
                                                    MySnackBar(
                                                        text: authProvider
                                                            .completeProfileMessage,
                                                        type: MySnackBarType
                                                            .error,
                                                        context: context);
                                                  }
                                                });
                                              } else {}
                                            }),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )),
    );
  }
}

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:letshelp/provider/order-provider.dart';
import 'package:provider/provider.dart';

import '../theme/colors.dart';

class AddNewOrder extends StatelessWidget {
  const AddNewOrder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Consumer<OrderProvider>(
          builder: (context, orderProvider, _) => Scaffold(
                appBar: AppBar(
                  title: Text('إضافة طلب'),
                  backgroundColor: kTeal400,
                ),
                body: SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  child: Center(
                    child: Form(
                      key: orderProvider.addOrderForm,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: MediaQuery.of(context).size.height * .02,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * .7,
                            child: TextFormField(
                              controller: orderProvider.productName,
                              style: TextStyle(height: 1),
                              keyboardType: TextInputType.text,
                              cursorColor: kTeal400,
                              decoration: InputDecoration(
                                labelText: 'اسم المنتج',
                                hintText: '',
                                fillColor: Colors.white,
                                // filled: true,
                              ),
                              validator: (value) {
                                value = orderProvider.productName.text;
                                if (value.isEmpty) {
                                  return "هذا الحقل مطلوب";
                                } else {
                                  return null;
                                }
                              },
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * .02,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * .7,
                            // height: MediaQuery.of(context).size.height * 0.09,
                            child: TextFormField(
                              controller: orderProvider.country,
                              style: TextStyle(height: 1),
                              keyboardType: TextInputType.text,
                              cursorColor: kTeal400,
                              decoration: InputDecoration(
                                labelText: 'البلد',
                                hintText: '',
                                fillColor: Colors.white,
                                //    filled: true,
                              ),
                              validator: (value) {
                                value = orderProvider.country.text;
                                if (value.isEmpty) {
                                  return "هذا الحقل مطلوب";
                                } else {
                                  return null;
                                }
                              },
                              onSaved: (value) {},
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * .02,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * .7,
                            // height: MediaQuery.of(context).size.height * 0.06,
                            child: TextFormField(
                              controller: orderProvider.city,
                              style: TextStyle(height: 1),
                              keyboardType: TextInputType.text,
                              cursorColor: kTeal400,
                              decoration: InputDecoration(
                                labelText: 'المدينة',
                                hintText: '',
                                fillColor: Colors.white,
                                //   filled: true,
                              ),
                              validator: (value) {
                                value = orderProvider.city.text;
                                if (value.isEmpty) {
                                  return "هذا الحقل مطلوب";
                                } else {
                                  return null;
                                }
                              },
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * .02,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * .7,
                            child: TextFormField(
                              controller: orderProvider.address,
                              style: TextStyle(height: 1),
                              keyboardType: TextInputType.text,
                              cursorColor: kTeal400,
                              decoration: InputDecoration(
                                labelText: 'العنوان',
                                hintText: '',
                                fillColor: Colors.white,
                              ),
                              validator: (value) {
                                value = orderProvider.address.text;
                                if (value.isEmpty) {
                                  return "هذا الحقل مطلوب";
                                } else {
                                  return null;
                                }
                              },
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * .02,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(5),
                                bottomRight: Radius.circular(5),
                                topLeft: Radius.circular(5),
                                bottomLeft: Radius.circular(5),
                              ),
                              color: Colors.white54,
                            ),
                            width: MediaQuery.of(context).size.width * .7,
                            height: MediaQuery.of(context).size.height * 0.15,
                            child: TextFormField(
                              controller: orderProvider.productDescription,
                              style: TextStyle(height: 3),
                              keyboardType: TextInputType.multiline,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: const BorderRadius.all(
                                    const Radius.circular(10.0),
                                  ),
                                ),
                                labelText: 'وصف المنتج',
                                hintText: '',
                                fillColor: Colors.white,
                                filled: true,
                              ),
                              validator: (value) {
                                value = orderProvider.productDescription.text;
                                if (value.isEmpty) {
                                  return "هذا الحقل مطلوب";
                                }

                                return null;
                              },
                              onSaved: (value) {},
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * .02,
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * .02,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(20),
                                bottomRight: Radius.circular(20),
                                topLeft: Radius.circular(20),
                                bottomLeft: Radius.circular(20),
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.white,
                                  spreadRadius: 1,
                                  blurRadius: 1,
                                  offset: Offset(
                                      0, 1), // changes position of shadow
                                ),
                              ],
                            ),
                            width: MediaQuery.of(context).size.width * .7,
                            height: MediaQuery.of(context).size.height * .06,
                            child: ElevatedButton(
                              child: Text("نشر",
                                  style: TextStyle(
                                    color: kGrey200,
                                    fontSize: 20,
                                  )),
                              onPressed: () async {
                                // productProvider.image1 = image;
                                // Validate returns true if the form is valid, or false otherwise.
                                if (orderProvider.addOrderForm.currentState!
                                    .validate()) {
                                  print("ready for send request ");
                                  print("add product request start ");
                                  await orderProvider.addOrder();
                                  if (orderProvider.statusCodeAddOrder == 200) {
                                    AwesomeDialog(
                                      context: context,
                                      animType: AnimType.TOPSLIDE,
                                      dialogType: DialogType.SUCCES,
                                      title: "تمت العملية",
                                      body: Directionality(
                                        textDirection: TextDirection.rtl,
                                        child: Container(
                                          padding: EdgeInsets.all(8),
                                          alignment: Alignment.center,
                                          child: Text(
                                            "تم اضافة طلب بنجاح",
                                            style: TextStyle(
                                              color: Colors.grey,
                                              fontSize: 22,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                      btnOkColor: Colors.red,
                                      btnOkOnPress: () {},
                                    ).show();
                                  }

                                  if (orderProvider.statusCodeAddOrder != 200) {
                                    AwesomeDialog(
                                      context: context,
                                      animType: AnimType.TOPSLIDE,
                                      dialogType: DialogType.ERROR,
                                      title: "فشل العملية",
                                      body: Directionality(
                                        textDirection: TextDirection.rtl,
                                        child: Container(
                                          padding: EdgeInsets.all(8),
                                          alignment: Alignment.center,
                                          child: Text(
                                            "${orderProvider.filedMessage}",
                                            style: TextStyle(
                                              color: Colors.grey,
                                              fontSize: 22,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                      btnOkColor: Colors.red,
                                      btnOkOnPress: () {},
                                    ).show();
                                  }
                                  print("add product request end ");
                                } else {
                                  print("not ready yet");
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: kTeal400,
                                minimumSize: const Size(300, 75),
                                maximumSize: const Size(300, 75),
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

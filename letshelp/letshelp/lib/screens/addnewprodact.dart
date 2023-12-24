import 'dart:io';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:letshelp/provider/categories_provider.dart';
import 'package:letshelp/provider/product.dart';
import 'package:letshelp/theme/colors.dart';
import 'package:provider/provider.dart';
import 'map_pick_location_screen.dart';

class goToAddNewProduct extends StatefulWidget {
  const goToAddNewProduct({Key? key}) : super(key: key);

  @override
  State<goToAddNewProduct> createState() => _goToAddNewProductState();
}

class _goToAddNewProductState extends State<goToAddNewProduct> {
  String? dropdowntyprsrvic;

  late String mainPhoto;

  void setMainPhoto(String image) {
    mainPhoto = image;
  }

  var _pickedLocation;

  Future<void> _selectOnMap() async {
    final selectedLocation = await Navigator.of(context).push<LatLng>(
      MaterialPageRoute(
        builder: (ctx) => MapToPickLocationScreen(),
      ),
    );
    setState(() {
      _pickedLocation = selectedLocation;
    });
  }

  File? image;
  final imagePicked = ImagePicker();
  uploadImage() async {
    // ignore: deprecated_member_use
    var pickedImage = await imagePicked.getImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        image = File(pickedImage.path);
      });
    } else {}
  }

  // Initial Selected Value
  String dropdownvalue = 'Item 1';

  // List of items in our dropdown menu
  List<dynamic> items = [
    'Item 1',
    'Item 2',
    'Item 3',
    'Item 4',
    'Item 5',
  ];
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Consumer<CategoriesProvider>(
        builder: (context, catProvider, _) => Consumer<Product>(
            builder: (context, productProvider, _) => Scaffold(
                  appBar: AppBar(
                    title: Text('إضافة منتج'),
                    backgroundColor: kTeal400,
                  ),
                  body: catProvider.loadedItems.isEmpty
                      ? Center(
                          child: Container(
                              child: CircularProgressIndicator(
                          color: kTeal400,
                        )))
                      : SingleChildScrollView(
                          physics: AlwaysScrollableScrollPhysics(),
                          child: Center(
                            child: Form(
                              key: productProvider.sendRequestFormKey,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        .02,
                                  ),
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width * .7,
                                    child: TextFormField(
                                      controller: productProvider.productName,
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
                                        value =
                                            productProvider.productName.text;
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
                                    height: MediaQuery.of(context).size.height *
                                        .02,
                                  ),
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width * .7,
                                    child: TextFormField(
                                      controller: productProvider.country,
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
                                        value = productProvider.country.text;
                                        if (value.isEmpty) {
                                          return "هذا الحقل مطلوب";
                                        } else {
                                          return null;
                                        }
                                      },
                                    ),
                                  ),
                                  SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        .02,
                                  ),
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width * .7,
                                    // height: MediaQuery.of(context).size.height * 0.06,
                                    child: TextFormField(
                                      controller: productProvider.city,
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
                                        value = productProvider.city.text;
                                        if (value.isEmpty) {
                                          return "هذا الحقل مطلوب";
                                        } else {
                                          return null;
                                        }
                                      },
                                    ),
                                  ),
                                  SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        .02,
                                  ),
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width * .7,
                                    child: TextFormField(
                                      controller: productProvider.address,
                                      style: TextStyle(height: 1),
                                      keyboardType: TextInputType.text,
                                      cursorColor: kTeal400,
                                      decoration: InputDecoration(
                                        labelText: 'العنوان',
                                        hintText: '',
                                        fillColor: Colors.white,
                                      ),
                                      validator: (value) {
                                        value = productProvider.address.text;
                                        if (value.isEmpty) {
                                          return "هذا الحقل مطلوب";
                                        } else {
                                          return null;
                                        }
                                      },
                                    ),
                                  ),
                                  SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        .02,
                                  ),
                                  DropdownButton<dynamic>(
                                    hint: Text(catProvider.addProhintList),
                                    items: catProvider.loadedItems.map((e) {
                                      return DropdownMenuItem(
                                        child: Text(e.name!),
                                        value: e,
                                      );
                                    }).toList(),
                                    onChanged: (val) {
                                      catProvider.changeHint(val);
                                    },
                                  ),
                                  SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        .02,
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
                                    width:
                                        MediaQuery.of(context).size.width * .7,
                                    height: MediaQuery.of(context).size.height *
                                        0.15,
                                    child: TextFormField(
                                      controller:
                                          productProvider.productDescription,
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
                                        value = productProvider
                                            .productDescription.text;
                                        if (value.isEmpty) {
                                          return "هذا الحقل مطلوب";
                                        } else {
                                          return null;
                                        }
                                      },
                                    ),
                                  ),
                                  SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        .02,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      TextButton.icon(
                                        onPressed: _selectOnMap,
                                        icon: Icon(
                                          Icons.pin_drop_rounded,
                                          color: _pickedLocation == null
                                              ? Colors.red
                                              : Colors.green,
                                        ),
                                        label: _pickedLocation == null
                                            ? Text(
                                                'حدّد موقعك على الخريطة',
                                                style: TextStyle(
                                                    color: Colors.blue),
                                              )
                                            : Text('تم تحديد الموقع '),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        .02,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      IconButton(
                                          onPressed: uploadImage,
                                          icon: Icon(
                                            Icons.add_a_photo_outlined,
                                            color: kTeal400,
                                          )),
                                      Text(
                                        'أضف صورة للمنتج',
                                        style: TextStyle(color: kTeal400),
                                      ),
                                    ],
                                  ),
                                  Container(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        image == null
                                            ? Text(
                                                'لا يوجد صورة',
                                                style: TextStyle(
                                                    color: Colors.grey),
                                              )
                                            : Container(
                                                child: Image.file(
                                                image!,
                                                fit: BoxFit.cover,
                                              ))
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height:
                                        MediaQuery.of(context).size.height * .1,
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
                                          offset: Offset(0,
                                              1), // changes position of shadow
                                        ),
                                      ],
                                    ),
                                    width:
                                        MediaQuery.of(context).size.width * .7,
                                    height: MediaQuery.of(context).size.height *
                                        .06,
                                    child: ElevatedButton(
                                      child: Text("نشر",
                                          style: TextStyle(
                                            color: kGrey200,
                                            fontSize: 20,
                                          )),
                                      onPressed: () async {
                                        if (productProvider
                                            .sendRequestFormKey.currentState!
                                            .validate()) {
                                          print("ready for send request ");
                                          print("add product request start ");
                                          await productProvider
                                              .addProduct(image);
                                          if (productProvider.statusCodeSend ==
                                              200) {
                                            AwesomeDialog(
                                              context: context,
                                              animType: AnimType.TOPSLIDE,
                                              dialogType: DialogType.SUCCES,
                                              title: "تمت العملية",
                                              body: Directionality(
                                                textDirection:
                                                    TextDirection.rtl,
                                                child: Container(
                                                  padding: EdgeInsets.all(8),
                                                  alignment: Alignment.center,
                                                  child: Text(
                                                    "تم اضافة طلب بنجاح",
                                                    style: TextStyle(
                                                      color: Colors.grey,
                                                      fontSize: 22,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              btnOkColor: Colors.red,
                                              btnOkOnPress: () {},
                                            ).show();
                                          }

                                          if (productProvider.statusCodeSend ==
                                              500) {
                                            AwesomeDialog(
                                              context: context,
                                              animType: AnimType.TOPSLIDE,
                                              dialogType: DialogType.ERROR,
                                              title: "فشل العملية",
                                              body: Directionality(
                                                textDirection:
                                                    TextDirection.rtl,
                                                child: Container(
                                                  padding: EdgeInsets.all(8),
                                                  alignment: Alignment.center,
                                                  child: Text(
                                                    "تم العملية بنجاح سوف تظهر رسالتك في الصندوق الوارد",
                                                    style: TextStyle(
                                                      color: Colors.grey,
                                                      fontSize: 22,
                                                      fontWeight:
                                                          FontWeight.bold,
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
                                  SizedBox(
                                    height: height * 0.06,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                )),
      ),
    );
  }
}

import 'package:flutter/material.dart';

import '../theme/colors.dart';

class ProductDetailScreen extends StatelessWidget {
  static const routeName = '/product-detail';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kTeal400,
        title: Text(' لابتوب'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height * .5,
              width: double.infinity,
              child: Image.asset(
                "assets/images/4.jpg",
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * .01,
            ),
            Text(
              'High specification lapTop',
              style: TextStyle(color: kTeal400, fontSize: 15),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * .01,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              width: double.infinity,
              child: Text(
                'تاريخ النشر :2-2-2022',
                textAlign: TextAlign.center,
                softWrap: true,
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * .01,
            ),
            Text(
              'مباع',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 20,
              ),
            ),
            Divider(),
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
              ),
              width: MediaQuery.of(context).size.width * .7,
              height: MediaQuery.of(context).size.height * 0.1,
              child: TextFormField(
                style: TextStyle(height: 1),
                keyboardType: TextInputType.multiline,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: const BorderRadius.all(
                      const Radius.circular(10.0),
                    ),
                  ),
                  labelText: 'لماذا تحتاج لهذا المنتج ',
                  hintText: '',
                  fillColor: Colors.white,
                  focusColor: Colors.white,
                  filled: true,
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return " هذا الحقل مطلوب";
                  } else {
                    return null;
                  }
                },
              ),
            ),
            ElevatedButton(
              child: Text(
                "طلب",
                style: TextStyle(color: kTeal400),
              ),
              onPressed: () {
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(
                      "تم الطلب",
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1!
                          .copyWith(fontSize: 14, color: kTeal400),
                    ),
                    action: SnackBarAction(
                        label: "الغاء",
                        textColor: Colors.white,
                        onPressed: () {})));
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                minimumSize: const Size(100, 30),
                maximumSize: const Size(100, 30),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

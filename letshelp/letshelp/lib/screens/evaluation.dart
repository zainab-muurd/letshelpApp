import 'package:flutter/material.dart';
import 'package:letshelp/provider/product.dart';
import 'package:letshelp/theme/colors.dart';
import 'package:provider/provider.dart';

class Evaluation extends StatefulWidget {
  const Evaluation({Key? key}) : super(key: key);

  @override
  State<Evaluation> createState() => _EvaluationState();
}

class _EvaluationState extends State<Evaluation> {
  TextEditingController comment = new TextEditingController();

  @override
  void initState() {
    super.initState();

    comment.addListener(_printLatestValue);
  }

  @override
  void dispose() {
    comment.dispose();

    super.dispose();
  }

  void _printLatestValue() {
    print('please Enter your Name: ${comment.text}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'تقييم',
            style: TextStyle(
                color: kTeal400, fontWeight: FontWeight.bold, fontSize: 25),
          ),
          backgroundColor: Colors.white,
        ),
        body: SingleChildScrollView(
          child: Container(
              color: kTeal400,
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Stack(children: [
                Positioned(
                    top: MediaQuery.of(context).size.height * .07,
                    right: MediaQuery.of(context).size.width * .1,
                    child: Container(
                      height: MediaQuery.of(context).size.height * .75,
                      width: MediaQuery.of(context).size.width * .8,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: const BorderRadius.only(
                            bottomRight: Radius.circular(100),
                            topLeft: Radius.circular(100),
                          )),
                      child: const Icon(
                        Icons.add,
                        color: Colors.white,
                      ),
                    )),
                Positioned(
                  top: MediaQuery.of(context).size.height * .1,
                  left: MediaQuery.of(context).size.width * .33,
                  child: Column(
                    children: [
                      ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: Image.asset("assets/images/logo.png",
                              height: MediaQuery.of(context).size.height * .155,
                              width: MediaQuery.of(context).size.width * 0.3)),
                      Text(
                        "فلنتساعد ",
                        style: TextStyle(
                            color: kTeal400, fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
                Positioned(
                    top: MediaQuery.of(context).size.height * .28,
                    left: MediaQuery.of(context).size.width * .26,
                    child: Text(
                      "الرجاء تقييم خدماتنا  ",
                      style: TextStyle(
                          color: kTeal400,
                          fontWeight: FontWeight.bold,
                          fontSize: 25),
                    )),
                Positioned(
                    top: MediaQuery.of(context).size.height * .37,
                    left: MediaQuery.of(context).size.width * .2,
                    child: Row(
                      children: [
                        Consumer<Product>(
                          builder: (ctx, product, _) => IconButton(
                            icon: Icon(
                              product.isStar ? Icons.star : Icons.star_border,
                              color: Colors.yellow,
                              size: 30,
                            ),
                            onPressed: () {
                              product.toggleStarStatus();
                            },
                          ),
                        ),
                        Consumer<Product>(
                          builder: (ctx, product, _) => IconButton(
                            onPressed: () {
                              product.toggleStarStatus();
                            },
                            icon: Icon(
                              product.isStar ? Icons.star : Icons.star_border,
                              color: Colors.yellow,
                              size: 30,
                            ),
                          ),
                        ),
                        Consumer<Product>(
                          builder: (ctx, product, _) => IconButton(
                            onPressed: () {
                              product.toggleStarStatus();
                            },
                            icon: Icon(
                              product.isStar ? Icons.star : Icons.star_border,
                              color: Colors.yellow,
                              size: 30,
                            ),
                          ),
                        ),
                        Consumer<Product>(
                          builder: (ctx, product, _) => IconButton(
                            onPressed: () {
                              product.toggleStarStatus();
                            },
                            icon: Icon(
                              product.isStar ? Icons.star : Icons.star_border,
                              color: Colors.yellow,
                              size: 30,
                            ),
                          ),
                        ),
                        Consumer<Product>(
                          builder: (ctx, product, _) => IconButton(
                            onPressed: () {
                              product.toggleStarStatus();
                            },
                            icon: Icon(
                              product.isStar ? Icons.star : Icons.star_border,
                              color: Colors.yellow,
                              size: 30,
                            ),
                          ),
                        ),
                      ],
                    )),
                Positioned(
                  top: MediaQuery.of(context).size.height * .5,
                  left: MediaQuery.of(context).size.width * .19,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(50),
                        topLeft: Radius.circular(50),
                      ),
                    ),
                    width: MediaQuery.of(context).size.width * .65,
                    height: MediaQuery.of(context).size.height * 3,
                    child: TextFormField(
                      controller: comment,
                      style: TextStyle(height: 3),
                      keyboardType: TextInputType.multiline,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: const BorderRadius.only(
                            bottomRight: Radius.circular(30),
                            topLeft: Radius.circular(30),
                          ),
                        ),
                        labelText: 'أكتب تعليقا',
                        hintText: '',
                        fillColor: Colors.white,
                        filled: true,
                      ),
                      validator: (value) {
                        value = comment as String?;
                        if (value!.isEmpty) {
                          return " هذا الحقل مطلوب ";
                        } else {
                          return null;
                        }
                      },
                    ),
                  ),
                ),
                Positioned(
                  top: MediaQuery.of(context).size.height * .68,
                  left: MediaQuery.of(context).size.width * .17,
                  child: Container(
                    height: MediaQuery.of(context).size.height * .1,
                    width: MediaQuery.of(context).size.width * .65,
                    decoration: BoxDecoration(
                        color: kTeal400,
                        borderRadius: const BorderRadius.only(
                          bottomRight: Radius.circular(100),
                          topLeft: Radius.circular(100),
                        )),
                    child: Center(
                        child: TextButton(
                      onPressed: () {
                        ScaffoldMessenger.of(context).hideCurrentSnackBar();
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text(
                              "تم إرسال تعليقك ",
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
                      child: Text("تقييم",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20)),
                    )),
                  ),
                ),
              ])),
        ));
  }
}

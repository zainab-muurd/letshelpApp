import 'package:flutter/material.dart';
import '../theme/colors.dart';

class Connect extends StatefulWidget {
  const Connect({Key? key}) : super(key: key);

  @override
  State<Connect> createState() => _ConnectState();
}

class _ConnectState extends State<Connect> {
  TextEditingController name = new TextEditingController();
  TextEditingController email = new TextEditingController();
  TextEditingController subject = new TextEditingController();
  TextEditingController message = new TextEditingController();

  @override
  void initState() {
    super.initState();
    name.addListener(_printLatestValue);
    email.addListener(_printLatestValue);
    subject.addListener(_printLatestValue);
    message.addListener(_printLatestValue);
  }

  @override
  void dispose() {
    name.dispose();
    email.dispose();
    subject.dispose();
    message.dispose();

    super.dispose();
  }

  void _printLatestValue() {
    print('please Enter your name: ${name.text}');
    print('please Enter your email: ${email.text}');
    print('please Enter subject of message: ${subject.text}');
    print('please Enter your message: ${message.text}');
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
          appBar: AppBar(
              backgroundColor: kTeal400,
              title: Text(
                "تواصل معنا  ",
                style: TextStyle(color: Colors.white, fontSize: 20),
              )),
          body: SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(),
            child: Column(children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * .05,
              ),

              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: kGrey501,

                                spreadRadius: 1,

                                blurRadius: 1,

                                offset:
                                    Offset(0, 1), // changes position of shadow
                              ),
                            ],
                          ),
                          width: MediaQuery.of(context).size.width * .2,
                          height: MediaQuery.of(context).size.height * .1,
                          child: Icon(
                            Icons.pin_drop_rounded,
                            color: kTeal400,
                          )),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * .02,
                      ),
                      Text(
                        ' كل مكان',
                        style: TextStyle(color: kTeal400),
                      )
                    ],
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * .07,
                  ),
                  Column(
                    children: [
                      Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: kGrey501,

                                spreadRadius: 1,

                                blurRadius: 1,

                                offset:
                                    Offset(0, 1), // changes position of shadow
                              ),
                            ],
                          ),
                          width: MediaQuery.of(context).size.width * .2,
                          height: MediaQuery.of(context).size.height * .1,
                          child: Icon(
                            Icons.message,
                            color: kTeal400,
                          )),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * .02,
                      ),
                      Text(
                        'info@example.com',
                        style: TextStyle(color: kTeal400),
                      )
                    ],
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * .07,
                  ),
                  Column(
                    children: [
                      Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: kGrey501,

                                spreadRadius: 1,

                                blurRadius: 1,

                                offset:
                                    Offset(0, 1), // changes position of shadow
                              ),
                            ],
                          ),
                          width: MediaQuery.of(context).size.width * .2,
                          height: MediaQuery.of(context).size.height * .1,
                          child: Icon(
                            Icons.phone,
                            color: kTeal400,
                          )),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * .02,
                      ),
                      Text(
                        '0123456789',
                        style: TextStyle(color: kTeal400),
                      )
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * .05,
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
                      color: Colors.white60,
                      spreadRadius: 1,
                      blurRadius: 1,
                      offset: Offset(0, 1), // changes position of shadow
                    ),
                  ],
                ),
                width: MediaQuery.of(context).size.width * .7,
                height: MediaQuery.of(context).size.height * 0.06,
                child: TextFormField(
                  controller: name,
                  style: TextStyle(height: 1),
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: const BorderRadius.all(
                        const Radius.circular(10.0),
                      ),
                    ),
                    labelText: 'الإسم ',
                    hintText: '',
                    fillColor: Colors.white,
                    filled: true,
                  ),
                  validator: (value) {
                    value = name as String?;
                    if (value!.isEmpty) {
                      return "هذا الحلق مطلوب";
                    } else {
                      return null;
                    }
                  },
                  onSaved: (value) {},
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * .03,
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
                      color: Colors.white60,
                      spreadRadius: 1,
                      blurRadius: 1,
                      offset: Offset(0, 1), // changes position of shadow
                    ),
                  ],
                ),
                width: MediaQuery.of(context).size.width * .7,
                height: MediaQuery.of(context).size.height * 0.06,
                child: TextFormField(
                  controller: email,
                  style: TextStyle(height: 1),
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: const BorderRadius.all(
                        const Radius.circular(10.0),
                      ),
                    ),
                    labelText: 'البريد الإلكتروني',
                    hintText: '',
                    fillColor: Colors.white,
                    filled: true,
                  ),
                  validator: (value) {
                    value = email as String?;
                    if (value!.isEmpty) {
                      return " هذا الحلقل مطلوب ";
                    } else {
                      return null;
                    }
                  },
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * .03,
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
                      color: Colors.white60,
                      spreadRadius: 1,
                      blurRadius: 1,
                      offset: Offset(0, 1), // changes position of shadow
                    ),
                  ],
                ),
                width: MediaQuery.of(context).size.width * .7,
                height: MediaQuery.of(context).size.height * 0.06,
                child: TextFormField(
                  controller: subject,
                  style: TextStyle(height: 1),
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: const BorderRadius.all(
                        const Radius.circular(10.0),
                      ),
                    ),
                    labelText: 'الموضوع',
                    hintText: '',
                    fillColor: Colors.white,
                    filled: true,
                  ),
                  validator: (value) {
                    value = subject as String?;
                    if (value!.isEmpty) {
                      return "هذا الحقل مطلوب";
                    }
                    return null;
                  },
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * .03,
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
                      color: Colors.white60,
                      spreadRadius: 1,
                      blurRadius: 1,
                      offset: Offset(0, 1), // changes position of shadow
                    ),
                  ],
                ),
                width: MediaQuery.of(context).size.width * .7,
                height: MediaQuery.of(context).size.height * 0.15,
                child: TextFormField(
                  controller: message,
                  style: TextStyle(height: 3),
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: const BorderRadius.all(
                        const Radius.circular(
                          10.0,
                        ),
                      ),
                    ),
                    labelText: 'الرسالة',
                    hintText: '',
                    fillColor: Colors.white,
                    filled: true,
                  ),
                  validator: (value) {
                    value = message as String?;
                    if (value!.isEmpty) {
                      return "هذا الحلق مطلوب";
                    } else {
                      return null;
                    }
                  },
                  onSaved: (value) {},
                ),
              ),
              // SizedBox(
              //   height: MediaQuery.of(context)
              //           .size
              //           .height *
              //       .01,
              // ),
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
                      offset: Offset(0, 1), // changes position of shadow
                    ),
                  ],
                ),
                width: MediaQuery.of(context).size.width * .3,
                height: MediaQuery.of(context).size.height * .06,
                child: ElevatedButton(
                  child: Text(
                    "إرسال رسالة",
                    style: TextStyle(color: kGrey200),
                  ),
                  onPressed: () {
                    ScaffoldMessenger.of(context).hideCurrentSnackBar();
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text(
                          "تم إرسال رسالتك ",
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
                    backgroundColor: kTeal400,
                    minimumSize: const Size(300, 75),
                    maximumSize: const Size(300, 75),
                  ),
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * .05),

              Divider(),

              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.whatsapp_rounded,
                            color: Colors.green,
                          ),
                          Text('0938752924')
                        ],
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * .1,
                      ),
                      Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              ;
                            },
                            icon: Icon(
                              Icons.facebook,
                              color: Colors.blue,
                            ),
                          ),
                          Text('Anas_tad')
                        ],
                      ),
                    ],
                  ),
                ],
              )
            ]),
          )),
    );
  }
}

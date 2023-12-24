import 'package:flutter/material.dart';
import 'package:letshelp/provider/messagesp_povider.dart';
import 'package:letshelp/provider/order-provider.dart';
import 'package:letshelp/provider/profile-provider.dart';
import 'package:letshelp/screens/Availablematerials.dart';
import 'package:letshelp/screens/add-order.dart';
import 'package:letshelp/screens/all-orders.dart';
import 'package:letshelp/screens/evaluation.dart';
import 'package:letshelp/screens/homescreene.dart';
import 'package:letshelp/screens/profile.dart';
import 'package:letshelp/utils/user_type_enums.dart';
import 'package:provider/provider.dart';
import '../provider/auth_provider.dart';
import '../screens/connect.dart';
import '../screens/login.dart';
import '../theme/colors.dart';

class AppDrawer extends StatefulWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  _AppDrawerState createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  @override
  Widget build(BuildContext context) {
    return Consumer<Auth>(
        builder: (context, auth, _) => SafeArea(
            top: true,
            child: Theme(
              data: Theme.of(context).copyWith(
                canvasColor: Colors
                    .white, //This will change the drawer background to blue.
                //other styles
              ),
              child: Drawer(
                  // backgroundColor: Color.fromRGBO(102, 44, 144, 1),
                  child: SingleChildScrollView(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * .03,
                      ),
                      Row(
                        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width * .05,
                          ),
                          Text(
                            "فلنتساعد ...",
                            style: TextStyle(
                                color: kTeal400,
                                fontWeight: FontWeight.bold,
                                fontSize: 30),
                          )
                        ],
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * .03,
                      ),
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        child: Divider(
                          color: kGrey400,
                          height: 1,
                        ),
                      ),
                      Container(
                          child: Column(
                        children: <Widget>[
                          ListTile(
                            leading: Icon(
                              Icons.home,
                              color: kTeal400,
                            ),
                            title: Text(
                              'الصفحة الرئيسية',
                              style: TextStyle(
                                color: Colors.black,
                              ),
                            ),
                            onTap: () {
                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => HomeScreen()),
                                ModalRoute.withName('/'),
                              );
                            },
                          ),
                          Visibility(
                              visible: !(auth.user.userType == UserType.guest),
                              child: Divider()),
                          Visibility(
                            visible: !(auth.user.userType == UserType.guest),
                            child: Consumer<ProfileProvider>(
                              builder: (context, profileProvider, _) =>
                                  ListTile(
                                leading: Icon(
                                  Icons.person,
                                  color: kTeal400,
                                ),
                                title: Text(
                                  'الملف الشخصي',
                                  style: TextStyle(
                                    color: Colors.black,
                                  ),
                                ),
                                onTap: () async {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Profile()),
                                  );
                                  // await profileProvider.getProvider();
                                },
                              ),
                            ),
                          ),
                          Visibility(
                              visible: !(auth.user.userType == UserType.guest),
                              child: Divider()),
                          Visibility(
                            visible: !(auth.user.userType == UserType.guest),
                            child: Consumer<ProfileProvider>(
                              builder: (context, profileProvider, _) =>
                                  ListTile(
                                leading: Icon(
                                  Icons.add_outlined,
                                  color: kTeal400,
                                ),
                                title: Text(
                                  'إضافة طلب',
                                  style: TextStyle(
                                    color: Colors.black,
                                  ),
                                ),
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => AddNewOrder()),
                                  );
                                  // await profileProvider.getProvider();
                                },
                              ),
                            ),
                          ),
                          Divider(),
                          Consumer<OrderProvider>(
                            builder: (context, orderProvider, _) => ListTile(
                              leading: Icon(
                                Icons.reorder,
                                color: kTeal400,
                              ),
                              title: Text(
                                'الطلبات',
                                style: TextStyle(
                                  color: Colors.black,
                                ),
                              ),
                              onTap: () async {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => AllOrders()));
                                await orderProvider.getAllOrders();
                              },
                            ),
                          ),
                          Divider(),
                          ListTile(
                            leading: Icon(
                              Icons.menu_book_outlined,
                              color: kTeal400,
                            ),
                            title: Text(
                              'المواد المتاحة',
                              style: TextStyle(
                                color: Colors.black,
                              ),
                            ),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => AvailableMaterials()),
                              );
                            },
                          ),
                          Divider(),
                          ListTile(
                            leading: Icon(
                              Icons.person,
                              color: kTeal400,
                            ),
                            title: Text(
                              'تواصل معنا',
                              style: TextStyle(
                                color: Colors.black,
                              ),
                            ),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Connect()),
                              );
                            },
                          ),
                          Divider(),
                          ListTile(
                            leading: Icon(
                              Icons.star,
                              color: kTeal400,
                            ),
                            title: Text(
                              'تقييم',
                              style: TextStyle(
                                color: Colors.black,
                              ),
                            ),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Evaluation()),
                              );
                            },
                          ),
                          Divider(),
                          Consumer<Auth>(
                            builder: (context, authProvider, _) =>
                                Consumer<MessagesProvider>(
                              builder: (context, messageProvider, _) =>
                                  ListTile(
                                leading: Icon(
                                  Icons.power_settings_new_sharp,
                                  color: kTeal400,
                                ),
                                title: Text(
                                  'تسجيل خروج',
                                  style: TextStyle(
                                    color: Colors.black,
                                  ),
                                ),
                                onTap: () async {
                                  if (messageProvider.isTimerOn!) {
                                    messageProvider.timerFotSingleConversation!
                                        .cancel();
                                  }

                                  Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Login()),
                                      (route) => false);
                                  await authProvider.logOut();
                                },
                              ),
                            ),
                          ),
                        ],
                      )),
                    ]),
              )),
            )));
  }
}

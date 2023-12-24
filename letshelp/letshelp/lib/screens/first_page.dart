import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:letshelp/provider/categories_provider.dart';
import 'package:letshelp/provider/home_screen_provider.dart';
import 'package:letshelp/provider/messagesp_povider.dart';
import 'package:letshelp/provider/notification_provider.dart';
import 'package:letshelp/provider/order-provider.dart';
import 'package:letshelp/provider/profile-provider.dart';
import 'package:letshelp/screens/add-order.dart';
import 'package:letshelp/screens/addnewprodact.dart';
import 'package:letshelp/screens/homescreene.dart';
import 'package:letshelp/screens/lets_help_blog.dart';
import 'package:letshelp/screens/notifications_screen.dart';
import 'package:letshelp/screens/privatmessag.dart';
import 'package:letshelp/screens/profile.dart';
import 'package:letshelp/utils/user_type_enums.dart';
import 'package:letshelp/widgets/home_screen_widget.dart';
import 'package:provider/provider.dart';
import '../provider/auth_provider.dart';
import '../theme/colors.dart';
import '../widgets/app_drawer.dart';
import 'all-orders.dart';
import 'connect.dart';
import 'lest_help_common_questions.dart';
import 'lets_help_forum.dart';

class FirstPage extends StatelessWidget {
  const FirstPage({Key? key}) : super(key: key);
  final bool showAwesom = false;

  @override
  Widget build(BuildContext context) {
    return Consumer<Auth>(
      builder: (context, auth, _) => Directionality(
          textDirection: TextDirection.rtl,
          child: Scaffold(
              drawer: AppDrawer(),
              bottomNavigationBar: auth.user.userType != UserType.guest
                  ? BottomNavigationBar(
                      onTap: (value) async {
                        print("$value page");
                        if (value == 0) {
                          return;
                        } else if (value == 1) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => NotificationScreen()));
                          await Provider.of<NotificationProv>(context,
                                  listen: false)
                              .getAllNotifications();
                        } else if (value == 2) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => goToAddNewProduct()));
                          await Provider.of<CategoriesProvider>(context,
                                  listen: false)
                              .getCategories();
                        } else if (value == 3) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => PrivatMessage()),
                          );
                          await Provider.of<MessagesProvider>(context,
                                  listen: false)
                              .getAllMessages();
                        } else if (value == 4) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Profile()),
                          );
                          await Provider.of<ProfileProvider>(context,
                                  listen: false)
                              .getMyProfile();
                        } else if (value == 5) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => HomeScreen(),
                            ),
                          );
                        }
                      },
                      items: [
                        BottomNavigationBarItem(
                            icon: Icon(
                              Icons.home_outlined,
                              size: 25,
                              color: kTeal400,
                            ),
                            label: ""),
                        BottomNavigationBarItem(
                            icon: Icon(
                              Icons.notifications_active_outlined,
                              size: 25,
                              color: kTeal400,
                            ),
                            label: ""),
                        BottomNavigationBarItem(
                            icon: Icon(
                              Icons.add_circle,
                              size: 39,
                              color: kTeal400,
                            ),
                            label: ""),
                        BottomNavigationBarItem(
                            icon: Icon(
                              Icons.message_sharp,
                              size: 25,
                              color: kTeal400,
                            ),
                            label: ""),
                        BottomNavigationBarItem(
                            icon: Icon(
                              Icons.person_outline,
                              size: 25,
                              color: kTeal400,
                            ),
                            label: ""),
                        BottomNavigationBarItem(
                            icon: Icon(
                              Icons.shopping_cart,
                              size: 25,
                              color: kTeal400,
                            ),
                            label: ""),
                      ],
                    )
                  : null,
              appBar: AppBar(
                backgroundColor: kTeal400,
                elevation: 3.0,
                centerTitle: true,
                title: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    '...فلنتساعد',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                ),
              ),
              body: GridView(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, childAspectRatio: 7.5 / 7),
                children: [
                  HomeScreenWidget(
                    icon: Icons.card_giftcard,
                    text: "احتاج الى",
                    onTpa: () {
                      if (auth.user.userType == UserType.guest) {
                        AwesomeDialog(
                          context: context,
                          dialogType: DialogType.NO_HEADER,
                          btnCancelText: "إغلاق",
                          btnCancelOnPress: () {},
                          body: Directionality(
                            textDirection: TextDirection.rtl,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 30.0, horizontal: 15),
                              child: Container(
                                child: Text(
                                  "الرجاء تسجيل الدخول لطلب عنصر",
                                  style: TextStyle(
                                    color: kTeal400,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ).show();
                      } else {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AddNewOrder()),
                        );
                      }
                    },
                  ),
                  HomeScreenWidget(
                    icon: Icons.favorite_border_outlined,
                    text: "لا أحتاج الى",
                    onTpa: () async {
                      if (auth.user.userType == UserType.guest) {
                        AwesomeDialog(
                          context: context,
                          dialogType: DialogType.NO_HEADER,
                          btnCancelText: "إغلاق",
                          btnCancelOnPress: () {},
                          body: Directionality(
                            textDirection: TextDirection.rtl,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 30.0, horizontal: 15),
                              child: Container(
                                child: Text(
                                  "الرجاء تسجيل الدخول لطلب عنصر",
                                  style: TextStyle(
                                    color: kTeal400,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ).show();
                      } else {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => goToAddNewProduct()));
                        await Provider.of<CategoriesProvider>(context,
                                listen: false)
                            .getCategories();
                      }
                    },
                  ),
                  Consumer<OrderProvider>(
                    builder: (context, orderProvider, _) => HomeScreenWidget(
                      icon: Icons.accessibility,
                      text: "المواد المطلوبة",
                      onTpa: () async {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AllOrders()));
                        await orderProvider.getAllOrders();
                      },
                    ),
                  ),
                  HomeScreenWidget(
                    icon: Icons.recycling,
                    text: "المواد المتاحة",
                    onTpa: () async {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => HomeScreen()),
                      );
                      var homeProvider = Provider.of<HomeScreenProvider>(
                          context,
                          listen: false);
                      homeProvider.isFirstTime = true;
                      homeProvider.cateId = 0;
                      await homeProvider.getitemsavailable(page: 1);
                      await Provider.of<CategoriesProvider>(context,
                              listen: false)
                          .getCategories();
                    },
                  ),
                  HomeScreenWidget(
                    icon: Icons.groups,
                    text: " المنتدى",
                    onTpa: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LestHelpForum(),
                        ),
                      );
                    },
                  ),
                  HomeScreenWidget(
                    icon: Icons.ads_click,
                    text: "المدونة",
                    onTpa: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LetsHelpBlog(),
                        ),
                      );
                    },
                  ),
                  HomeScreenWidget(
                    icon: Icons.call_sharp,
                    text: " توصل معنا ",
                    onTpa: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Connect()));
                    },
                  ),
                  HomeScreenWidget(
                    icon: Icons.wechat,
                    text: "الاسئلة الشائعة  ",
                    onTpa: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LetsHelpCommonQuestions()));
                    },
                  ),
                ],
              ))),
    );
  }
}

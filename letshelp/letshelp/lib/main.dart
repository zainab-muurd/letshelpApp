import 'package:flutter/material.dart';
import 'package:letshelp/models/avilibal_items_model.dart';
import 'package:letshelp/models/show_items_mpdels.dart';
import 'package:letshelp/provider/Images.dart';
import 'package:letshelp/provider/auth_provider.dart';
import 'package:letshelp/provider/categories_provider.dart';
import 'package:letshelp/provider/home_screen_provider.dart';
import 'package:letshelp/provider/itemavelbl_provider.dart';
import 'package:letshelp/provider/map_provider.dart';
import 'package:letshelp/provider/messagesp_povider.dart';
import 'package:letshelp/provider/notification_provider.dart';
import 'package:letshelp/provider/order-provider.dart';
import 'package:letshelp/provider/product.dart';
import 'package:letshelp/provider/profile-provider.dart';
import 'package:letshelp/provider/show_items_provider.dart';
import 'package:letshelp/screens/complete_profile.dart';
import 'package:letshelp/screens/first_page.dart';
import 'package:letshelp/screens/login.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';

import 'utils/user_type_enums.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (_) => Auth()..loadTokenFromPrefs(),
          ),
          ChangeNotifierProvider(
            create: (_) => Product(
                id: "",
                title: "",
                description: "",
                stat: 0.0,
                isStar: false,
                image: ''),
          ),
          ChangeNotifierProvider(
            create: (_) => CategoriesProvider(),
          ),
          ChangeNotifierProvider.value(
            value: ProfileProvider(),
          ),
          ChangeNotifierProvider(
            create: (_) => HomeScreenProvider(),
          ),
          ChangeNotifierProvider(
            create: (_) => OrderProvider(),
          ),
          ChangeNotifierProvider(create: (_) => MapProvider()),
          ChangeNotifierProvider(
            create: (_) => ImagesToUpload(),
          ),
          ChangeNotifierProvider(
            create: (_) => MessagesProvider(),
          ),
          ChangeNotifierProvider(create: (_) => NotificationProv()),
          ChangeNotifierProvider(create: (_) => ItemAvailableProvider()),
          ChangeNotifierProvider(create: (_) => ItemAvailableProvider()),

          // Provider.value(value: AvilbaleItemsModel()),
          ChangeNotifierProvider(create: (_) => ShowItemsProvider()),

          // ChangeNotifierProvider.value(
          //   value: ShowItemsProvider(),
          // ),

          // Provider.value(value: ShowItemModel()),
        ],
        child: Consumer<Auth>(
          builder: (context, authProvider, _) => MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Lets Help',
            theme: ThemeData(
              fontFamily: 'Lato',
            ),
            home: authProvider.token != null &&
                    authProvider.user.userType == UserType.user
                ? FirstPage()
                : authProvider.user.userType == UserType.needCompleteProfile
                    ? CompleteProfile()
                    : Login(),
          ),
        ));
  }
}

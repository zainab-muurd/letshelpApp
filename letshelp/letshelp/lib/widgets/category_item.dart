import 'package:flutter/material.dart';
import 'package:letshelp/models/categories.dart';
import 'package:letshelp/provider/home_screen_provider.dart';
import 'package:letshelp/theme/colors.dart';

class CategoryItem extends StatelessWidget {
  const CategoryItem(
      {Key? key, required this.categoryModel, required this.homeScreenProvider})
      : super(key: key);
  final Categories categoryModel;
  final HomeScreenProvider homeScreenProvider;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        homeScreenProvider.cateId = categoryModel.id!;
        homeScreenProvider.items!.clear();
        await homeScreenProvider.getitemsavailable();
      },
      child: Card(
        color: kLightBG,
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(15),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
              child: Column(
            children: [
              Expanded(
                flex: 2,
                child: categoryModel.icon == null
                    ? Icon(
                        Icons.category,
                        size: 50,
                        color: kTeal400,
                      )
                    : Image.network("${categoryModel.icon}"),
              ),
              Expanded(
                  flex: 1,
                  child: Text(
                    "${categoryModel.name}",
                    style: TextStyle(
                      color: kTeal400,
                      fontWeight: FontWeight.bold,
                    ),
                  )),
            ],
          )),
        ),
      ),
    );
  }
}

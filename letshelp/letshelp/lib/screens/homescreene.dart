import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:letshelp/provider/categories_provider.dart';
import 'package:letshelp/provider/home_screen_provider.dart';
import 'package:letshelp/provider/product.dart';
import 'package:letshelp/widgets/category_item.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../theme/colors.dart';
import '../widgets/app_drawer.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);
  int page = 1;
  RefreshController? refreshController =
      RefreshController(initialRefresh: false);
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: kTeal400,
          elevation: 3.0,
          title: Text(
            'فلنتساعد ',
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
          ),
          centerTitle: true,
          actions: [
            Consumer<HomeScreenProvider>(
              builder: (context, hSP, _) => Consumer<CategoriesProvider>(
                builder: (context, categoryProv, _) => TextButton.icon(
                  label: Text(
                    "بحث",
                    style: TextStyle(color: Colors.white),
                  ),
                  icon: Icon(
                    Icons.search,
                    color: Colors.white,
                  ),
                  onPressed: () async {
                    await categoryProv.getCategories().then((value) {
                      AwesomeDialog(
                        context: context,
                        dialogType: DialogType.NO_HEADER,
                        btnOkText: "ابحث",
                        btnCancelText: "رجوع",
                        btnOkColor: kTeal400,
                        btnCancelColor: Colors.grey,
                        btnOkOnPress: () async {
                          await hSP.filterProduct();
                        },
                        btnCancelOnPress: () {},
                        body: Directionality(
                          textDirection: TextDirection.rtl,
                          child: Consumer<HomeScreenProvider>(
                            builder: (context, homeScreenP, _) =>
                                Directionality(
                              textDirection: TextDirection.rtl,
                              child: Consumer<Product>(
                                builder: (context, productProvider, _) =>
                                    Consumer<CategoriesProvider>(
                                  builder: (context, value, _) => Container(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 8.0),
                                    child: Column(
                                      children: [
                                        Center(
                                          child: Text(
                                              "لايتوجب عليك ملأ كل الخيارات",
                                              style: TextStyle(
                                                  color: kTeal400,
                                                  fontWeight: FontWeight.bold)),
                                        ),
                                        SizedBox(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              .02,
                                        ),
                                        TextFormField(
                                            controller: homeScreenP.country,
                                            maxLines: null,
                                            decoration: InputDecoration(
                                              labelText: "اختر الدولة ",
                                              labelStyle: TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.black),
                                              fillColor: Colors.white,
                                              focusedBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                borderSide: BorderSide(
                                                  color: kTeal400,
                                                  width: 2.0,
                                                ),
                                              ),
                                              enabledBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                borderSide: BorderSide(
                                                  color: kTeal400,
                                                  width: 2.0,
                                                ),
                                              ),
                                            )),
                                        SizedBox(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              .02,
                                        ),
                                        TextFormField(
                                            controller: homeScreenP.productName,
                                            maxLines: null,
                                            decoration: InputDecoration(
                                              labelText: "ادخل اسم المنتج ",
                                              labelStyle: TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.black),
                                              fillColor: Colors.white,
                                              focusedBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                borderSide: BorderSide(
                                                  color: kTeal400,
                                                  width: 2.0,
                                                ),
                                              ),
                                              enabledBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                borderSide: BorderSide(
                                                  color: kTeal400,
                                                  width: 2.0,
                                                ),
                                              ),
                                            )),
                                        SizedBox(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              .02,
                                        ),
                                        Row(
                                          children: [
                                            Expanded(
                                                flex: 1,
                                                child: Text("اختر الفئة")),
                                            Expanded(
                                              flex: 1,
                                              child:
                                                  DropdownButtonHideUnderline(
                                                child: DropdownButton<String>(
                                                    hint: Text(
                                                        "${categoryProv.hintList}"),
                                                    value:
                                                        categoryProv.listValue,
                                                    items: categoryProv
                                                        .loadedItems
                                                        .map((e) =>
                                                            DropdownMenuItem<
                                                                    String>(
                                                                value: e.name,
                                                                child: Text(
                                                                    '${e.name.toString()}')))
                                                        .toList(),
                                                    onChanged: (val) {
                                                      print(val);
                                                      int id = categoryProv
                                                          .changeCatValue(val);
                                                      homeScreenP
                                                          .categoryForFilter = id;
                                                      homeScreenP
                                                              .isCategoryChose =
                                                          true;
                                                      print("this is id : $id");
                                                    }),
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              .02,
                                        ),
                                        Row(
                                          children: [
                                            Expanded(
                                                flex: 1,
                                                child: Text("على حسب التاريخ")),
                                            Expanded(
                                              flex: 1,
                                              child: DateTimePicker(
                                                type: DateTimePickerType.date,
                                                dateMask: 'd MMM, yyyy',
                                                initialValue:
                                                    DateTime.now().toString(),
                                                firstDate: DateTime(2022),
                                                lastDate: DateTime(2023),
                                                icon: Icon(Icons.event),
                                                dateLabelText: 'Date',
                                                timeLabelText: "Hour",
                                                selectableDayPredicate: (date) {
                                                  return true;
                                                },
                                                onChanged: (val) {
                                                  print(
                                                      "from on change  ${val}");
                                                  homeScreenP.date = val;
                                                  homeScreenP.isCategoryChose =
                                                      true;
                                                },
                                                validator: (val) {
                                                  print(val);
                                                  return null;
                                                },
                                                onSaved: (val) =>
                                                    print("from on save $val"),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ).show();
                    });
                  },
                ),
              ),
            ),
          ],
        ),
        drawer: AppDrawer(),
        body: Consumer<HomeScreenProvider>(
          builder: (context, hSP, _) => Column(
            children: [
              Consumer<CategoriesProvider>(
                builder: (context, categoriesProvider, _) => categoriesProvider
                        .loadedItems.isEmpty
                    ? Center(
                        child: CircularProgressIndicator(
                          color: kTeal400,
                        ),
                      )
                    : Expanded(
                        flex: 0,
                        child: SizedBox(
                          height: 100,
                          child: ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, i) {
                              return CategoryItem(
                                homeScreenProvider: hSP,
                                categoryModel:
                                    categoriesProvider.loadedItems[i],
                              );
                            },
                            itemCount: categoriesProvider.loadedItems.length,
                          ),
                        ),
                      ),
              ),
              Expanded(
                flex: 2,
                child: SmartRefresher(
                  physics: ScrollPhysics(),
                  header: const WaterDropHeader(),
                  footer: CustomFooter(
                    builder: (context, mode) {
                      Widget body;
                      if (mode == LoadStatus.idle) {
                        body = const Text("اسحب للاعلى لتحميل المزيد");
                      } else if (mode == LoadStatus.loading) {
                        print("loading");
                        body = const Center(child: CircularProgressIndicator());
                      } else if (mode == LoadStatus.failed) {
                        body = const Text("فشلت العملية!");
                      } else if (mode == LoadStatus.canLoading) {
                        body = const Text("افلت لتحميل المزيد");
                      } else {
                        body = const Text("نهاية البيانات");
                      }
                      return SizedBox(
                        height: 55.0,
                        child: Center(child: body),
                      );
                    },
                  ),
                  enablePullUp: true,
                  enablePullDown: true,
                  controller: refreshController!,
                  onRefresh: () async {
                    print("from on refresh ");
                    refreshController!.refreshCompleted();
                  },
                  onLoading: () async {
                    page += 1;
                    print("the page number is : $page");
                    hSP.isFirstTime = false;
                    await hSP.getitemsavailable(page: page);
                    refreshController!.loadComplete();
                  },
                  child: hSP.gettingItems == true
                      ? Center(
                          child: CircularProgressIndicator(
                            color: kTeal400,
                          ),
                        )
                      : hSP.items!.isEmpty
                          ? Center(
                              child: Text("لا يوجد عناصر "),
                            )
                          : GridView.builder(
                              physics: const ScrollPhysics(),
                              shrinkWrap: true,
                              padding: const EdgeInsets.all(6),
                              itemCount: hSP.items!.length,
                              itemBuilder: (ctx, i) => hSP.items![i],
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                childAspectRatio: 2.6 / 3.5,
                                crossAxisSpacing: 15,
                                mainAxisSpacing: 10,
                              ),
                            ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

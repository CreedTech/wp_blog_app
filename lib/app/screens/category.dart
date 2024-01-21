import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:wp_blog_app/app/screens/category_screens/accessories.dart';
import 'package:wp_blog_app/app/screens/category_screens/african_print.dart';
import 'package:wp_blog_app/app/screens/category_screens/allure_magazine.dart';
import 'package:wp_blog_app/app/screens/category_screens/allure_tv.dart';
import 'package:wp_blog_app/app/screens/category_screens/allure_woman.dart';
import 'package:wp_blog_app/app/screens/category_screens/ata-ashiru.dart';
import 'package:wp_blog_app/app/screens/category_screens/bbnaija-housemates.dart';
import 'package:wp_blog_app/app/screens/category_screens/belt.dart';
import 'package:wp_blog_app/app/screens/category_screens/bridal_style.dart';
import 'package:wp_blog_app/components/component_theme.dart';
import 'package:wp_blog_app/pages/single_category.dart';
import 'package:wp_blog_app/widgets/category_skeleton_widget.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:wp_blog_app/widgets/single_category_widget.dart';

import '../../helpers/custom_search_article_delegate.dart';
import '../../models/article_category.dart';
import '../../providers/categories.dart';
import '../../providers/theme_provider.dart';
import '../../widgets/refresh_button.dart';
import '../../wp_api.dart';
import 'category_screens/beauty.dart';

class Category extends StatefulWidget {
  const Category({Key? key}) : super(key: key);

  @override
  _CategoryState createState() => _CategoryState();
}

class _CategoryState extends State<Category> {

  Future<List<ArticleCategory>>? _fetchCategories;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      final categoriesProvider =
      Provider.of<CategoriesProvider>(context, listen: false);
      _fetchCategories = categoriesProvider.fetchAllCategories();
    });
  }

  void _chooseCategory(int id) {
    final categoriesProvider =
    Provider.of<CategoriesProvider>(context, listen: false);
    categoriesProvider.selectCategory(id);
  }
  WpApi api = WpApi();

  List<Widget> categoryPages = [
    const AccessoriesScreen(),
    const AfricanPrintScreen(),
    const AllureMagazineScreen(),
    const AllureTVScreen(),
    const AllureWomanScreen(),
    const AtaAshiruScreen(),
    const BBNaijaHouseMatesScreen(),
    const BeautyScreen(),
    const BeltScreen(),
    const BridalStyleScreen(),
  ];

  List categoryNames = [
    'Accessories',
    'African Print',
    'Allure Magazine',
    'Allure TV',
    'Allure Woman',
    'Ata Ashiru',
    'BBNaija HouseMates',
    'Beauty',
    'Belt',
    'Bridal Style',
  ];

  List categoryIcons = [
    const FaIcon(FontAwesomeIcons.userTie, color: colorPrimary,),
    const FaIcon(FontAwesomeIcons.shirt, color: colorPrimary,),
    const FaIcon(FontAwesomeIcons.blog, color: colorPrimary,),
    const FaIcon(FontAwesomeIcons.tv, color: colorPrimary,),
    const FaIcon(FontAwesomeIcons.personDress, color: colorPrimary,),
    const FaIcon(FontAwesomeIcons.newspaper, color: colorPrimary,),
    const FaIcon(FontAwesomeIcons.video, color: colorPrimary,),
    const FaIcon(FontAwesomeIcons.faceSmile, color: colorPrimary,),
    const FaIcon(FontAwesomeIcons.newspaper, color: colorPrimary,),
    const FaIcon(FontAwesomeIcons.ring, color: colorPrimary,),
  ];


  @override
  Widget build(BuildContext context) {
    final categoriesProvider = Provider.of<CategoriesProvider>(context);
    final isThemeChange = Provider.of<ThemeProvider>(context);
    return Scaffold(
      backgroundColor: isThemeChange.mTheme ? colorsBlack : colorWhite,
      appBar: AppBar(
        toolbarHeight: 70,
        elevation: 0,
        backgroundColor: isThemeChange.mTheme ? colorsBlack : colorWhite,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 50.h,
              width: 150.w,
              // alignment: Alignment.center,
              color: Colors.transparent,
              child: Image.asset('assets/images/splash_image.jpg'),
            ),
          ],
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () async {
              showSearch(context: context, delegate: CustomSearchArticleDelegate());

              // final results = await
              //     showSearch(context: context, delegate: CitySearch());

              // print('Result: $results');
            },
          )
        ],
        // backgroundColor: Colors.purple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FutureBuilder(
          future: _fetchCategories,
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.done &&
                snapshot.hasData) {
              return GridView.builder(
                itemCount: categoriesProvider.categories.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3, childAspectRatio: 1.025),
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(
                        top: 7, left: 7, bottom: 7, right: 7),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context)
                                .push(MaterialPageRoute(builder: (_) {
                              return const SingleCategoryWidget();
                            }));
                          },
                          child: Container(
                            width: 120.0,
                            height: 120,
                            decoration: BoxDecoration(
                              color: isThemeChange.mTheme
                                  ? colorsBlackGray
                                  : colorWhite,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(5.0)),
                              boxShadow: [
                                BoxShadow(
                                  color: isThemeChange.mTheme
                                      ? colorsBlack
                                      : colorGray,
                                  blurRadius: 1,
                                  spreadRadius: 1.0,
                                  offset: const Offset(
                                    1.0,
                                    1.0,
                                  ),
                                )
                              ],
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 10.0,
                                  right: 10.0,
                                  top: 10.0,
                                  bottom: 10.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  // Hero(
                                  //   tag: categoryPages[index],
                                  //   child: Container(
                                  //     height: 20,
                                  //     width: 20,
                                  //     // decoration: const BoxDecoration(
                                  //     //   // image: DecorationImage(
                                  //     //   //     image: AssetImage(
                                  //     //   //         "assets/logo/app_logo.png"),
                                  //     //   //     fit: BoxFit.cover),
                                  //     // ),
                                  //     child: categoryIcons[index],
                                  //   ),
                                  // ),
                                  Container(
                                    padding: const EdgeInsets.only(
                                      left: 10.0,
                                      right: 10.0,
                                      top: 10.0,
                                      // bottom: 10.0,
                                    ),
                                    child: Text(
                                      categoriesProvider.categories[index].name,
                                      textAlign: TextAlign.center,
                                      maxLines: 2,
                                      style: TextStyle(
                                        color: isThemeChange.mTheme
                                            ? colorGray
                                            : colorsBlackGray,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12.0,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            } else if (snapshot.connectionState == ConnectionState.none) {
              return Center(
                child: Column(
                  children: <Widget>[
                    const Text(
                      "Sorry please check you internet connection, and swipe on pull down to refresh \n \n Or",
                      style: TextStyle(),
                    ),
                    RefreshButton(
                      text: 'Refresh',
                      onPressed: () {
                        setState(() {});
                      },
                    ),
                  ],
                ),
              );
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              List loading = [1, 2, 3,4,5,6,7,8,9,10];
              return SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  children: loading
                      .asMap()
                      .map(
                        (index, value) => MapEntry(
                          index,
                          Shimmer.fromColors(
                            baseColor: isThemeChange.mTheme
                                ? Colors.white24
                                : Colors.black,
                            highlightColor: darkThemeText,
                            child: const CategorySkeletonWidget(),
                          ),
                        ),
                      )
                      .values
                      .toList(),
                ),
              );
            } else {
              return Center(
                child: Column(
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(20.0),
                      child: Text(
                        "Please check if you are connected to the internet and swipe or pull down to refresh \n \n Or",
                        style: TextStyle(),
                        softWrap: true,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    RefreshButton(
                      text: 'Refresh',
                      onPressed: () {
                        setState(() {});
                      },
                    ),
                  ],
                ),
              );
            }
          },
          // child: ,
        ),
      ),
    );
  }
}

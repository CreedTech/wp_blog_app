import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:wp_blog_app/widgets/refresh_button.dart';
import 'package:wp_blog_app/widgets/trending_skeleton_widget.dart';

import '../components/component_theme.dart';
import '../models/article_category.dart';
import '../providers/categories.dart';
import '../providers/theme_provider.dart';
import 'category_selector.dart';

class Categories extends StatefulWidget {
  const Categories({Key? key}) : super(key: key);

  @override
  _CategoriesState createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
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

  @override
  Widget build(BuildContext context) {
    final categoriesProvider = Provider.of<CategoriesProvider>(context);
    final isThemeChange = Provider.of<ThemeProvider>(context);
    return SizedBox(
      height: 50,
      child: FutureBuilder(
          future: _fetchCategories,
          // initialData: const [],
          // builder: (ctx, snapshot) {
          //   if (snapshot.connectionState == ConnectionState.waiting) {
          //     return Padding(
          //       padding: EdgeInsets.symmetric(
          //         horizontal: 15.w,
          //         vertical: 40.h,
          //       ),
          //       child: Shimmer.fromColors(
          //         baseColor:
          //             isThemeChange.mTheme ? Colors.white24 : Colors.black,
          //         highlightColor: darkThemeText,
          //         child: const TrendingSkeletonWidget(),
          //       ),
          //     );
          //   } else if (snapshot.hasError) {
          //     return Center(
          //       child: Column(
          //         children: [
          //           const Padding(
          //             padding: EdgeInsets.all(20.0),
          //             child: Text(
          //               "Please check if you are connected to the internet and swipe or pull down to refresh \n \n Or",
          //               style: TextStyle(),
          //               softWrap: true,
          //               textAlign: TextAlign.center,
          //             ),
          //           ),
          //           RefreshButton(
          //             text: 'Refresh',
          //             onPressed: () {
          //               setState(() {});
          //             },
          //           ),
          //         ],
          //       ),
          //     );
          //   } else if (snapshot.connectionState == ConnectionState.done &&
          //       snapshot.hasData) {
          //     return ListView.builder(
          //       scrollDirection: Axis.horizontal,
          //       itemBuilder: (ctx, index) =>
          //           categoriesProvider.categories.isEmpty
          //               ? const Center(
          //                   child: Text('No News in this category'),
          //                 )
          //               : CategorySelector(
          //                   id: categoriesProvider.categories[index].id,
          //                   name: categoriesProvider.categories[index].name,
          //                   onPressed: _chooseCategory,
          //                   isSelected: categoriesProvider.isSelected(
          //                       categoriesProvider.categories[index]),
          //                 ),
          //       itemCount:
          //           snapshot.hasData ? categoriesProvider.categories.length : 0,
          //     );
          //   } else {
          //     return Center(
          //       child: Column(
          //         children: [
          //           const Padding(
          //             padding: EdgeInsets.all(20.0),
          //             child: Text(
          //               "Please check if you are connected to the internet and swipe or pull down to refresh \n \n Or",
          //               style: TextStyle(),
          //               softWrap: true,
          //               textAlign: TextAlign.center,
          //             ),
          //           ),
          //           RefreshButton(
          //             text: 'Refresh',
          //             onPressed: () {
          //               setState(() {});
          //             },
          //           ),
          //         ],
          //       ),
          //     );
          //   }
          // }
          builder: (ctx, snapshot) => snapshot.connectionState ==
                  ConnectionState.waiting
              ? Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: const [
              Center(
                child: CircularProgressIndicator(
                  backgroundColor: colorPrimary,
                  color: textGray,
                ),
              ),
            ],
          )
              : snapshot.hasError
                  ? Text(snapshot.error.toString())
                  : ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (ctx, index) =>
                          categoriesProvider.categories.isEmpty
                              ? const Center(
                                child: Text('No News in this category'),
                              )
                              : CategorySelector(
                                  id: categoriesProvider.categories[index].id,
                                  name: categoriesProvider.categories[index].name,
                                  onPressed: _chooseCategory,
                                  isSelected: categoriesProvider.isSelected(
                                      categoriesProvider.categories[index]),
                                ),
                      itemCount: snapshot.hasData
                          ? categoriesProvider.categories.length
                          : 0,
                    ),
          ),
    );
  }
}

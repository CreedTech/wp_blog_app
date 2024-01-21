import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';
import 'package:shimmer/shimmer.dart';
import 'package:wp_blog_app/components/component_style.dart';
import 'package:wp_blog_app/widgets/single_category_widget.dart';
import 'package:wp_blog_app/widgets/trending_skeleton_widget.dart';
import 'dart:math' as Math;


import '../components/component_theme.dart';
import '../models/article.dart';
import '../pages/details_page.dart';
import '../providers/articles.dart';
import '../providers/categories.dart';
import '../providers/theme_provider.dart';
import '../providers/user.dart';
import '../widgets/article_list_item.dart';
import '../widgets/article_options.dart';

class SingleCategory extends StatefulWidget {
  const SingleCategory({Key? key}) : super(key: key);

  @override
  _SingleCategoryState createState() => _SingleCategoryState();
}

class _SingleCategoryState extends State<SingleCategory> {
  Widget build(BuildContext context) {
    var articlesProvider = Provider.of<ArticlesProvider>(
      context,
      listen: false,
    );
    final isThemeChange = Provider.of<ThemeProvider>(context);
    return Scaffold(
      backgroundColor: isThemeChange.mTheme ? colorsBlack : colorWhite,
      appBar: AppBar(
        toolbarHeight: 70,
        elevation: 0,
        backgroundColor: isThemeChange.mTheme ? colorsBlack : colorWhite,
        centerTitle: false,
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
            Text(
              DateFormat.yMMMMEEEEd().format(
                DateTime.now(),
              ),
            ).boldSized(10).colors(colorTextGray),
          ],
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              isThemeChange.mTheme ? Icons.brightness_6 : Icons.brightness_3,
              size: 20.w,
              color: isThemeChange.mTheme ? colorWhite : colorsBlack,
            ),
            onPressed: () {
              isThemeChange.checkTheme();
            },
          )
        ],
      ),
      body: LiquidPullToRefresh(
        height: 200,
        animSpeedFactor: 2,
        showChildOpacityTransition: false,
        color: colorPrimary,
        onRefresh: articlesProvider.refresh,
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: isThemeChange.mTheme
                  ? [
                colorsBlack,
                colorsBlackGray,
              ]
                  : [
                colorWhite,
                colorGray,
              ],
              // stops: [],
            ),
          ),
          child: SingleChildScrollView(
            child: Column(
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: 10.h),
                const SingleCategoryWidget(),
                // SizedBox(height: 20.h),
                // Articles(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:provider/provider.dart';
import 'package:wp_blog_app/components/component_style.dart';

import '../components/component_theme.dart';
import '../const_values.dart';
import '../providers/articles.dart';
import '../providers/theme_provider.dart';
import '../widgets/articles.dart';
import '../widgets/categories.dart';



class HomePage extends StatelessWidget {
  static const routeName = '/home';

  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var articlesProvider = Provider.of<ArticlesProvider>(
      context,
      listen: false,
    );
    final isThemeChange = Provider.of<ThemeProvider>(context);
    return SafeArea(
      top: true,
      child: Scaffold(
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
              color: isThemeChange.mTheme ? colorsBlack : colorWhite,
            ),
            child: SingleChildScrollView(
              child: Column(
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(height: 5.h),
                  const Categories(),
                  // SizedBox(height: 20.h),
                  const Articles(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

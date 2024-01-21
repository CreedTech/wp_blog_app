import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:wp_blog_app/app/screens/tab_view.dart';
import 'package:wp_blog_app/components/component_style.dart';
import 'package:wp_blog_app/const_values.dart';

import '../../components/component_theme.dart';
import '../../helpers/helper_utils.dart';
import '../../pages/tabbar.dart';
import '../../providers/theme_provider.dart';

class SplashScreen extends StatefulWidget {
  static const routeName = 'splash';
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  // Box? storeData;
  @override
  void initState() {
    super.initState();
    // storeData = Hive.box(appState);
    Timer(const Duration(seconds: 4), () {
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) {
        return Tabbar();
      }));
    });
  }

  @override
  Widget build(BuildContext context) {
    final isThemeChange = Provider.of<ThemeProvider>(context);
    return Scaffold(
      backgroundColor: isThemeChange.mTheme ? colorsBlack : colorWhite,
      body: SafeArea(
        child: Center(
          child: SizedBox(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Spacer(),
                ClipRRect(
                  borderRadius: BorderRadius.circular(30.r),
                  child: Image.asset(
                    "assets/logo/app_logo.png",
                    width: 130.w,
                    height: 130.w,
                  ),
                ),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("An Application Made With")
                          .normalSized(12)
                          .colors(isThemeChange.mTheme
                          ? darkThemeText
                          : colorTextGray),
                      const Icon(
                        Icons.favorite,
                        color: Colors.purple,
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:wp_blog_app/app/src/splash.dart';
import 'package:wp_blog_app/components/component_constant.dart';
import 'package:wp_blog_app/custom_theme.dart';
import 'package:wp_blog_app/providers/theme_provider.dart';

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    setStatusBar();
    final isThemeChange = Provider.of<ThemeProvider>(context);
    return ScreenUtilInit(
      builder: (BuildContext context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Allure Vanguard',
          theme: isThemeChange.mTheme == false
              ? buildLightTheme()
              : buildDarkTheme(),
          builder: (c,w){
            setUpScreenUtils(c);
            return MediaQuery(
              data: MediaQuery.of(c).copyWith(textScaleFactor: 1.0),
              child: ScrollConfiguration(
                behavior: MyBehavior(),
                child: w!,
              ),
            );
          },
          home: const SplashScreen(),
        );
      },
    );
  }
}


class MyBehavior extends ScrollBehavior {
  @override
  Widget buildOverscrollIndicator(
      BuildContext context, Widget child, ScrollableDetails details) {
    return child;
  }
}

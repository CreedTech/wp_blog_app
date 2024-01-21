import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wp_blog_app/pages/details_page.dart';
import 'package:wp_blog_app/pages/tabbar.dart';
import 'package:wp_blog_app/providers/articles.dart';
import 'package:wp_blog_app/providers/categories.dart';
import 'package:wp_blog_app/providers/theme_provider.dart';
import 'package:wp_blog_app/providers/user.dart';

import 'app/src/splash.dart';
import 'components/component_constant.dart';
import 'custom_theme.dart';
import 'helpers/helper_routes.dart';
import 'helpers/helper_routes_parh.dart';
import 'helpers/helper_utils.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    setStatusBar();
    // final isThemeChange = Provider.of<ThemeProvider>(context);
    final articlesChangeNotifier = ChangeNotifierProvider.value(
      value: ArticlesProvider(),
    );
    final categoriesChangeNotifier = ChangeNotifierProvider.value(
      value: CategoriesProvider(),
    );
    final userChangeNotifier = ChangeNotifierProvider.value(
      value: UserProvider(),
    );
    final themeChangeNotifier = ChangeNotifierProvider.value(
      value: ThemeProvider(),
    );
    // var isThemeChange = Provider.of<ThemeProvider>(
    //   context,
    //   listen: false,
    // );
    // final isThemeChange = Provider.of<ThemeProvider>(context);
    return MultiProvider(
      providers: [
        articlesChangeNotifier,
        categoriesChangeNotifier,
        userChangeNotifier,
        themeChangeNotifier,
      ],
      child: MaterialApp(
        title: 'Allure Vanguard',
        debugShowCheckedModeBanner: false,
        theme: ThemeProvider().mTheme == false
            ? buildLightTheme()
            : buildDarkTheme(),
        builder: (c, w) {
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
        routes: {
          // Tabbar.routeName: (ctx) => Tabbar(),
          'details': (ctx) => const DetailsPage(),
        },
        // navigatorKey: NavigatorHelper().kNavKey,
        // scaffoldMessengerKey: NavigatorHelper().kscaffoldMessengerKey,
        // initialRoute: root,
        // onGenerateRoute: RouterGenerator().generate,
        // },
      ),
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

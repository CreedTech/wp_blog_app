// import 'dart:io';
//
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:hive/hive.dart';
// import 'package:path_provider/path_provider.dart' as path_provider;
// import 'package:provider/provider.dart';
// import 'package:wp_blog_app/app/src/app.dart';
// import 'package:wp_blog_app/const_values.dart';
// import 'package:wp_blog_app/models/posts.dart';
// import 'package:wp_blog_app/providers/theme_provider.dart';
//
// Future<void> main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   Directory document = await path_provider.getApplicationDocumentsDirectory();
//   Hive
//     ..init(document.path)
//     ..registerAdapter(PostsAdapter());
//   await Hive.openBox(appState);
//
//   SystemChrome.setPreferredOrientations([
//     DeviceOrientation.portraitUp,
//     DeviceOrientation.portraitDown,
//   ]);
//   runApp(
//     MultiProvider(
//       providers: [
//         ChangeNotifierProvider.value(
//           value: ThemeProvider(),
//         ),
//       ],
//       child: const App(),
//     ),
//   );
// }


import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:wp_blog_app/app.dart';


import 'package:wp_blog_app/pages/details_page.dart';
import 'package:wp_blog_app/pages/tabbar.dart';
import 'package:wp_blog_app/providers/articles.dart';
import 'package:wp_blog_app/providers/categories.dart';
import 'package:wp_blog_app/providers/theme_provider.dart';
import 'package:wp_blog_app/providers/user.dart';



void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // timeago.setLocaleMessages('en', timeago.EnMessages());
    SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  return runApp(const App());
}

import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:wp_blog_app/app/screens/bookmark.dart';
import 'package:wp_blog_app/app/screens/category.dart';
import 'package:wp_blog_app/app/screens/home_screen.dart';
import 'package:wp_blog_app/pages/settings.dart';
import 'package:wp_blog_app/components/component_style.dart';
import 'package:wp_blog_app/const_values.dart';
import 'package:wp_blog_app/providers/theme_provider.dart';

import '../../components/component_theme.dart';
import '../../helpers/helper_utils.dart';

class TabView extends StatefulWidget {
  const TabView({Key? key}) : super(key: key);

  @override
  _TabViewState createState() => _TabViewState();
}

class _TabViewState extends State<TabView> {
  final _pageController = PageController(initialPage: 0);
  int maxCount = 4;

  final List<Map<String, dynamic>> _pages = [
    {
      'page': const HomeScreen(),
    },
    {
      'page': const Bookmark(),
    },
    {
      'page': Category(),
    },
    {
      'page': const Settings(),
    },
  ];
  List<Widget> bottomBarPages = [
    const HomeScreen(),
     Category(),
    const Bookmark(),
    const Settings(),
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  int _selectedPageIndex = 0;

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  Box? storeData;

  @override
  void initState() {
    super.initState();
    // storeData = Hive.box(appState);
  }

  @override
  Widget build(BuildContext context) {
    final isThemeChange = Provider.of<ThemeProvider>(context);
    return Scaffold(
      backgroundColor: isThemeChange.mTheme ? colorsBlack : colorWhite,
      // appBar: AppBar(
      //   toolbarHeight: 70,
      //   elevation: 0,
      //   backgroundColor: isThemeChange.mTheme ? colorsBlack : colorWhite,
      //   centerTitle: false,
      //   title: Column(
      //     crossAxisAlignment: CrossAxisAlignment.start,
      //     children: [
      //       const Text(
      //         "Allure Vanguard",
      //       )
      //           .blackSized(26)
      //           .colors(isThemeChange.mTheme ? darkThemeText : colorsBlack),
      //       Text(
      //         DateFormat.yMMMMEEEEd().format(
      //           DateTime.now(),
      //         ),
      //       ).boldSized(10).colors(colorTextGray),
      //     ],
      //   ),
      //   actions: <Widget>[
      //     IconButton(
      //       icon: Icon(
      //         isThemeChange.mTheme ? Icons.brightness_6 : Icons.brightness_3,
      //         size: 20.w,
      //       ),
      //       onPressed: () {
      //         isThemeChange.checkTheme();
      //       },
      //     )
      //   ],
      // ),
      body: PageView(
        controller: _pageController,
        // physics: const NeverScrollableScrollPhysics(),
        children: List.generate(
            bottomBarPages.length, (index) => bottomBarPages[index]),
      ),
      extendBody: true,
      bottomNavigationBar: (bottomBarPages.length <= maxCount)
          ? AnimatedNotchBottomBar(
        itemLabelStyle: TextStyle(
          color: isThemeChange.mTheme ? colorWhite : colorsBlack,
          fontSize: 10.w,
        ),
              pageController: _pageController,
              color: isThemeChange.mTheme ? colorsBlack : colorWhite,
              showLabel: true,
              notchColor: colorPrimary,
              bottomBarItems: const [
                BottomBarItem(
                  inActiveItem: Icon(
                    Icons.home_outlined,
                    color: colorPrimary,
                  ),
                  activeItem: Icon(
                    Icons.home_filled,
                    color: colorWhite,
                  ),
                  itemLabel: 'Home',
                ),

                ///svg example
                BottomBarItem(
                  inActiveItem: Icon(
                    Icons.search,
                    color: colorPrimary,
                  ),
                  activeItem: Icon(
                    Icons.saved_search_rounded,
                    color: colorWhite,
                  ),
                  itemLabel: 'Search',
                ),
                BottomBarItem(
                  inActiveItem: Icon(
                    Icons.bookmark_outline,
                    color: colorPrimary,
                  ),
                  activeItem: Icon(
                    Icons.bookmark,
                    color: colorWhite,
                  ),
                  itemLabel: 'Bookmark',
                ),
                BottomBarItem(
                  inActiveItem: Icon(
                    Icons.settings_outlined,
                    color: colorPrimary,
                  ),
                  activeItem: Icon(
                    Icons.settings,
                    color: colorWhite,
                  ),
                  itemLabel: 'Settings',
                ),
              ],
              onTap: (index) {
                /// control your animation using page controller
                _pageController.animateToPage(
                  index,
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeIn,
                );
              },
            )
          : null,
      // BottomNavyBar(
      //   backgroundColor:
      //       isThemeChange.mTheme == false ? defaultWhite : Colors.grey[850],
      //   selectedIndex: _selectedPageIndex,
      //   onItemSelected: _selectPage,
      //   items: [
      //     BottomNavyBarItem(
      //       icon: const Icon(Icons.home),
      //       title: const Text('Home'),
      //       activeColor:
      //           isThemeChange.mTheme == false ? subColor : defaultWhite,
      //       inactiveColor:
      //           isThemeChange.mTheme == false ? defaultBlack : defaultWhite,
      //     ),
      //     BottomNavyBarItem(
      //       icon: const Icon(Icons.bookmark),
      //       title: const Text('Bookmarks'),
      //       activeColor:
      //           isThemeChange.mTheme == false ? subColor : defaultWhite,
      //       inactiveColor:
      //           isThemeChange.mTheme == false ? defaultBlack : defaultWhite,
      //     ),
      //     BottomNavyBarItem(
      //       icon: const Icon(Icons.list),
      //       title: const Text('Category'),
      //       activeColor:
      //           isThemeChange.mTheme == false ? subColor : defaultWhite,
      //       inactiveColor:
      //           isThemeChange.mTheme == false ? defaultBlack : defaultWhite,
      //     ),
      //     BottomNavyBarItem(
      //       icon: const Icon(Icons.info),
      //       title: const Text('About'),
      //       activeColor:
      //           isThemeChange.mTheme == false ? subColor : defaultWhite,
      //       inactiveColor:
      //           isThemeChange.mTheme == false ? defaultBlack : defaultWhite,
      //     )
      //   ],
      // ),
    );
  }
}

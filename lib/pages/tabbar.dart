import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:provider/provider.dart';
import 'package:wp_blog_app/app/screens/category.dart';
import 'package:wp_blog_app/pages/search_article_page.dart';
import 'package:wp_blog_app/pages/settings.dart';
import 'package:wp_blog_app/components/component_theme.dart';


import '../const_values.dart';
import '../providers/theme_provider.dart';
import 'bookmarks_page.dart';
import 'favorites_page.dart';
import 'home_page.dart';

class Tabbar extends StatefulWidget {
  static const routeName = '/';

  const Tabbar({Key? key}) : super(key: key);
  @override
  _TabbarState createState() => _TabbarState();
}

class _TabbarState extends State<Tabbar> {
  final _pageController = PageController(initialPage: 0);
  var _currentIndex = 0;
  int maxCount = 5;

  final bottomBarPages = [
    const HomePage(),
    const SearchArticlePage(),
    const FavoritesPage(),
    const Settings(),
  ];

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
  List<Widget> _buildScreens (){
    return [
      const HomePage(),
      const SearchArticlePage(),
      const FavoritesPage(),
      const Settings(),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems(BuildContext context) {
    final isThemeChange = Provider.of<ThemeProvider>(context);
    return [
      PersistentBottomNavBarItem(
        // title: 'Home',
        // textStyle: TextStyle(
        //   color: isThemeChange.mTheme ? colorWhite : textGray,
        // ),
        icon: SvgPicture.asset(
          "assets/icons/home_solid.svg",
          height: 20.h,
          width: 20.w,
          color: colorPrimary,
        ),
        inactiveIcon: SvgPicture.asset(
          "assets/icons/home_line.svg",
          height: 20.h,
          width: 20.w,
          color: isThemeChange.mTheme
              ? colorWhite
              : colorsBlack,
        ),
      ),
      PersistentBottomNavBarItem(
        icon: SvgPicture.asset(
          "assets/icons/search_solid.svg",
          color: colorPrimary,
          height: 20.h,
          width: 20.w,
        ),
        inactiveIcon: SvgPicture.asset(
          "assets/icons/search_line.svg",
          height: 20.h,
          width: 20.w,
          color: isThemeChange.mTheme
              ? colorWhite
              : colorsBlack,
        ),
      ),
      PersistentBottomNavBarItem(
        icon: SvgPicture.asset(
          "assets/icons/layers_solid.svg",
          height: 20.h,
          width: 20.w,
          color: colorPrimary,
        ),
        inactiveIcon: SvgPicture.asset(
          "assets/icons/layers_line.svg",
          height: 20.h,
          width: 20.w,
          color: isThemeChange.mTheme
              ? colorWhite
              : colorsBlack,
        ),
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.settings, size: 20.w, color: isThemeChange.mTheme
            ? colorWhite
            : colorsBlack,),
        inactiveIcon:Icon(Icons.settings_outlined, size: 20.w, color: isThemeChange.mTheme
            ? colorWhite
            : colorsBlack,),
      ),
    ];
  }

  // @override
  // Widget build(BuildContext context) {
  //   final isThemeChange = Provider.of<ThemeProvider>(context);
  //   return PersistentTabView(
  //     context,
  //     screens: _buildScreens(),
  //     items: _navBarsItems(context),
  //     navBarHeight: 65.h,
  //     backgroundColor: isThemeChange.mTheme ? colorsBlack : colorWhite,
  //     confineInSafeArea: true,
  //     resizeToAvoidBottomInset: true,
  //     stateManagement: true,
  //     hideNavigationBarWhenKeyboardShows: true,
  //     decoration: NavBarDecoration(
  //       boxShadow: [
  //         const BoxShadow(
  //           color: Colors.black12,
  //           blurRadius: 0.2,
  //           spreadRadius: 0.2,
  //         ),
  //       ],
  //       borderRadius: const BorderRadius.only(
  //           topLeft: Radius.circular(15), topRight: Radius.circular(15)),
  //       colorBehindNavBar: isThemeChange.mTheme ? colorsBlack : colorWhite,
  //     ),
  //     popAllScreensOnTapOfSelectedTab: true,
  //     popActionScreens: PopActionScreensType.all,
  //     itemAnimationProperties: const ItemAnimationProperties(
  //       duration: Duration(milliseconds: 100),
  //       curve: Curves.ease,
  //     ),
  //     screenTransitionAnimation: const ScreenTransitionAnimation(
  //       animateTabTransition: true,
  //       curve: Curves.ease,
  //       duration: Duration(milliseconds: 200),
  //     ),
  //     navBarStyle: NavBarStyle.style11,
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    final isThemeChange = Provider.of<ThemeProvider>(context);
        return Scaffold(
          backgroundColor: isThemeChange.mTheme ? colorsBlack : colorWhite,
      body: SafeArea(
        child: PageView(
          controller: _pageController,
          // physics: const NeverScrollableScrollPhysics(),
          children: List.generate(
              bottomBarPages.length, (index) => bottomBarPages[index]),
        ),
      ),
      extendBody: true,
      bottomNavigationBar: (bottomBarPages.length <= maxCount)
          ? AnimatedNotchBottomBar(
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
    );
    // return Scaffold(
    //   backgroundColor: isThemeChange.mTheme ? colorsBlack : colorWhite,
    //   body: _children[_currentIndex],
    //   bottomNavigationBar:
    //   // BottomNavigationBar(
    //   //   backgroundColor: isThemeChange.mTheme ? colorsBlack : colorWhite,
    //   //   currentIndex: _currentIndex,
    //   //   selectedItemColor: colorPrimary,
    //   //   unselectedItemColor: isThemeChange.mTheme ? colorWhite : textGray,
    //   //   items: const [
    //   //     BottomNavigationBarItem(
    //   //       icon: Icon(Icons.home),
    //   //       label: 'Home',
    //   //     ),
    //   //     BottomNavigationBarItem(
    //   //       icon: Icon(Icons.search),
    //   //       label: 'Search',
    //   //     ),
    //   //     BottomNavigationBarItem(
    //   //       icon: Icon(Icons.favorite),
    //   //       label: 'Favorite',
    //   //     ),
    //   //     BottomNavigationBarItem(
    //   //       icon: Icon(Icons.settings),
    //   //       label: 'Settings',
    //   //     )
    //   //   ],
    //   //   onTap: onTabTapped,
    //   // ),
    // );
  }
}

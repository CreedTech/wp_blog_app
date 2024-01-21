import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shimmer/shimmer.dart';
import 'package:wp_blog_app/components/component_style.dart';
import 'package:wp_blog_app/const_values.dart';
import 'package:wp_blog_app/providers/theme_provider.dart';
import 'package:wp_blog_app/widgets/horizonatl_view.dart';
import 'package:wp_blog_app/widgets/list_view_post.dart';

import '../../components/component_skeleton.dart';
import '../../components/component_theme.dart';
import '../../wp_api.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var dateFormat = DateFormat.yMMMMEEEEd().format(DateTime.now());
  WpApi api = WpApi();

  RefreshController refreshController =
      RefreshController(initialRefresh: false);

  Box? storeData;

  @override
  void initState() {
    super.initState();
    const HorizontalView();
    const ListViewPost();
    storeData = Hive.box(appState);
  }

  Future<void> _onRefresh() async {
    // monitor network fetch
    await Future.delayed(const Duration(milliseconds: 1000));
    if (mounted) {
      setState(() {});
    }
    // if failed,use refreshFailed()
    refreshController.refreshCompleted();
  }

  void _onLoading() async {
    // monitor network fetch
    await Future.delayed(const Duration(milliseconds: 1000));
    // getSermons();
    // if (mounted) {
    //   setState(() {});
    // }
    refreshController.loadComplete();
  }

  @override
  Widget build(BuildContext context) {
    final isThemeChange = Provider.of<ThemeProvider>(context);
    return SafeArea(
      top: true,
      child: Scaffold(
        backgroundColor: isThemeChange.mTheme ? colorWhite : darkColor,
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
          onRefresh: _onRefresh,
          // onLoading: _onLoading,
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(height: 20.h),
                  const HorizontalView(),
                  // SizedBox(height: 20.h),
                  SizedBox(height: 20.h),
                  _recommendationTextWidget(),
                  SizedBox(height: 10.h),
                  _recommendationNews(),
                  SizedBox(height: 20.h),
                  // const ListViewPost(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _recommendationTextWidget() {
    final isThemeChange = Provider.of<ThemeProvider>(context);
    return FutureBuilder(
        future: api.fetchTopPosts(),
      builder: (_, AsyncSnapshot snapshot) {
        return snapshot.connectionState == ConnectionState.waiting
            ? Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.w),
          child: Shimmer.fromColors(
            baseColor:
            isThemeChange.mTheme ? Colors.white24 : Colors.black,
            highlightColor: darkThemeText,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Skeleton(width: 80.w),
                Skeleton(width: 80.w),
              ],
            ),
          ),
        )
            : Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.w),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Recommendation").boldSized(16).colors(
                      isThemeChange.mTheme
                          ? darkThemeText
                          : colorsBlack),
                  GestureDetector(
                    // onTap: () => Guide.to(
                    //   name: categoryNews,
                    //   arguments: CategoryNewsViewArgument(
                    //     category: "All News",
                    //     query: "",
                    //     isKeyword: false,
                    //   ),
                    // ),
                    onTap: (){},
                    child: const Text("See more").boldSized(12).colors(
                        isThemeChange.mTheme
                            ? colorWhite
                            : colorPrimary),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _recommendationNews() {
    return const ListViewPost();
  }

}

import 'package:auto_size_text_pk/auto_size_text_pk.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:wp_blog_app/app/screens/post_view.dart';
import 'package:wp_blog_app/components/component_style.dart';
import 'package:wp_blog_app/models/posts.dart';
import 'package:wp_blog_app/widgets/refresh_button.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:wp_blog_app/widgets/trending_skeleton_widget.dart';
import '../components/component_theme.dart';
import '../helpers/helper_utils.dart';
import '../providers/theme_provider.dart';
import '../wp_api.dart';
import '../const_values.dart';

class HorizontalView extends StatefulWidget {
  const HorizontalView({Key? key}) : super(key: key);

  @override
  _HorizontalViewState createState() => _HorizontalViewState();
}

class _HorizontalViewState extends State<HorizontalView> {
  WpApi api = WpApi();
  late PageController controller;
  String formatDateTime(DateTime dateTime) {
    return "${dateTime.day}/${dateTime.month}/${dateTime.year}";
  }

  displayTime(String date) {
    return DateFormat.yMMMMEEEEd().format(DateTime.parse(date));
  }

  @override
  void initState() {
    controller = PageController();
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isThemeChange = Provider.of<ThemeProvider>(context);
    return FutureBuilder(
      future: api.fetchTopPosts(),
      builder: (_, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            snapshot.hasData) {
          return Container(
            margin: EdgeInsets.symmetric(horizontal: 20.w),
            height: 200.h,
            width: 360.w,
            decoration: BoxDecoration(
              color: isThemeChange.mTheme ? colorsBlack : colorWhite,
              boxShadow: isThemeChange.mTheme
                  ? [
                      const BoxShadow(
                        color: textGray,
                        offset: Offset(
                          0.5,
                          0.5,
                        ),
                        blurRadius: 0.5,
                        spreadRadius: 0.1,
                      )
                    ]
                  : [],
              borderRadius: BorderRadius.circular(15.r),
            ),
            child:
            ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 1,
              itemBuilder: (_, index) {
                Posts post = snapshot.data[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) {
                        return PostView(
                          posts: post,
                        );
                      }),
                    );
                  },
                  child: Column(
                    children: [
                      Stack(
                        children: <Widget>[
                          ClipRRect(
                            borderRadius: BorderRadius.circular(15.r),
                            child: SizedBox(
                              width: 350.w,
                              height: 200.h,
                              child: CachedNetworkImage(
                                // imageUrl: trending[index].source.ogImage[0].url,
                                imageUrl:
                                post.image ?? 'assets/images/img_error.jpg',
                                imageBuilder: (c, image) => Container(
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: image,
                                      fit: BoxFit.cover,
                                      colorFilter: Theme.of(context).brightness ==
                                          Brightness.dark
                                          ? ColorFilter.mode(
                                        Colors.black.withOpacity(0.3),
                                        BlendMode.softLight,
                                      )
                                          : ColorFilter.mode(
                                        Colors.black.withOpacity(0.8),
                                        BlendMode.softLight,
                                      ),
                                    ),
                                  ),
                                ),
                                placeholder: (_, url) {
                                  return Image.asset(
                                    'assets/images/newLoading.gif',
                                    width: 50,
                                    height: 50,
                                  );
                                },
                                errorWidget: (context, url, error) => Image.asset(
                                  'assets/images/img_error.jpg',
                                  width: 50,
                                  height: 50,
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 12.h,
                            right: 15.w,
                            left: 15.w,
                            child: Container(
                              width: 330.w,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: isThemeChange.mTheme
                                    ? colorsBlack
                                    : colorWhite,
                                borderRadius: BorderRadius.circular(8.r),
                                border: Border.all(
                                  color: isThemeChange.mTheme
                                      ? darkThemeText
                                      : borderGray,
                                  width: 0.3,
                                  style: BorderStyle.solid,
                                ),
                              ),
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 11.w),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      height: 10.h,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      children: [
                                        SizedBox(
                                          width: 260.w,
                                          child: Text(
                                            '${post.title}',
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                          ).boldSized(18).colors(
                                            isThemeChange.mTheme
                                                ? darkThemeText
                                                : colorsBlack,
                                          ),
                                        ),
                                        // Column(
                                        //   crossAxisAlignment:
                                        //       CrossAxisAlignment.start,
                                        //   children: [
                                        //     Icon(
                                        //       Icons.remove_red_eye_outlined,
                                        //       size: 24.h,
                                        //       color: colorPrimary,
                                        //     ),
                                        //     Text("${Random().nextInt(999)} K")
                                        //         .boldSized(11)
                                        //         .colors(colorPrimary),
                                        //   ],
                                        // )
                                      ],
                                    ),
                                    SizedBox(
                                      height: 9.h,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            const Text('BY')
                                                .boldSized(10)
                                                .colors(colorTextGray),
                                            SizedBox(
                                              width: 7.w,
                                            ),
                                            // Text(trending[index]
                                            //     .yoastHeadJson!
                                            //     .author
                                            //     .toUpperCase())
                                            //     .boldSized(10)
                                            //     .colors(colorTextGray)
                                          ],
                                        ),
                                        Text("${displayTime(post.time.toString())}")
                                            .boldSized(10).colors(colorTextGray),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 7.h,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          // Container(
                          //   width: 250.w,
                          //   padding: const EdgeInsets.only(left: 5.0),
                          //   child: Padding(
                          //     padding: const EdgeInsets.all(8.0),
                          //     child: AutoSizeText(
                          //       '${post.title}',
                          //       style: TextStyle(
                          //         fontWeight: FontWeight.bold,
                          //         fontSize: 8.sp,
                          //       ),
                          //       maxLines: 2,
                          //       minFontSize: 15,
                          //       overflow: TextOverflow.fade,
                          //       softWrap: true,
                          //     ),
                          //   ),
                          // ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          );
        } else if (snapshot.connectionState == ConnectionState.none) {
          return Center(
            child: Column(
              children: <Widget>[
                const Text(
                  "Sorry please check you internet connection, and swipe on pull down to refresh \n \n Or",
                  style: TextStyle(),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                RefreshButton(
                  text: 'Refresh',
                  onPressed: () {
                    setState(() {});
                  },
                ),
              ],
            ),
          );
        } else if (snapshot.connectionState == ConnectionState.waiting) {
          return  Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 15.w,
              vertical: 40.h,
            ),
            child: Shimmer.fromColors(
              baseColor: isThemeChange.mTheme ? Colors.white24 : Colors.black,
              highlightColor: darkThemeText,
              child: const TrendingSkeletonWidget(),
            ),
          );
        } else {
          return Center(
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Text(
                    "Please check if you are connected to the internet and swipe or pull down to refresh \n \n Or",
                    style: TextStyle(),
                    softWrap: true,
                    textAlign: TextAlign.center,
                  ),
                ),
                RefreshButton(
                  text: 'Refresh',
                  onPressed: () {
                    setState(() {});
                  },
                ),
              ],
            ),
          );
        }
      },
    );
  }
}

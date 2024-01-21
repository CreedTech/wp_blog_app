import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:wp_blog_app/app/screens/post_view.dart';
import 'package:wp_blog_app/components/component_style.dart';
import 'package:wp_blog_app/const_values.dart';
import 'package:wp_blog_app/widgets/refresh_button.dart';
import 'package:wp_blog_app/wp_api.dart';

import '../../../components/component_theme.dart';
import '../../../providers/theme_provider.dart';
import '../../../widgets/trending_skeleton_widget.dart';

class AllureTVScreen extends StatefulWidget {
  const AllureTVScreen({Key? key}) : super(key: key);

  @override
  _AllureTVScreenState createState() => _AllureTVScreenState();
}

class _AllureTVScreenState extends State<AllureTVScreen> {
  WpApi api = WpApi();

  String formatDateTime(DateTime dateTime) {
    return "${dateTime.day}/${dateTime.month}/${dateTime.year}";
  }

  displayTime(String date) {
    return DateFormat.yMMMMEEEEd().format(DateTime.parse(date));
  }

  @override
  Widget build(BuildContext context) {
    final isThemeChange = Provider.of<ThemeProvider>(context);
    return Scaffold(
      backgroundColor: isThemeChange.mTheme ? colorsBlack : colorWhite,
      appBar: AppBar(
        title: const Text("Allure TV"),
        backgroundColor: isThemeChange.mTheme ? colorsBlack : colorWhite,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: FutureBuilder(
            future: api.fetchOtherCategories(15775),
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.connectionState == ConnectionState.done &&
                  snapshot.hasData) {
                return ListView.builder(
                  primary: false,
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: snapshot.data.length,
                  itemBuilder: (_, index) {
                    return InkWell(
                      onTap: () {
                        var post = snapshot.data[index];
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (_) {
                            return PostView(
                              posts: post,
                            );
                          }),
                        );
                      },
                      child: Container(
                        height: 100.h,
                        margin: EdgeInsets.only(top: 8.h),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.r),
                          color: isThemeChange.mTheme
                              ? colorsBlack
                              : colorWhite,
                          border: Border.all(
                            color: isThemeChange.mTheme
                                ? Colors.grey.withOpacity(0.1)
                                : borderGray,
                          ),
                        ),
                        child: Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10.r),
                              child: SizedBox(
                                width: 115.w,
                                height: 100.h,
                                child: CachedNetworkImage(
                                  // imageUrl: recommendation[index].source.ogImage[0].url,
                                  imageUrl: snapshot.data[index].image,
                                  imageBuilder: (c, image) => Container(
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: image,
                                        fit: BoxFit.cover,
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
                            Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: 10.w,
                                vertical: 8.h,
                              ),
                              child: Column(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: 220.w,
                                    child: Text(
                                      snapshot.data[index].title!,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ).boldSized(14).colors(
                                        isThemeChange.mTheme
                                            ? darkThemeText
                                            : colorsBlack),
                                  ),
                                  SizedBox(
                                    width: 220.w,
                                    child: Text(snapshot.data[index].contents!,
                                      maxLines: 2,
                                      textAlign: TextAlign.justify,
                                      overflow: TextOverflow.ellipsis,
                                    ).normalSized(12).colors(
                                      isThemeChange.mTheme
                                          ? darkThemeText
                                          : colorsBlack,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 210.w,
                                    child: Row(
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
                                            // Text(
                                            //   recommendation[index]
                                            //       .yoastHeadJson!
                                            //       .author
                                            //       .toUpperCase(),
                                            // )
                                            //     .boldSized(10)
                                            //     .colors(colorTextGray)
                                          ],
                                        ),
                                        Text("${displayTime(snapshot.data[index].time)}")
                                            .boldSized(10)
                                            .colors(colorTextGray),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        // child: Row(
                        //   crossAxisAlignment: CrossAxisAlignment.start,
                        //   children: <Widget>[
                        //     Container(
                        //       width: 100.w,
                        //       height: 100.h,
                        //       margin: const EdgeInsets.only(left: 20),
                        //       decoration: BoxDecoration(
                        //         borderRadius: const BorderRadius.all(
                        //           Radius.circular(15.0),
                        //         ),
                        //         image: DecorationImage(
                        //           image: NetworkImage(
                        //             snapshot.data[index].image,
                        //           ),
                        //           fit: BoxFit.cover,
                        //         ),
                        //       ),
                        //       child: CachedNetworkImage(
                        //         imageUrl: snapshot.data[index].image,
                        //         fit: BoxFit.cover,
                        //         width: 100.w,
                        //         height: 100.h,
                        //       ),
                        //     ),
                        //     const SizedBox(
                        //       width: 15,
                        //     ),
                        //     Expanded(
                        //       child: Column(
                        //         crossAxisAlignment: CrossAxisAlignment.start,
                        //         mainAxisAlignment: MainAxisAlignment.start,
                        //         children: <Widget>[
                        //           Padding(
                        //             padding: const EdgeInsets.all(8.0),
                        //             child: Text(
                        //               snapshot.data[index].title
                        //                   .toString()
                        //                   .length >=
                        //                   20
                        //                   ? snapshot.data[index].title
                        //                   .substring(0, 20) +
                        //                   "..."
                        //                   : snapshot.data[index].title,
                        //               style: TextStyle(
                        //                 fontWeight: FontWeight.bold,
                        //                 fontSize: 18.sp,
                        //               ),
                        //               softWrap: true,
                        //               overflow: TextOverflow.fade,
                        //             ),
                        //           ),
                        //           Padding(
                        //             padding: const EdgeInsets.all(8.0),
                        //             child: Text(
                        //               "${displayTime(snapshot.data[index].time)}",
                        //             ),
                        //           ),
                        //         ],
                        //       ),
                        //     )
                        //   ],
                        // ),
                      ),
                    );
                  },
                );
              } else if (snapshot.connectionState == ConnectionState.none) {
                return Center(
                  child: Column(
                    children: <Widget>[
                      const Text(
                        "Sorry please check you internet connection, and swipe on pull down to refresh \n \n Or",
                        style: TextStyle(),
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
                List loading = [1, 2, 3,4,5,6,7,8];
                return SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    children: loading
                        .asMap()
                        .map(
                          (index, value) => MapEntry(
                        index,
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 15.w,
                            vertical: 5.h,
                          ),
                          child: Shimmer.fromColors(
                            baseColor: isThemeChange.mTheme
                                ? Colors.white24
                                : Colors.black,
                            highlightColor: darkThemeText,
                            child: const TrendingSkeletonWidget(),
                          ),
                        ),
                      ),
                    )
                        .values
                        .toList(),
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
          ),
        ),
      ),
    );
  }
}

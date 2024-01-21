import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:wp_blog_app/app/screens/post_view.dart';
import 'package:wp_blog_app/components/component_style.dart';
import 'package:wp_blog_app/const_values.dart';
import 'package:wp_blog_app/models/posts.dart';
import 'package:wp_blog_app/widgets/refresh_button.dart';
import 'package:wp_blog_app/widgets/trending_skeleton_widget.dart';

import '../components/component_theme.dart';
import '../helpers/helper_utils.dart';
import '../providers/theme_provider.dart';
import '../wp_api.dart';

class ListViewPost extends StatefulWidget {
  const ListViewPost({Key? key}) : super(key: key);

  @override
  _ListViewPostState createState() => _ListViewPostState();
}

class _ListViewPostState extends State<ListViewPost> {
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
    return Padding(
      padding: const EdgeInsets.only(left: 10),
      child: FutureBuilder(
        future: api.fetchListPosts(),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.done &&
              snapshot.hasData) {
            // Posts post = snapshot.data;
            return ListView.builder(
              primary: false,
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: snapshot.data.length,
              itemBuilder: (_, index)  {
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
                              imageUrl: post.image ?? "assets/images/img_error.jpg",
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
                                  post.title!,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ).boldSized(14).colors(
                                    isThemeChange.mTheme
                                        ? darkThemeText
                                        : colorsBlack),
                              ),
                              SizedBox(
                                width: 220.w,
                                child: Text(post.contents!,
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
                                    Text("${displayTime(post.time.toString())}")
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
                  ),
                );
              },
            );

          }
          else if (snapshot.connectionState == ConnectionState.none) {
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
            List loading = [1, 2, 3];
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
    );
  }
}

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:wp_blog_app/app/screens/post_view.dart';
import 'package:wp_blog_app/components/component_style.dart';
import 'package:wp_blog_app/const_values.dart';
import 'package:wp_blog_app/models/posts.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../components/component_theme.dart';
import '../../providers/theme_provider.dart';

class Bookmark extends StatefulWidget {
  const Bookmark({Key? key}) : super(key: key);

  @override
  _BookmarkState createState() => _BookmarkState();
}

class _BookmarkState extends State<Bookmark> {
  Box? storeData;

  displayTime(String date) {
    return DateFormat.yMMMMEEEEd().format(DateTime.parse(date));
  }
  // RefreshController refreshController =
  // RefreshController(initialRefresh: false);

  @override
  void initState() {
    super.initState();
    storeData = Hive.box(appState);
  }

  Future<void> _onRefresh() async {
    // // monitor network fetch
    // await Future.delayed(const Duration(milliseconds: 1000));
    // if (mounted) {
    //   setState(() {});
    // }
    // // if failed,use refreshFailed()
    // refreshController.refreshCompleted();
  }

  /*
  * All the null exception in the body is because I stored a bool which I use
  * in changing the theme from dark mode to light mode.
  * this has been chnanged and fixed but if any user have the app installed
  * on their phones before that issue will still be there.
  * I will come up with a way to fix this soon.
  */

  @override
  Widget build(BuildContext context) {
    final isThemeChange = Provider.of<ThemeProvider>(context);
    return ValueListenableBuilder(
      valueListenable: storeData!.listenable(),
      builder: (context, Box box, _) {
        // List<int> keys = box.keys.cast<int>().toList();
        return Scaffold(
          backgroundColor: isThemeChange.mTheme ? colorsBlack : colorWhite,
          appBar: AppBar(
            toolbarHeight: 70,
            elevation: 0,
            backgroundColor: isThemeChange.mTheme ? colorsBlack : colorWhite,
            centerTitle: true,
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Bookmarks",
                ).blackSized(26).colors(
                      isThemeChange.mTheme ? darkThemeText : colorsBlack,
                    ),
                const Text("Save your time by using bookmarks")
                    .boldSized(10)
                    .colors(
                      isThemeChange.mTheme ? darkThemeText : colorTextGray,
                    ),
              ],
            ),
          ),
          body: SafeArea(
            child: RefreshIndicator(
              // height: 200,
              // animSpeedFactor: 2,
              // showChildOpacityTransition: false,
              // color: colorPrimary,
              onRefresh: _onRefresh,
              child: Container(
                // decoration: BoxDecoration(
                //   gradient: LinearGradient(
                //     begin: Alignment.topCenter,
                //     end: Alignment.bottomCenter,
                //     colors: isThemeChange.mTheme
                //         ? [
                //             colorsBlack,
                //             colorsBlackGray,
                //           ]
                //         : [
                //             colorWhite,
                //             colorGray,
                //           ],
                //   ),
                // ),
                child: storeData!.isNotEmpty
                    ? SingleChildScrollView(
                        child: ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          // primary: false,
                          shrinkWrap: true,
                          itemCount: storeData!.keys.toList().length,
                          itemBuilder: (_, index) {
                            final keys = box.keys.toList()[index];
                            final Posts post = box.get(keys);
                            return Dismissible(
                              key: ObjectKey(post),
                              onDismissed: (direction) {
                                storeData!.delete(keys);
                                // context.read<BookmarkNewsBloc>().add(
                                //   BookmarkNewsRemoveEvent(
                                //     remove: data,
                                //   ),
                                // );
                              },
                              background: Container(
                                color: Colors.red,
                                alignment: Alignment.centerRight,
                              ),
                              secondaryBackground: Container(
                                margin: EdgeInsets.symmetric(horizontal: 15.w),
                                padding: EdgeInsets.symmetric(horizontal: 20.w),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.r),
                                  color: Colors.red,
                                  border: Border.all(
                                    width: 0.5,
                                    color: isThemeChange.mTheme
                                        ? Colors.grey.withOpacity(0.5)
                                        : borderGray,
                                  ),
                                ),
                                alignment: Alignment.centerRight,
                                child: Icon(
                                  Icons.delete,
                                  size: 30.h,
                                ),
                              ),
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.of(context)
                                      .push(MaterialPageRoute(builder: (_) {
                                    return PostView(posts: post);
                                  }));
                                },
                                // onLongPress: () {
                                //   showDialog(
                                //     context: context,
                                //     builder: (_) {
                                //       return AlertDialog(
                                //         title: const Text('Warning'),
                                //         content: const Text(
                                //           'You are about to delete this bookmark are '
                                //           'you sure about this?',
                                //         ),
                                //         actions: [
                                //           TextButton(
                                //             onPressed: () {
                                //               Navigator.pop(context);
                                //             },
                                //             child: const Text('No'),
                                //           ),
                                //           TextButton(
                                //             onPressed: () {
                                //               storeData!.delete(keys);
                                //               Navigator.pop(context);
                                //             },
                                //             child: const Text('Yes'),
                                //           ),
                                //         ],
                                //       );
                                //     },
                                //   );
                                // },
                                child: Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 15.w),
                                  child: Container(
                                    height: 120.h,
                                    margin: EdgeInsets.only(top: 8.h),
                                    // width: MediaQuery.of(context).size.width,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.r),
                                      color: isThemeChange.mTheme
                                          ? colorsBlack
                                          : colorWhite,
                                      border: Border.all(
                                        width: 0.5,
                                        color: isThemeChange.mTheme
                                            ? Colors.grey.withOpacity(0.5)
                                            : borderGray,
                                      ),
                                    ),
                                    child: Row(
                                      // crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(10.r),
                                          child: SizedBox(
                                            width: 120.w,
                                            height: 120.h,
                                            child: CachedNetworkImage(
                                              // imageUrl: data[index].source.ogImage[0].url,
                                              imageUrl: post.image ?? '',
                                              imageBuilder: (c, image) =>
                                                  Container(
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
                                        // post.image == null
                                        //     ? Container()
                                        //     : Container(
                                        //         width: 100.w,
                                        //         height: 100.h,
                                        //         margin: const EdgeInsets.only(left: 20),
                                        //         decoration: const BoxDecoration(
                                        //           borderRadius: BorderRadius.all(
                                        //             Radius.circular(15.0),
                                        //           ),
                                        //         ),
                                        //         child: CachedNetworkImage(
                                        //           imageUrl: post.image ?? '',
                                        //           fit: BoxFit.cover,
                                        //           width: 100,
                                        //           height: 100,
                                        //           placeholder: (_, url) {
                                        //             return Image.asset(
                                        //               'assets/images/newLoading.gif',
                                        //               width: 50,
                                        //               height: 50,
                                        //             );
                                        //           },
                                        //         ),
                                        //       ),
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: 8.w,
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
                                                  '${post.title}',
                                                  maxLines: 2,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ).boldSized(14).colors(
                                                      isThemeChange.mTheme
                                                          ? darkThemeText
                                                          : colorsBlack,
                                                    ),
                                              ),
                                              SizedBox(
                                                width: 220.w,
                                                child: Text(
                                                  '${post.contents}',
                                                  maxLines: 3,
                                                  overflow:
                                                      TextOverflow.ellipsis,
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
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        SizedBox(
                                                          width: 7.w,
                                                        ),
                                                        // Text(data[index]
                                                        //     .yoastHeadJson!
                                                        //     .author)
                                                        //     .boldSized(10)
                                                        //     .colors(
                                                        //     colorTextGray)
                                                      ],
                                                    ),
                                                    Text(
                                                      "${displayTime(post.time.toString())}",
                                                    )
                                                        .boldSized(10)
                                                        .colors(colorTextGray),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        // const SizedBox(
                                        //   width: 15,
                                        // ),
                                        // Expanded(
                                        //   child: Column(
                                        //     crossAxisAlignment:
                                        //         CrossAxisAlignment.start,
                                        //     mainAxisAlignment:
                                        //         MainAxisAlignment.start,
                                        //     children: <Widget>[
                                        //       Padding(
                                        //         padding:
                                        //             const EdgeInsets.all(8.0),
                                        //         child: post.title == null
                                        //             ? Container()
                                        //             : Text(
                                        //                 '${post.title}',
                                        //                 style: TextStyle(
                                        //                   fontWeight:
                                        //                       FontWeight.bold,
                                        //                   fontSize: 18,
                                        //                 ),
                                        //                 softWrap: true,
                                        //                 overflow:
                                        //                     TextOverflow.fade,
                                        //               ),
                                        //       ),
                                        //       Padding(
                                        //         padding:
                                        //             const EdgeInsets.all(5.0),
                                        //         child: post.time == null
                                        //             ? Container()
                                        //             : Text(
                                        //                 "${displayTime(post.time.toString())}",
                                        //               ),
                                        //       ),
                                        //     ],
                                        //   ),
                                        // )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      )
                    : SizedBox(
                        height: 700.h,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              "assets/icons/empty.svg",
                              width: 100.w,
                              height: 200.h,
                            ),
                            SizedBox(
                              height: 20.h,
                            ),
                            const Text("There is no data saved")
                                .boldSized(20)
                                .colors(
                                  isThemeChange.mTheme
                                      ? darkThemeText
                                      : colorTextGray,
                                ),
                            SizedBox(
                              height: 100.h,
                            ),
                            SizedBox(
                              height: 10.h,
                              child: ListView(),
                            ),
                          ],
                        ),
                      ),
              ),
            ),
          ),
        );
      },
    );
  }
}

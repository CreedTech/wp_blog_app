import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:wp_blog_app/components/component_style.dart';
import 'package:wp_blog_app/const_values.dart';
import 'package:wp_blog_app/models/posts.dart';

import '../../components/component_theme.dart';
import '../../providers/theme_provider.dart';

class PostView extends StatefulWidget {
  final Posts? posts;

  const PostView({Key? key, @required this.posts}) : super(key: key);

  @override
  _PostViewState createState() => _PostViewState();
}

class _PostViewState extends State<PostView> {
  displayTime(String date) {
    return DateFormat.yMMMMEEEEd().format(DateTime.parse(date));
  }

  Box? storeData;

  @override
  void initState() {
    super.initState();
    storeData = Hive.box(appState);
  }

  @override
  Widget build(BuildContext context) {
    final isThemeChange = Provider.of<ThemeProvider>(context);
    Posts post = Posts(
      id: widget.posts!.id,
      title: widget.posts!.title,
      image: widget.posts!.image,
      contents: widget.posts!.contents,
      time: widget.posts!.time,
      author: widget.posts!.author,
    );

    final bookmarked = storeData!.containsKey(post.id);
    return Scaffold(
      backgroundColor: isThemeChange.mTheme ? colorsBlack : colorWhite,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 350.h,
            floating: true,
            pinned: true,
            centerTitle: true,
            elevation: 0,
            backgroundColor: isThemeChange.mTheme ? colorsBlack : colorWhite,
            leading: Container(
              decoration: BoxDecoration(
                color: isThemeChange.mTheme ? colorsBlack : colorWhite,
                borderRadius: BorderRadius.circular(15.r),
              ),
              margin: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
              child: IconButton(
                onPressed: () => Navigator.of(context).pop(),
                icon: Icon(
                  Icons.arrow_back_ios_new,
                  color: isThemeChange.mTheme ? colorPrimary : colorPrimary,
                ),
              ),
            ),
            actions: [
              Container(
                decoration: BoxDecoration(
                  color: isThemeChange.mTheme ? colorsBlack : colorWhite,
                  borderRadius: BorderRadius.circular(15.r),
                ),
                margin: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
                child: IconButton(
                  onPressed: () async {
                    Posts post = Posts(
                      id: widget.posts!.id,
                      title: widget.posts!.title,
                      image: widget.posts!.image,
                      contents: widget.posts!.contents,
                      time: widget.posts!.time,
                      author: widget.posts!.author,
                    );
                    setState(() {
                      if (bookmarked) {
                        storeData!.delete(post.id);
                      } else {
                        storeData!.put(post.id, post);
                      }
                    });
                    // print('Contains key $bookmarked');
                    // if (!(storeData!.containsKey(post.id))) {
                    //   await storeData!.put(post.id, post);
                    // }
                    // await storeData!.containsKey(widget.posts!.id) ? null : storeData!.add(post);
                    if (!bookmarked) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          backgroundColor: isThemeChange.mTheme
                              ? colorPrimary
                              : colorPrimary,
                          content: const Text('Bookmarked!!!'),
                          // animation: ,
                        ),
                      );
                    }
                  },
                  icon: Icon(
                    bookmarked
                        ? Icons.bookmark_outlined
                        : Icons.bookmark_border,
                    color: isThemeChange.mTheme ? colorPrimary : colorPrimary,
                    // storeData!.containsKey(widget.posts!.id)
                    //     ? Icon(
                    //         Icons.bookmark_outlined,
                    //         color: isThemeChange.mTheme
                    //             ? colorPrimary
                    //             : colorPrimary,
                    //       )
                    //     : Icon(
                    //         Icons.bookmark_border,
                    //         color:
                    //             isThemeChange.mTheme ? colorWhite : colorPrimary,
                    //       ),
                  ),
                ),
              ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              titlePadding: EdgeInsets.symmetric(horizontal: 10.w),
              collapseMode: CollapseMode.parallax,
              background: SizedBox(
                width: 120.w,
                height: 100.h,
                child: Stack(
                  children: [
                    CachedNetworkImage(
                      // imageUrl: response[0].source.ogImage[0].url,
                      imageUrl: '${widget.posts!.image}',
                      imageBuilder: (c, image) => Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: image,
                            fit: BoxFit.cover,
                            colorFilter: isThemeChange.mTheme
                                ? ColorFilter.mode(
                                    Colors.black.withOpacity(0.9),
                                    BlendMode.softLight,
                                  )
                                : ColorFilter.mode(
                                    Colors.black.withOpacity(0.8),
                                    BlendMode.softLight,
                                  ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: -1,
                      right: 0,
                      left: 0,
                      child: Column(
                        children: [
                          Container(
                            height: 15.h,
                            decoration: BoxDecoration(
                              color: isThemeChange.mTheme
                                  ? colorsBlack
                                  : colorWhite,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(25.r),
                                topRight: Radius.circular(25.r),
                              ),
                            ),
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 170.w, vertical: 12.h),
                              child: Divider(
                                color: isThemeChange.mTheme
                                    ? colorWhite
                                    : borderGray,
                                thickness: 3.5,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: ClipRRect(
              borderRadius: BorderRadius.only(topLeft: Radius.circular(20.r)),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w),
                decoration: BoxDecoration(
                  color: isThemeChange.mTheme ? colorsBlack : colorWhite,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 10.h,
                    ),
                    Container(
                      height: 55.h,
                      padding: EdgeInsets.symmetric(vertical: 4.w),
                      child: Row(
                        children: [
                          SizedBox(
                            width: 10.w,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              SizedBox(
                                width: 350.w,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text("Article By")
                                        .normalSized(11)
                                        .colors(
                                          isThemeChange.mTheme
                                              ? darkThemeText
                                              : colorTextGray,
                                        ),
                                    Text(
                                      "${displayTime(widget.posts!.time.toString())}",
                                    ).normalSized(11).colors(
                                          isThemeChange.mTheme
                                              ? darkThemeText
                                              : colorTextGray,
                                        ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: 350.w,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: const [
                                    // Text(
                                    //   response[0].yoastHeadJson!.author.toUpperCase(),
                                    //   maxLines: 1,
                                    //   overflow: TextOverflow.ellipsis,
                                    // ).boldSized(17).colors(
                                    //   isThemeChange.mTheme
                                    //       ? darkThemeText
                                    //       : colorTextGray,
                                    // ),
                                    // Container(
                                    //   padding: EdgeInsets.symmetric(
                                    //     vertical: 6.h,
                                    //     horizontal: 6.w,
                                    //   ),
                                    //   decoration: BoxDecoration(
                                    //     color: colorPrimary,
                                    //     borderRadius: BorderRadius.circular(5.r),
                                    //   ),
                                    //   child: Text(response[0].yoastHeadJson!.schema!.graph![0].articleSection!.join(' | ')).boldSized(8).colors(
                                    //     isThemeChange.mTheme
                                    //         ? colorWhite
                                    //         : colorWhite,
                                    //   ),
                                    // ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Text(
                      '${widget.posts!.title}',
                    ).blackSized(20).colors(
                          isThemeChange.mTheme ? darkThemeText : colorTextGray,
                        ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Container(
                      child: Text(
                        '${widget.posts!.contents}',
                      ).normalSized(13).colors(
                            isThemeChange.mTheme
                                ? darkThemeText
                                : colorTextGray,
                          ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    // Container(
                    //   child: Text(
                    //     response[0].yoastHeadJson!.ogUrl!,
                    //   ).normalSized(10).colors(isThemeChange.mTheme ? colorWhite : colorPrimary),
                    // ),
                  ],
                ),
              ),
            ),
          )
        ],
        // child: Column(
        //   children: <Widget>[
        //     Stack(
        //       children: <Widget>[
        //         Container(
        //           height: 300.h,
        //           decoration: BoxDecoration(
        //             borderRadius: const BorderRadius.only(
        //               bottomLeft: Radius.circular(33),
        //               bottomRight: Radius.circular(33),
        //             ),
        //             image: DecorationImage(
        //                 image: NetworkImage('${widget.posts!.image}'),
        //                 fit: BoxFit.cover),
        //           ),
        //         ),
        //       ],
        //     ),
        //     Padding(
        //       padding: const EdgeInsets.all(25.0),
        //       child: Column(
        //         crossAxisAlignment: CrossAxisAlignment.start,
        //         children: <Widget>[
        //           Text(
        //             '${widget.posts!.title}',
        //             style: TextStyle(
        //               fontSize: 23.sp,
        //               fontWeight: FontWeight.bold,
        //             ),
        //           ),
        //           const SizedBox(
        //             height: 10,
        //           ),
        //           Row(
        //             children: [
        //               Text(
        //                 '${displayTime(widget.posts!.time.toString())}',
        //                 style: const TextStyle(
        //                   color: Colors.grey,
        //                   fontWeight: FontWeight.bold,
        //                 ),
        //               ),
        //               const SizedBox(
        //                 width: 10,
        //               ),
        //               InkWell(
        //                 onTap: () async {
        //                   Posts post = Posts(
        //                     title: widget.posts!.title,
        //                     image: widget.posts!.image,
        //                     contents: widget.posts!.contents,
        //                     time: widget.posts!.time,
        //                     author: widget.posts!.author,
        //                   );
        //                   await storeData!.add(post);
        //                   Fluttertoast.showToast(
        //                     msg: 'Bookmarked!!!',
        //                     gravity: ToastGravity.BOTTOM,
        //                     toastLength: Toast.LENGTH_SHORT,
        //                   );
        //                 },
        //                 child: const Icon(
        //                   Icons.bookmark_border,
        //                 ),
        //               ),
        //             ],
        //           ),
        //           const SizedBox(
        //             height: 30,
        //           ),
        //           Text(
        //             '${widget.posts!.contents}',
        //             style: TextStyle(
        //               fontSize: 18.sp,
        //             ),
        //           ),
        //         ],
        //       ),
        //     ),
        //   ],
        // ),
      ),
    );
  }
}

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:wp_blog_app/components/component_style.dart';

import '../components/component_theme.dart';
import '../providers/theme_provider.dart';

class ArticleCardItem extends StatelessWidget {
  final int id;
  final String image;
  final String category;
  final String title;
  final String author;
  final DateTime createdAt;
  final Function onPress;
  final Function onLongPress;

  const ArticleCardItem({Key? key,
    required this.id,
    required this.image,
    required this.category,
    required this.title,
    required this.onPress,
    required this.author,
    required this.createdAt,
    required this.onLongPress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isThemeChange = Provider.of<ThemeProvider>(context);
    return GestureDetector(
      onTap: () => onPress(id),
      onLongPress: () => onLongPress(id),
      child: Column(
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(15.r),
                child: SizedBox(
                  width: 350.w,
                  height: 200.h,
                  child: CachedNetworkImage(
                    // imageUrl: trending[index].source.ogImage[0].url,
                    imageUrl:
                    image,
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
                                title,
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
                                Text(author
                                    .toUpperCase())
                                    .boldSized(10)
                                    .colors(colorTextGray)
                              ],
                            ),
                            // DateFormat.yMMMMEEEEd().format(date)
                            Text(DateFormat.yMMMMEEEEd().format(createdAt))
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
              Positioned(
                top: 15.h,
                left: 15.w,
                child: Container(
                  padding: EdgeInsets.symmetric(
                    vertical: 6.h,
                    horizontal: 17.w,
                  ),
                  decoration: BoxDecoration(
                    color: colorPrimary,
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: Text(category.toUpperCase())
                      .boldSized(11)
                      .colors(
                    isThemeChange.mTheme ? colorWhite : colorWhite,
                  ),
                ),
              ),

            ],
          ),
        ],
      ),
      // Container(
      //   width: 300,
      //   child: Card(
      //     elevation: 0,
      //     color: Colors.transparent,
      //     child: Column(
      //       children: <Widget>[
      //         ClipRRect(
      //           borderRadius: BorderRadius.all(
      //             Radius.circular(8),
      //           ),
      //           child: FadeInImage.assetNetwork(
      //             image: image,
      //             placeholder: 'assets/images/placeholder.png',
      //             width: double.infinity,
      //             height: 200,
      //             fit: BoxFit.cover,
      //           ),
      //         ),
      //         Padding(
      //           padding: EdgeInsets.all(8),
      //           child: Column(
      //             children: <Widget>[
      //               Align(
      //                 alignment: Alignment.centerLeft,
      //                 child: Text(
      //                   this.category.toUpperCase(),
      //                   style: Theme.of(context).textTheme.subtitle1,
      //                 ),
      //               ),
      //               SizedBox(height: 10),
      //               Align(
      //                 alignment: Alignment.centerLeft,
      //                 child: Text(
      //                   this.title,
      //                   maxLines: 2,
      //                   overflow: TextOverflow.ellipsis,
      //                   style: Theme.of(context).textTheme.subtitle1,
      //                 ),
      //               ),
      //             ],
      //           ),
      //         ),
      //       ],
      //     ),
      //   ),
      // ),
    );
  }
}

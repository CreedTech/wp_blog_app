import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:wp_blog_app/components/component_style.dart';

import '../components/component_theme.dart';
import '../providers/theme_provider.dart';

class ArticleListItem extends StatelessWidget {
  final int id;
  final String image;
  final String category;
  final String title;
  final String author;
  final Function onPress;
  final Function onLongPress;
  final String description;
  final DateTime date;

  const ArticleListItem({Key? key,
    required this.id,
    required this.image,
    required this.category,
    required this.title,
    required this.author,
    required this.onPress,
    required this.description,
    required this.onLongPress,
    required this.date,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isThemeChange = Provider.of<ThemeProvider>(context);
    return GestureDetector(
      onTap: () => onPress(id),
      onLongPress: () => onLongPress(id),
      child: Container(
        height: 120.h,

        // margin: EdgeInsets.only(top: 8.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.r),
          color: isThemeChange.mTheme
              ? colorsBlack
              : colorWhite,
          border: Border.all(
            color: isThemeChange.mTheme
                ? Colors.grey.withOpacity(0.2)
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
                  imageUrl: image,
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
                      title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ).boldSized(14).colors(
                        isThemeChange.mTheme
                            ? darkThemeText
                            : colorsBlack),
                  ),

                  SizedBox(
                    width: 220.w,
                    child: Text(description,
                      maxLines: 2,
                      textAlign: TextAlign.justify,
                      overflow: TextOverflow.ellipsis,
                    ).normalSized(12).colors(
                      isThemeChange.mTheme
                          ? darkThemeText
                          : colorsBlack,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(
                      vertical: 3.h,
                      horizontal: 6.w,
                    ),
                    decoration: BoxDecoration(
                      color: colorPrimary,
                      borderRadius:
                      BorderRadius.circular(5.r),
                    ),
                    child: Text(category.toUpperCase())
                        .boldSized(8)
                        .colors(
                      isThemeChange.mTheme
                          ? colorWhite
                          : colorWhite,
                    ),
                  ),
                  SizedBox(
                    width: 235.w,
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
                            Text(
                              author
                                  .toUpperCase(),
                              overflow: TextOverflow.ellipsis,
                            )
                                .boldSized(10)
                                .colors(colorTextGray)
                          ],
                        ),
                        Text(DateFormat.yMMMMEEEEd().format(date),overflow: TextOverflow.ellipsis,)
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
        // ListTile(
        //   title: Text(this.category),
        //   subtitle: Column(
        //     children: <Widget>[
        //       Text(
        //         this.title,
        //         maxLines: 3,
        //         softWrap: true,
        //         overflow: TextOverflow.ellipsis,
        //         style: Theme.of(context).textTheme.titleMedium,
        //       ),
        //       SizedBox(height: 5),
        //       Align(
        //         alignment: Alignment.bottomLeft,
        //         child: Text(
        //           timeago.format(date, locale: 'en'),
        //           maxLines: 1,
        //         ),
        //       ),
        //     ],
        //   ),
        //   dense: true,
        //   trailing: FadeInImage.assetNetwork(
        //     image: this.image,
        //     placeholder: 'assets/images/placeholder.png',
        //     width: 100,
        //     fit: BoxFit.cover,
        //   ),
        //   onTap: () => onPress(id),
        //   onLongPress: () => onLongPress(id),
        // ),
      ),
    );
  }
}

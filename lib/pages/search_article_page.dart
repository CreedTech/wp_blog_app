import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:wp_blog_app/components/component_style.dart';
import 'package:wp_blog_app/widgets/trending_skeleton_widget.dart';

import '../components/component_theme.dart';
import '../models/article.dart';
import '../providers/search_article.dart';
import '../providers/theme_provider.dart';
import 'details_page.dart';

class SearchArticlePage extends StatefulWidget {
  const SearchArticlePage({Key? key}) : super(key: key);

  @override
  State<SearchArticlePage> createState() => _SearchArticlePageState();
}

class _SearchArticlePageState extends State<SearchArticlePage> {
  final textController = TextEditingController();
  String searchTerm = '';
  bool queryState = false;
  List<Article>? articleList;
  bool progress = false;

  void _readArticle(BuildContext context, int id) {
    Navigator.of(context).pushNamed(DetailsPage.routeName, arguments: id);
  }



  @override
  Widget build(BuildContext context) {
    final isThemeChange = Provider.of<ThemeProvider>(context);
    return Material(
        child: Scaffold(
      backgroundColor: isThemeChange.mTheme ? colorsBlack : colorWhite,
      appBar: AppBar(
        toolbarHeight: 70,
        elevation: 0,
        backgroundColor: isThemeChange.mTheme ? colorsBlack : colorWhite,
        centerTitle: false,
        title:
            // AnimSearchBar(
            //   width: 400,
            //   textController: textController,
            //   onSuffixTap: (v) {
            //     if (v.length < 2) {
            //       articleList = null;
            //     }
            //   },
            //   onSubmitted: (v) {
            //     searchNews();
            //   },
            // ),
            //   TextField(
            //     cursorColor: Colors.grey,
            //     textCapitalization: TextCapitalization.words,
            //     textInputAction: TextInputAction.done,
            //
            //     decoration: InputDecoration(
            //       fillColor: Colors.white,
            //       filled: true,
            //       contentPadding:
            //       EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
            //       border: OutlineInputBorder(
            //           borderRadius: BorderRadius.all(Radius.circular(20.0)),
            //           borderSide: BorderSide.none),
            //       hintText: 'Search',
            //       hintStyle: TextStyle(fontSize: 17.0, color: Colors.grey),
            //       enabledBorder: OutlineInputBorder(
            //         borderSide: BorderSide(
            //             color: Theme.of(context).colorScheme.secondary,
            //             width: 1.0),
            //         borderRadius: BorderRadius.all(Radius.circular(20.0)),
            //       ),
            //       focusedBorder: OutlineInputBorder(
            //         borderSide: BorderSide(
            //             color: Theme.of(context).colorScheme.secondary,
            //             width: 2.0),
            //         borderRadius: BorderRadius.all(Radius.circular(20.0)),
            //       ),
            //       prefixIcon: Container(
            //         padding: EdgeInsets.all(15.0),
            //         child: Image.asset(
            //           'assets/icons/search.png',
            //           width: 20.0,
            //         ),
            //       ),
            //     ),
            //   ),
            // ),
            //     SizedBox(width: 10,),
            //     Container(
            //       height: 50,
            //       width: 50,
            //       padding: EdgeInsets.all(13),
            //       decoration: BoxDecoration(
            //           color: Theme.of(context).colorScheme.secondary,
            //           borderRadius: BorderRadius.circular(20)
            //       ),
            //       // child: Icon(Icons.filter_b_and_w_outlined,color: Colors.white,),
            //       child: Image.asset('assets/icons/filter.png'),
            //     )
            Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(25.0),
            boxShadow: [
              BoxShadow(
                offset: const Offset(1, 1),
                blurRadius: 10.0,
                color: Colors.grey.withOpacity(0.5),
              ),
            ],
          ),
          child: TextField(
            controller: textController,
            style: TextStyle(
                color: isThemeChange.mTheme ? colorWhite : colorsBlack),
            textInputAction: TextInputAction.search,
            decoration: InputDecoration(
                fillColor: isThemeChange.mTheme ? colorsBlack : colorWhite,
                filled: true,
                contentPadding: const EdgeInsets.symmetric(
                    vertical: 10.0, horizontal: 20.0),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20.r)),
                    borderSide: BorderSide.none),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.all(Radius.circular(20.r)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.all(Radius.circular(20.r)),
                ),
                prefixIcon: Container(
                  padding: EdgeInsets.all(15.r),
                  child: SvgPicture.asset(
                    'assets/icons/search_line.svg',
                    width: 20.w,
                    color: colorPrimary,
                  ),
                ),
                hintStyle: const TextStyle(color: textGray),
                hintText: "Search News , Author , Articles..."),
            cursorColor: isThemeChange.mTheme ? colorWhite : colorsBlack,
            onSubmitted: (v) {
              searchNews();
            },
            onChanged: (v) {
              if (v.length < 2) {
                searchNews();
              }
            },
          ),
        ),
        // actions: [
        //   ElevatedButton(
        //     onPressed: () => searchNews(),
        //     style: ElevatedButton.styleFrom(
        //       backgroundColor: isThemeChange.mTheme ? colorsBlack : colorWhite,
        //       elevation: 0,
        //     ),
        //     child: SvgPicture.asset(
        //       "assets/icons/search_line.svg",
        //       height: 24.h,
        //       width: 24.w,
        //       color: isThemeChange.mTheme ? darkThemeText : colorsBlack,
        //     ),
        //   ),
        // ],
        // title: Column(
        //   crossAxisAlignment: CrossAxisAlignment.start,
        //   children: [
        //     const Text(
        //       "Discover",
        //     ).blackSized(26).colors(
        //       isThemeChange.mTheme ? darkThemeText : colorTextGray,
        //     ),
        //     const Text("Search all news around the world").boldSized(10).colors(
        //       isThemeChange.mTheme ? darkThemeText : colorTextGray,
        //     ),
        //   ],
        // ),
      ),
      // appBar: AppBar(
      //   title: TextField(
      //     controller: textController,
      //     style: const TextStyle(color: Colors.white),
      //     textInputAction: TextInputAction.search,
      //     decoration: const InputDecoration(
      //         hintStyle: TextStyle(color: Colors.white),
      //         hintText: "Search News , Author , Articles..."),
      //     cursorColor: Colors.white,
      //     onSubmitted: (v) {
      //       searchNews();
      //     },
      //     onChanged: (v) {
      //       if (v.length < 2) {
      //         articleList = null;
      //       }
      //     },
      //   ),
      // ),
      body: Container(
        child: textController.text.length > 2
            ? _newsLoader()
            : Container(
                margin: const EdgeInsets.only(top: 200),
                child: Center(
                    child: Column(
                  children: <Widget>[
                    const Icon(
                      Icons.search,
                      size: 100,
                      color: colorPrimary,
                    ),
                    Text(
                      "Search Articles",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color:
                              isThemeChange.mTheme ? colorWhite : colorsBlack),
                    )
                  ],
                )),
              ),
      ),
    ));
  }

  searchNews() {
    if (textController.text.length > 2) {
      setState(() {
        progress = true;
      });
      SearchArticlesProvider(searchTerm)
          .fetchSearchedArticles(searchTerm)
          .then((value) {
        setState(() {
          articleList = value;
          progress = false;
        });
      });
    }
    if (textController.text.length < 2) {
      setState(() {
        articleList = null;
      });
    }
  }

  Widget _newsLoader() {
    final isThemeChange = Provider.of<ThemeProvider>(context);
    return ListView(
      children: <Widget>[
        Container(
          padding: const EdgeInsets.only(left: 10, top: 10),
          child: Text(
            "Search result for - ${textController.text}",
            style: const TextStyle(fontSize: 16),
          ),
        ),
        const Divider(),
        ListView.builder(
          shrinkWrap: true,
          physics: const ScrollPhysics(),
          itemCount: articleList != null ? articleList!.length : 1,
          itemBuilder: (BuildContext context, int index) {
            if (progress) {
              List loading = [1, 2, 3, 4, 5, 6];
              return SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  children: loading
                      .asMap()
                      .map(
                        (index, value) => MapEntry(
                          index,
                          Padding(
                            padding: EdgeInsets.only(
                              left: 15.w,
                              right: 15.w,
                              bottom: 4.h,
                              top: index == 0 ? 20.h : 4.h,
                            ),
                            child: Shimmer.fromColors(
                              baseColor: isThemeChange.mTheme
                                  ? Colors.white
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
              return GestureDetector(
                onTap: () {
                  // _readArticle(context, articleList![index].id);
                },
                // => Guide.to(
                //   name: detail,
                //   arguments: articleList![index],
                // ),
                child: Container(
                  height: 120.h,
                  margin: EdgeInsets.only(
                    left: 7.w,
                    right: 7.w,
                    // bottom: 4.h,
                    // top: index == 0 ? 4.h : 4.h,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.r),
                    color: isThemeChange.mTheme ? colorsBlack : colorWhite,
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
                            imageUrl: articleList![index].banner,
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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 220.w,
                              child: Text(
                                articleList![index].title,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ).boldSized(14).colors(isThemeChange.mTheme
                                  ? darkThemeText
                                  : colorsBlack),
                            ),
                            SizedBox(
                              width: 220.w,
                              child: Text(
                                articleList![index].description,
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
                                borderRadius: BorderRadius.circular(5.r),
                              ),
                              child: Text(articleList![index]
                                      .category
                                      .toUpperCase())
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
                                        articleList![index]
                                            .author
                                            .toUpperCase(),
                                        overflow: TextOverflow.ellipsis,
                                      ).boldSized(10).colors(colorTextGray)
                                    ],
                                  ),
                                  Text(
                                    DateFormat.yMMMMEEEEd()
                                        .format(articleList![index].createdAt),
                                    overflow: TextOverflow.ellipsis,
                                  ).boldSized(10).colors(colorTextGray),
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
              //   ListTile(
              //   onTap: () {
              //     // Navigator.push(
              //     //     context,
              //     //     MaterialPageRoute(
              //     //         builder: (context) => DisplayArticle(
              //     //             Utils()
              //     //                 .parseHTML(articleList[index].title.rendered),
              //     //             articleList[index].embedded.media[0].sourceLink,
              //     //             articleList[index].categories[0],
              //     //             articleList[index].date,
              //     //             articleList[index].link,
              //     //             Utils().parseHTML(
              //     //                 articleList[index].content.rendered),
              //     //             articleList[index].id)));
              //   },
              //   leading: Image.network(
              //     articleList![index].banner,
              //     width: 80,
              //     height: 120,
              //   ),
              //   title: Text(
              //     articleList![index].title,
              //     style: const TextStyle(fontWeight: FontWeight.bold),
              //   ),
              //   subtitle: Row(
              //     mainAxisAlignment: MainAxisAlignment.start,
              //     children: <Widget>[
              //       Container(
              //         decoration: BoxDecoration(
              //             color: Colors.black12,
              //             borderRadius: BorderRadius.circular(10)),
              //         margin: const EdgeInsets.only(top: 5, left: 5),
              //         padding: const EdgeInsets.symmetric(
              //             vertical: 5, horizontal: 5),
              //         child: Text(
              //           DateFormat.yMMMMEEEEd()
              //               .format(articleList![index].createdAt),
              //           style: const TextStyle(fontSize: 10),
              //         ),
              //       ),
              //     ],
              //   ),
              // );
            }
          },
        )
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;
}

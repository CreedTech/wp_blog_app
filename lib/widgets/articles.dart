import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';
import 'package:shimmer/shimmer.dart';
import 'package:wp_blog_app/helpers/helper_routes_parh.dart';
import 'package:wp_blog_app/pages/settings.dart';
import 'package:wp_blog_app/widgets/refresh_button.dart';
import 'package:wp_blog_app/widgets/trending_skeleton_widget.dart';
import 'dart:math' as Math;


import '../components/component_theme.dart';
import '../models/article.dart';
import '../pages/details_page.dart';
import '../providers/articles.dart';
import '../providers/categories.dart';
import '../providers/theme_provider.dart';
import '../providers/user.dart';
import 'article_card_item.dart';
import 'article_list_item.dart';
import 'article_options.dart';

class Articles extends StatefulWidget {
  const Articles({Key? key}) : super(key: key);

  @override
  _ArticlesState createState() => _ArticlesState();
}

class _ArticlesState extends State<Articles> {
  final _headlinesCount = 3;
  final Map<int, Future<List<Article>>> _articlesFutures = {};
  var _isLoadingNextPage = false;
  static const routeName = 'details';

  void _readArticle(BuildContext context, int id) {
    Navigator.of(context).pushNamed(routeName, arguments: id);
    // Navigator.pushNamed(context, '/detail_page',
    //     arguments: id);


    // Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => DetailsPage()));
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
      duration: const Duration(seconds: 3),
      backgroundColor: colorPrimary,
    ));
  }

  void _showOptions(BuildContext context, int id, String link) {
    showModalBottomSheet(
      context: context,
      builder: (ctx) => ArticleOptions(
        id: id,
        bookmark: _bookmark,
        hideStory: _hideStory,
        share: _share,
        addFavorite: _addFavorite, link: link,
      ),
    );
  }

  void _bookmark(int id) {
    Navigator.of(context).pop();
    var userProvider = Provider.of<UserProvider>(context, listen: false);
    if (!userProvider.isBookmarked(id)) {
      userProvider.addBookmark(id);
      _showMessage(
        'Added To Favourites!!!',
      );
    }
  }

  void _hideStory(int id) {
    Navigator.of(context).pop();
    var userProvider = Provider.of<UserProvider>(context, listen: false);
    userProvider.hideArticle(id);
    _showMessage('Hidden Successfully!');
  }

  void _share(int id) async {
    // Navigator.of(context).pop();
    var article = Provider.of<ArticlesProvider>(
      context,
      listen: false,
    ).findById(id);
    await Share.share(
      article.title,
      subject: 'Article',
    );
  }

  void _addFavorite(int id) {
    Navigator.of(context).pop();
    var userProvider = Provider.of<UserProvider>(context, listen: false);
    if (!userProvider.isFavorite(id)) {
      userProvider.addFavorite(id);
      _showMessage(
        'Added To Favourites!!!',
      );
    } else {
      _showMessage('Deleted From Your Favourite Articles!!!',);
    }
  }

  Widget _buildArticlesCarousel({
    required List<Article> data,
    required Function onPressed,
    required Function onLongPress,
  }) {
    var carouselCount = Math.min(_headlinesCount, data.length);
    var articles = data.sublist(0, carouselCount);
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10.w),
      height: 50.h,
      width: 360.w,
      child: ListView.builder(
          shrinkWrap: true,
          primary: false,
          scrollDirection: Axis.horizontal,
          itemCount: carouselCount,
          itemBuilder: (_, index) {
            var cardItem = articles[index];
            return ArticleCardItem(
              id: cardItem.id,
              title: cardItem.title,
              category: cardItem.category,
              image: cardItem.banner,
              onPress: onPressed,
              onLongPress: onLongPress, createdAt: cardItem.createdAt,
              author: cardItem.author,
            );
          }),
    );
  }

  Widget _buildArticlesList({
    required List<Article> data,
    required Function onPressed,
    required Function onLongPress,
  }) {
    var carouselCount = Math.min(_headlinesCount, data.length);
    var articles = data.sublist(carouselCount);
    return ListView.builder(
        shrinkWrap: true,
        primary: false,
        itemCount: articles.length,
        itemBuilder: (_, index) {
          var cardItem = articles[index];
          return Container(
            height: 100,
            margin: EdgeInsets.only(top: 8.h),
            child: ArticleListItem(
              id: cardItem.id,
              title: cardItem.title,
              category: cardItem.category,
              image: cardItem.banner,
              author: cardItem.author,
              onPress: onPressed,
              date: cardItem.createdAt,
              onLongPress: onLongPress, description: cardItem.description,
            ),
          );
        });
  }

  void _nextPage() async {
    var articlesProvider = Provider.of<ArticlesProvider>(
      context,
      listen: false,
    );
    setState(() {
      _isLoadingNextPage = true;
    });
    await articlesProvider.nextPage();
    setState(() {
      _isLoadingNextPage = false;
    });
  }

  Future<List<Article>>? _buildArticlesFuture(int categoryId) {
    if (_articlesFutures[categoryId] != null) {
      return _articlesFutures[categoryId];
    }
    var articlesProvider = Provider.of<ArticlesProvider>(context);
    var articlesFuture = articlesProvider.fetchArticles(categoryId);
    _articlesFutures[categoryId] = articlesFuture;
    return articlesFuture;
  }

  @override
  Widget build(BuildContext context) {
    var articlesProvider = Provider.of<ArticlesProvider>(context);
    var categoriesProvider = Provider.of<CategoriesProvider>(context);
    final isThemeChange = Provider.of<ThemeProvider>(context);
    if (categoriesProvider.currentCategory == null) {
      return Container(
        height: 550.h,
        width: double.infinity,
        decoration: BoxDecoration(
          color: isThemeChange.mTheme ? colorsBlack : colorWhite,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children:  const [
            Center(
              child: CircularProgressIndicator(
                backgroundColor: colorPrimary,
                color: textGray,
              ),
            ),
            // Spacer(),
            // RefreshButton(
            //   text: 'Refresh',
            //   onPressed: () {
            //     articlesProvider.refresh();
            //     print(articlesProvider.articles);
            //   },
            // ),
          ],
        ),
      );
    }

    return FutureBuilder(
      future: _buildArticlesFuture(categoriesProvider.currentCategory!.id),
      builder: (ctx, snapshot) =>
          snapshot.connectionState == ConnectionState.waiting
              ? const CircularProgressIndicator(
            backgroundColor: colorPrimary,
            color: textGray,
          )
              : snapshot.hasError
                  ? Text(snapshot.error.toString())
                  : Column(
                      children: <Widget>[
                        Container(
                          height: 250,
                          margin: const EdgeInsets.only(left: 8.0),
                          child: _buildArticlesCarousel(
                              data: articlesProvider.articles,
                              onPressed: (id) => _readArticle(ctx, id),
                              onLongPress: (id,link) => _showOptions(ctx, id,link)),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: _buildArticlesList(
                              data: articlesProvider.articles,
                              onPressed: (id) => _readArticle(ctx, id),
                              onLongPress: (id,link) => _showOptions(ctx, id, link)),
                        ),
                        const SizedBox(height: 20),
                        if (articlesProvider.articles.isEmpty)
                          const Center(
                            child: Text('No News in this category'),
                          )
                        else if (!_isLoadingNextPage)
                          TextButton(
                            onPressed: _nextPage,
                            child: const Text('Load More',style: TextStyle(color: colorPrimary),),
                          )
                        else
                          const CircularProgressIndicator(
                            backgroundColor: colorPrimary,
                            color: textGray,
                          ),
                        const SizedBox(height: 20),
                      ],
                    ),
    );
  }
}

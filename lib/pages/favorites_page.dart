import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:wp_blog_app/components/component_style.dart';

import '../components/component_theme.dart';
import '../providers/articles.dart';
import '../providers/theme_provider.dart';
import '../providers/user.dart';
import '../widgets/article_list_item.dart';
import 'details_page.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({Key? key}) : super(key: key);

  void _showMessage(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
      duration: const Duration(seconds: 3),
    ));
  }

  _deleteFavorite(BuildContext context, int id) {
    var userProvider = Provider.of<UserProvider>(context, listen: false);
    userProvider.deleteFavorite(id);
    _showMessage(
      context,
      'Deleted From Your Favourite Articles!!!',
    );
  }

  void _readArticle(BuildContext context, int id) {
    Navigator.of(context).pushNamed(DetailsPage.routeName, arguments: id);
  }

  @override
  Widget build(BuildContext context) {
    var articlesProvider = Provider.of<ArticlesProvider>(context);
    final isThemeChange = Provider.of<ThemeProvider>(context);

    return Scaffold(
      backgroundColor: isThemeChange.mTheme ? colorsBlack : colorWhite,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            AppBar(
              backgroundColor: isThemeChange.mTheme ? colorsBlack : colorWhite,
              elevation: 0,
              title: Text(
                'Your Favourite News',
                style: TextStyle(
                  color: isThemeChange.mTheme ? colorWhite : colorsBlack,
                ),
              ),
              centerTitle: true,
              // actions: <Widget>[
              //   IconButton(
              //     icon: Icon(
              //       Icons.search,
              //     ),
              //     onPressed: () {},
              //   )
              // ],
            ),
            Consumer<UserProvider>(
              builder: (_, userProvider, child) =>
              userProvider.favorites != null &&
                  userProvider.favorites.length == 0
                      ? SizedBox(
                          height: 700.h,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset(
                                "assets/icons/empty.svg",
                                width: 100.w,
                                height: 200.h,
                                // color: colorPrimary,
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
                        )
                      : ListView.builder(
                          shrinkWrap: true,
                          primary: false,
                          itemBuilder: (_, index) {
                            var article = articlesProvider.findById(
                              userProvider.favorites[index],
                            );
                            return Dismissible(
                              key: ValueKey(article.id),
                              direction: DismissDirection.endToStart,
                              onDismissed: (_) => _deleteFavorite(
                                context,
                                article.id,
                              ),
                              background: Container(
                                  color: Colors.red,
                                  child: Container(
                                    padding: const EdgeInsets.only(right: 20),
                                    alignment: Alignment.centerRight,
                                    child: const Icon(
                                      Icons.delete,
                                      color: Colors.white,
                                    ),
                                  )),
                              child: ArticleListItem(
                                category: article.category,
                                author: article.author,
                                id: article.id,
                                image: article.banner,
                                title: article.title,
                                onPress: (id) => _readArticle(context, id),
                                onLongPress: () {},
                                date: article.createdAt,
                                description: article.description,
                              ),
                            );
                          },
                          itemCount: userProvider.favorites.length,
                        ),
            )
          ],
        ),
      ),
    );
  }
}

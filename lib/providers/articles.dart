import 'package:flutter/material.dart';
import 'package:html/parser.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


import '../constants.dart';
import '../models/article.dart';

class ArticlesProvider with ChangeNotifier {
  final _pageSize = 20;
  late int _page;
  int? _categoryId;
  // var dio = Dio();
  // final  https = NetworkContainerImpl(dio: Dio());
  // final NetworkContainer https;



  final List<Article> _articles = [];
  static const headers = {"Accept": "application/json"};

  // ArticlesProvider(this.https);


  String _parseHtmlString(String htmlString) {
    var document = parse(htmlString);

    String parsedString = parse(document.body!.text).documentElement!.text;

    return parsedString;
  }


  Future<List<Article>> fetchArticles(int categoryId, [int page = 1]) async {
    _page = page;
    if (categoryId != _categoryId) {
      _categoryId = categoryId;
      _articles.clear();
    }
    final categoryQuery = categoryId > 0 ? '&categories=$categoryId' : '';
    final url =
        '${Constants['API_BASE_URL']}/posts?_embed&per_page=$_pageSize&page=$_page&_embed&$categoryQuery';
    try {
      var response = await http.get(Uri.parse(url),headers: headers,);
      // final response = await https.method(
      //   path:
      //   url,
      //   methodType: MethodType.get,
      // );
      var data = jsonDecode(response.body);
      print(data);
      _articles.addAll(_formatArticle(data, categoryId));
      return Future.value(_articles);
    } catch (e) {
      print(e);
      return Future.error('An error occurred here');
    }
  }

  Future<void> refresh() async {
    _articles.clear();
    notifyListeners();
    await fetchArticles(_categoryId!, 1);
  }

  Future<void> nextPage() async {
    await fetchArticles(_categoryId!, _page + 1);
  }

  Article findById(int id) =>
      _articles.firstWhere((article) => article.id == id);

  List<Article> _formatArticle(List<dynamic> jsonData, int categoryId) {
    return jsonData.map((json) {
      var embedded = json['_embedded'];

      Map<String, dynamic>? media;
      try {
        media = embedded['wp:featuredmedia'][0]['media_details']['sizes'];
      } catch (e) {}

      return Article(
        id: json['id'],
        author: json['yoast_head_json']['author'],
        banner: media == null ? '' : media['full']['source_url'],
        thumbnail: media == null ? '' : media['thumbnail']['source_url'],
        title: _parseHtmlString(json['title']['rendered']),
        category: embedded['wp:term'][0]
            .lastWhere((term) => term['taxonomy'] == 'category')['name'],
        description: _parseHtmlString(json['content']['rendered']),
        htmlContent: _parseHtmlString(json['content']['rendered']),
        createdAt: DateTime.parse(json['date']),
        link: json['link'],
        tag: '',
      );
    }).toList();
  }

  List<Article> get articles => [..._articles];
}

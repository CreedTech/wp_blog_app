import 'package:flutter/material.dart';
import 'package:html/parser.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


import '../constants.dart';
import '../models/article.dart';
import '../network/network_dio.dart';

class SearchArticlesProvider {
  final _pageSize = 20;
   int _page = 1;
  int? _categoryId;
  // var dio = Dio();
  // final  https = NetworkContainerImpl(dio: Dio());
  // final NetworkContainer https;
  String searchTerm;

  SearchArticlesProvider(this.searchTerm);


  final List<Article> _articles = [];
  static const headers = {"Accept": "application/json"};

  // SearchArticlesProvider(this.https);


  String _parseHtmlString(String htmlString) {
    var document = parse(htmlString);

    String parsedString = parse(document.body!.text).documentElement!.text;

    return parsedString;
  }


  Future<List<Article>> fetchSearchedArticles(String searchTerm, [int page = 1]) async {
    _page = page;
    // if (categoryId != _categoryId) {
    //   _categoryId = categoryId;
    //   _articles.clear();
    // }
    // final categoryQuery = categoryId > 0 ? '&categories=$categoryId' : '';
    final url =
        '${Constants['API_BASE_URL']}/posts?search=$searchTerm&_embed&per_page=$_pageSize&page=$_page';
    try {
      var response = await http.get(Uri.parse(url),headers: headers,);
      // final response = await https.method(
      //   path:
      //   url,
      //   methodType: MethodType.get,
      // );
      var data = jsonDecode(response.body);
      print(data);
      _articles.addAll(_formatSearchedArticle(data, searchTerm));
      return Future.value(_articles);
    } catch (e) {
      print(e);
      return Future.error('An error occurred here');
    }
  }

  Future<void> refresh() async {
    _articles.clear();
    // notifyListeners();
    await fetchSearchedArticles(searchTerm, 1);
  }

  Future<void> nextPage() async {
    await fetchSearchedArticles(searchTerm, _page + 1);
  }

  // Article findById(int id) =>
  //     _articles.firstWhere((article) => article.id == id);

  List<Article> _formatSearchedArticle(List<dynamic> jsonData, String searchTerm) {
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

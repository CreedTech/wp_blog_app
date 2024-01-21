import 'package:flutter/material.dart';
import 'package:html/parser.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;


import '../constants.dart';
import '../models/article_category.dart';
import '../network/network_dio.dart';


class CategoriesProvider extends ChangeNotifier {
  List<ArticleCategory>? _categories;
  static const headers = {"Accept": "application/json"};
  // List<ArticleCategory> _allCategories;
  // var dio = Dio();
  // final  https = NetworkContainerImpl(dio: Dio());
  // var Dio dio;

  var _categoriesDisplayCount = 30;
  int? _selectedCategoryId;
  // CategoriesProvider(this.https);

  String _parseHtmlString(String htmlString) {
    var document = parse(htmlString);

    String parsedString = parse(document.body!.text).documentElement!.text;

    return parsedString;
  }

  Future<List<ArticleCategory>> fetchAllCategories() async {

    final url = '${Constants['API_BASE_URL']}/categories?_embed&per_page=100';
    try {
      var response = await http.get(Uri.parse(url),headers: headers,);
      // final response = await https.method(
      //   path:
      //   url,
      //   methodType: MethodType.get,
      // );
      var data = json.decode(response.body);
      print(data);
      _categories = _formatArticleCategory(data);
      // print("===================");
      // print(_categories);
      if (_selectedCategoryId == null) {
        _selectedCategoryId = categories.first.id;
        notifyListeners();
      }
      return Future.value(_categories);
    } catch (e) {
      print(e);
      return Future.error('An error occurred');
    }
  }

  List<ArticleCategory> _formatArticleCategory(dynamic jsonData) {
    List<ArticleCategory> categories = [];
    for (var index = 0; index < jsonData.length; index++) {
      var json = jsonData[index];
      categories.add(ArticleCategory(
        id: json['id'],
        name: _parseHtmlString(json['name']),
        count: json['count'],
      ));
    }
    categories.sort(
      (current, other) => other.count.compareTo(current.count),
    );
    return categories;
  }

  void selectCategory(int id) {
    _selectedCategoryId = id;
    notifyListeners();
  }

  List<ArticleCategory> get categories => _categories != null
      ? _categories!.take(_categoriesDisplayCount).toList()
      : [];

  List<ArticleCategory> get allCategories => _categories ?? [];

  ArticleCategory? get currentCategory =>
      _selectedCategoryId == null ? null : findById(_selectedCategoryId!) ;

  ArticleCategory? findById(int id) => id == null
      ? null
      : categories.firstWhere((category) => category.id == id);

  bool isSelected(ArticleCategory category) =>
      category.id == _selectedCategoryId;
}

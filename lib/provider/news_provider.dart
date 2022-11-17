import 'dart:collection';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:news_app/constants/urls.dart';
import 'package:news_app/models/news_model.dart';

class NewsProvider extends ChangeNotifier {
  Map<String, dynamic> _map = {};
  Map<String, dynamic> _latestNews = {};
  Map<String, dynamic> _categoryData = {};
  bool _error = false;
  String _errorMessage = '';

 


  //getter method
  Map<String, dynamic> get map => _map;
  Map<String, dynamic> get latestNews => _latestNews;
  Map<String, dynamic> get categoryData => _categoryData;
  bool get error => _error;
  String get errorMessage => _errorMessage;


  Future<void> get fetchData async {
    final response = await http.get(
      Uri.parse(
        getNewsApi,
      ),
    );
    if(response.statusCode == 200){
      try{
        _map = jsonDecode(response.body);
        _error = false;

      } catch(ex){
        _error = true;
        _errorMessage = ex.toString();
        _map = {};

      } 
    } else{
      _error = true;
      _errorMessage = 'Error: It could be your internet connection';
    _map = {};
    }
    notifyListeners();
  }

  void initialValue(){
    _map = {};
    _latestNews = {};
    _categoryData = {};
    
    _error = false;
    _errorMessage = '';

    notifyListeners();
  }

  Future<void> get fetchUSNewsData async {
    final response = await http.get(
      Uri.parse(
        getUSNewsApi,
      ),
    );
    if(response.statusCode == 200){
      try{
        _latestNews = jsonDecode(response.body);
        _error = false;

      } catch(ex){
        _error = true;
        _errorMessage = ex.toString();
        _latestNews = {};

      } 
    } else{
      _error = true;
      _errorMessage = 'Error: It could be your internet connection';
      _latestNews = {};
    }
    notifyListeners();
  }

   Future<void> fetchCategoryData(String categoryTitle) async {
    String url = '';
    if(categoryTitle == 'Top News'){
      url = getUSNewsApi;
    } else if(categoryTitle == 'World'){
      url = getWorldNewsApi;
    } else if(categoryTitle == 'Finance'){
      url = getFinanceNewsApi;
    } else if(categoryTitle == 'Health'){
      url = getHealthNewsApi;
    }

     else{
      url = getNewsApi;
    }
    final response = await http.get(
      Uri.parse(
        url
      ),
    );
    if(response.statusCode == 200){
      try{
        _categoryData = jsonDecode(response.body);
        _error = false;

      } catch(ex){
        _error = true;
        _errorMessage = ex.toString();
        _categoryData = {};


      } 
    } else{
      _error = true;
      _errorMessage = 'Error: It could be your internet connection';
      _categoryData = {};
    }
    notifyListeners();
  }

  
}

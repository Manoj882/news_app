import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:news_app/constants/urls.dart';

class NewsProvider extends ChangeNotifier {
  Map<String, dynamic> _map = {};
  bool _error = false;
  String _errorMessage = '';

  //getter method
  Map<String, dynamic> get map => _map;
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
    _error = false;
    _errorMessage = '';
    notifyListeners();
  }
}

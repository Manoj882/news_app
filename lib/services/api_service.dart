import 'dart:convert';

import 'package:news_app/constants/urls.dart';
import 'package:news_app/models/news_model.dart';
import 'package:http/http.dart' as http;

class ApiService{
  

  Future<List<NewsModel>> getNews() async{
    
    final response = await http.get(Uri.parse(getNewsApi));
    
    Map<String, dynamic> data = jsonDecode(response.body);

    List<NewsModel> _newsModelList =[];

    if(response.statusCode == 200){
      for(var item in data['articles']){
        NewsModel _newsModel = NewsModel.fromJson(item);
        _newsModelList.add(_newsModel);
        
      }
      return _newsModelList;
      
    } else{
      return  _newsModelList;
    }
  }
  
}
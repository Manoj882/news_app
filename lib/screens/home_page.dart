import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:news_app/constants/constant.dart';
import 'package:http/http.dart' as http;
import 'package:news_app/constants/urls.dart';
import 'package:news_app/models/news_model.dart';
import 'package:news_app/services/api_service.dart';
import 'package:provider/provider.dart';

import '../provider/news_provider.dart';
import 'news_screen.dart';

class HomePageScreen extends StatelessWidget {
  const HomePageScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<NewsProvider>().fetchData;
    return Scaffold(
      appBar: AppBar(
        title: Text('News App'),
      ),
      body: RefreshIndicator(
        onRefresh: () async {},
        child: Center(
          child: Consumer<NewsProvider>(
            builder: ((context, data, child) {
              return data.map.length == 0 && !data.error
                  ? const CircularProgressIndicator()
                  : data.error
                      ? Text(
                          'Oops, something went wrong. ${data.errorMessage}',
                          textAlign: TextAlign.center,
                        )
                      : ListView.builder(
                          itemCount: data.map.length,
                          itemBuilder: (context, index) {
                            return NewsCard(
                              map: data.map['articles'][index],
                            );
                          },
                          shrinkWrap: true,
                          primary: false,
                        );
            }),
          ),
        ),
      ),
    );
  }
}

class NewsCard extends StatelessWidget {
  const NewsCard({required this.map, Key? key}) : super(key: key);

  final Map<String, dynamic> map;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Padding(
        padding: basePadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${map['title']}',
              style: Theme.of(context).textTheme.headline6,
              textAlign: TextAlign.justify,
            ),
            const SizedBox(
              height: 10,
            ),
            Image.network('${map['urlToImage']}'),
            const SizedBox(
              height: 10,
            ),
            Text(
              '${map['description']}',
              textAlign: TextAlign.justify,
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}

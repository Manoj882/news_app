import 'package:flutter/material.dart';
import 'package:news_app/screens/wev_views_screen.dart';
import 'package:provider/provider.dart';

import '../provider/news_provider.dart';

class CategoryScreen extends StatefulWidget {
  CategoryScreen({required this.newsCategoryTitle, Key? key}) : super(key: key);

  String newsCategoryTitle;

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  @override
  Widget build(BuildContext context) {
    context.read<NewsProvider>().fetchCategoryData(widget.newsCategoryTitle);
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.newsCategoryTitle),
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            child: Center(
              child: Consumer<NewsProvider>(builder: (context, data, child) {
                return data.categoryData.isEmpty && !data.error
                    ? const CircularProgressIndicator()
                    : data.error
                        ? Text(
                            'Oops, something went wrong. ${data.errorMessage}',
                            textAlign: TextAlign.center,
                          )
                        : ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: data.categoryData.length,
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => WebViewsScreen(
                                        newsUrl: data.categoryData['articles'][index]['url'],
                                      ),
                                    ),
                                  );
                                },
                                child: CategoryNewsCard(
                                  newsData: data.categoryData['articles'][index],
                                ),
                              );
                            },
                          );
              }),
            ),
          ),
        ),
      ),
    );
  }
}

class CategoryNewsCard extends StatelessWidget {
  const CategoryNewsCard({required this.newsData, Key? key}) : super(key: key);
  final Map<String, dynamic> newsData;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        elevation: 1,
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.network('${newsData['urlToImage']}'),
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                padding: const EdgeInsets.fromLTRB(
                  15,
                  15,
                  10,
                  8,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  gradient: LinearGradient(
                    colors: [
                      Colors.black12.withOpacity(0),
                      Colors.black,
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      '${newsData['title']}',
                      maxLines: 3,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '${newsData['description']}',
                      maxLines: 3,
                      textAlign: TextAlign.justify,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

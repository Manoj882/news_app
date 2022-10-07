import 'package:flutter/material.dart';
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
            child: Consumer<NewsProvider>(builder: (context, data, child) {
              return data.categoryData.isEmpty && !data.error
                  ? const CircularProgressIndicator()
                  : data.error
                      ? Text(
                          'Oops, something went wrong. ${data.errorMessage}',
                          textAlign: TextAlign.center,
                        )
                      : ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: data.categoryData.length,
                          itemBuilder: (context, index) {
                            return CategoryNewsCard(
                              newsData: data.categoryData['articles']
                                  [index],
                            );
                          },
                        );
            }),
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
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
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
                padding: EdgeInsets.fromLTRB(
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
                  children: [
                    Text(
                      '${newsData['title']}',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '${newsData['description']}',
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

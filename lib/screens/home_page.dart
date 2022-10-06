import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:news_app/constants/constant.dart';

import 'package:provider/provider.dart';

import '../provider/news_provider.dart';

class HomePageScreen extends StatefulWidget {
  const HomePageScreen({Key? key}) : super(key: key);

  @override
  State<HomePageScreen> createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {
  TextEditingController searchController = TextEditingController();
  List<String> categoryItem = ['Top News', 'India', 'World', 'Finance', 'Health'];
  CarouselController buttonCarouselController = CarouselController();
  @override
  Widget build(BuildContext context) {
    context.read<NewsProvider>().fetchData;
    return Scaffold(
      appBar: AppBar(
        title: Text('News App'),
      ),
      body: RefreshIndicator(
        onRefresh: () async {},
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8),
                margin: EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        if ((searchController.text).replaceAll(' ', '') == '') {
                          print('Blank search');
                        } else {}
                      },
                      child: Container(
                        margin: EdgeInsets.fromLTRB(3, 0, 7, 0),
                        child: Icon(
                          Icons.search,
                          color: Colors.blueAccent,
                        ),
                      ),
                    ),
                    Expanded(
                      child: TextField(
                        controller: searchController,
                        textInputAction: TextInputAction.search,
                        onSubmitted: (value) {
                          print(value);
                        },
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Search',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: 50,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: categoryItem.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        print(categoryItem[index]);
                      },
                      child: Container(
                        padding: EdgeInsets.all(10),
                        margin: EdgeInsets.symmetric(horizontal: 5),
                        decoration: BoxDecoration(
                          color: Colors.blueAccent,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Center(
                          child: Text(
                            categoryItem[index],
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              Consumer<NewsProvider>(
                builder: ((context, data, child) {
                  return data.map.isEmpty && !data.error
                      ? const CircularProgressIndicator()
                      : data.error
                          ? Text(
                              'Oops, something went wrong. ${data.errorMessage}',
                              textAlign: TextAlign.center,
                            )
                          : CarouselSlider.builder(
                            carouselController: buttonCarouselController,
                            options: CarouselOptions(
                              autoPlay: false,
                              height: 400,
                              enableInfiniteScroll: false,
                              aspectRatio: 16/9,
                              enlargeCenterPage: true,
                              scrollDirection: Axis.horizontal,

                            ),

                              itemCount: data.map.length,
                              itemBuilder: (BuildContext context, int itemIndex, int pageViewIndex) {
                                return NewsCard(
                                  map: data.map['articles'][itemIndex],
                                );
                              },
                              
                            );
                }),
              ),
            ],
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
            
          ],
        ),
      ),
    );
  }
}

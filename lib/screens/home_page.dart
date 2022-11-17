import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:news_app/constants/constant.dart';
import 'package:news_app/screens/category_screen.dart';
import 'package:news_app/screens/latest_news_screen.dart';

import 'package:provider/provider.dart';

import '../provider/news_provider.dart';

class HomePageScreen extends StatefulWidget {
  const HomePageScreen({Key? key}) : super(key: key);

  @override
  State<HomePageScreen> createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {
  TextEditingController searchController = TextEditingController();
  List<String> categoryItem = ['Top News', 'USA', 'World', 'Finance', 'Health'];
  CarouselController buttonCarouselController = CarouselController();

  @override
  Widget build(BuildContext context) {
    context.read<NewsProvider>().fetchData;
    context.read<NewsProvider>().fetchUSNewsData;
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5FA),
      appBar: AppBar(
        title: const Text('News App'),
        centerTitle: true,
        elevation: 0,
        backgroundColor: const Color(0xFFF5F5FA),
        foregroundColor: Colors.black54,
      ),
      body: RefreshIndicator(
        onRefresh: () async {},
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                margin:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
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
                        } else {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CategoryScreen(
                                  newsCategoryTitle: searchController.text),
                            ),
                          );
                        }
                      },
                      child: Container(
                        margin: const EdgeInsets.fromLTRB(3, 0, 7, 0),
                        child: const Icon(
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
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  CategoryScreen(newsCategoryTitle: value),
                              ),
                          );
                        },
                        decoration: const InputDecoration(
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
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                ),
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: categoryItem.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CategoryScreen(
                                newsCategoryTitle: categoryItem[index]),
                          ),
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        margin: const EdgeInsets.symmetric(horizontal: 5),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Center(
                          child: Text(
                            categoryItem[index],
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.black45,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              Container(
                padding: const EdgeInsets.all(10),
                child: Center(
                  child: Consumer<NewsProvider>(
                    builder: ((context, data, child) {
                      return data.map.isEmpty && !data.error
                          ? const CircularProgressIndicator()
                          : data.error
                              ? Text(
                                  'Oops, something went wrong. ${data.errorMessage}',
                                  textAlign: TextAlign.center,
                                )
                              : Container(
                                  margin: const EdgeInsets.symmetric(vertical: 15),
                                  child: CarouselSlider.builder(
                                    carouselController:
                                        buttonCarouselController,
                                    options: CarouselOptions(
                                      autoPlay: false,
                                      height: 280,
                                      viewportFraction: 0.8,
                                      enableInfiniteScroll: false,
                                      aspectRatio: 16 / 9,
                                      enlargeCenterPage: true,
                                      scrollDirection: Axis.horizontal,
                                    ),
                                    itemCount: data.map.length,
                                    itemBuilder: (BuildContext context,
                                        int itemIndex, int pageViewIndex) {
                                      return NewsCard(
                                        map: data.map['articles'][itemIndex],
                                      );
                                    },
                                  ),
                                );
                    }),
                  ),
                ),
              ),

              //latest news
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.fromLTRB(15, 10, 15, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'LATEST NEWS',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                          TextButton(
                            onPressed: () {},
                            child: Text('Show More...'),
                          ),
                        ],
                      ),
                    ),
                    LatestNewsScreen(),
                  ],
                ),
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
    return Container(
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25),
        ),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(25),
              child: Image.network(
                '${map['urlToImage']}',
                fit: BoxFit.fitHeight,
                height: double.infinity,
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  gradient: LinearGradient(
                    colors: [
                      Colors.black12.withOpacity(0),
                      Colors.black,
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: EdgeInsets.symmetric(
                      horizontal: 5,
                      vertical: 10,
                    ),
                    child: Text(
                      '${map['title']}',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w900,
                        color: Colors.black54,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

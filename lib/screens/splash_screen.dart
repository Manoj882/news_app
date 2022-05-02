import 'dart:async';

import 'package:flutter/material.dart';
import 'package:news_app/screens/home_page.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool isSkip = false;
  @override
  void initState() {
    
    super.initState();
    
    if (!isSkip) {
     
        Timer(
          const Duration(seconds: 5), () {
            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => const HomePageScreen()));
          }
        );
        } 
        else{
          skipSplashScreen();
        }
  }

  @override
  Widget build(BuildContext context) {
     return Scaffold(
      // appBar: AppBar(
      //   title: Text('We show news for you'),
      //   centerTitle: true,
      //   elevation: 0,
      // ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFFFF8008),
              Color(0xFFCe1010),
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 20,
              ),
              Text(
                'We show news for you',
                style: Theme.of(context).textTheme.headline6!.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(
                height: 10,
              ),
              Image.asset(
                'assets/images/splash_logo.png',
                height: 500,
                width: 300,
              ),
                
                ElevatedButton(
                
                onPressed: skipSplashScreen,
                
                child: const Text(
                  'Skip',
                ),
              ),
              
            ],
          ),
        ),
      ),
    );
  }

  void skipSplashScreen(){
    
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (_) => const HomePageScreen(),
        ),
      );
    

  }
}

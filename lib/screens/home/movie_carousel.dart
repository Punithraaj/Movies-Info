import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:movie_info_app/model/movie.dart';
import 'dart:math' as math;

import 'package:movie_info_app/utils/constants.dart';

import 'movie_card.dart';

class MovieCarousel extends StatefulWidget {
  @override
  _MovieCarouselState createState() => _MovieCarouselState();
}

class _MovieCarouselState extends State<MovieCarousel> {
  PageController _pageController;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  int initialPage = 1;
  List<Movie> movieList = new List();

  @override
  void initState() {
    super.initState();
    _pageController = PageController(
      // so that we can have small portion shown on left and right side
      viewportFraction: 0.8,
      // by default our movie poster
      initialPage: initialPage,
    );
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  Future buildText() {
    return new Future.delayed(
        const Duration(seconds: 5), () => print('waiting'));
  }

  Future<List<Movie>> getMovieInfo() async {
    List<Movie> movies = new List();
    try {
      FirebaseFirestore.instance
          .collection('movie-info')
          .get()
          .then((QuerySnapshot querySnapshot) =>
      {
        querySnapshot.docs.forEach((doc) {
          print("element.data");
          print(doc.data());
          Movie movie = Movie.fromJson(doc.data());
          movieList.add(movie);
        })
      });
      print('movie size='+movies.toString());
      return movieList;
    } catch (e) {
      print(e);
    }
    }


  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: FutureBuilder(
        future: FirebaseFirestore.instance
            .collection('movie-info')
            .get(),
        builder: (BuildContext context, AsyncSnapshot <QuerySnapshot> snapshot) {
          print(snapshot.connectionState);
          if (!snapshot.hasData) {
            return Container(height:MediaQuery.of(context).size.height/2,child:Center(child:CircularProgressIndicator(backgroundColor: Colors.blue)));
          } else {
            print('movie size='+snapshot.data.docs.length.toString());
            return Padding(
              padding: EdgeInsets.symmetric(vertical: kDefaultPadding),
              child: AspectRatio(
                aspectRatio: 0.85,
                child: PageView.builder(
                  onPageChanged: (value) {
                    setState(() {
                      initialPage = value;
                    });
                  },
                  controller: _pageController,
                  physics: ClampingScrollPhysics(),
                  itemCount: snapshot.data.docs.length,
                  // we have 3 demo movies
                  itemBuilder: (context, index) {
                    Movie movie = Movie.fromJson(snapshot.data.docs[index].data());
                    return buildMovieSlider(movie,index);
                  } 
                ),
              ),
            );
          }
        },
      ),
    );
      }


  Widget buildMovieSlider(Movie movie,int index) {
      return AnimatedBuilder(
        animation: _pageController,
        builder: (context, child) {
          double value = 0;
          if (_pageController.position.haveDimensions) {
            value = index - _pageController.page;
            // We use 0.038 because 180*0.038 = 7 almost and we need to rotate our poster 7 degree
            // we use clamp so that our value vary from -1 to 1
            value = (value * 0.038).clamp(-1, 1);
          }
          return AnimatedOpacity(
            duration: Duration(milliseconds: 350),
            opacity: initialPage == index ? 1 : 0.4,
            child: Transform.rotate(
              angle: math.pi * value,
              child: MovieCard(movie: movie),
            ),
          );
        },
      );
  }
}

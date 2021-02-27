import 'package:flutter/material.dart';
import 'package:movie_info_app/model/movie.dart';
import 'package:movie_info_app/utils/constants.dart';

import 'genre_card.dart';

class Genres extends StatelessWidget {
  const Genres({
    Key key,
    @required this.movie,
  }) : super(key: key);

  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: kDefaultPadding / 2),
      child: SizedBox(
        height: 36,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: movie.genre.length,
          itemBuilder: (context, index) => GenreCard(
            genre: movie.genre[index],
          ),
        ),
      ),
    );
  }
}

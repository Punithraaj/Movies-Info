// Our movie model
class Movie {
  final int id, year, criticsReview;
  final double rating;
  final List<String> genre,theaters;
  final String plot, title, poster,releaseDate,duration;

  Movie(this.id, this.year, this.criticsReview, this.rating, this.genre,this.theaters, this.plot, this.title, this.poster,this.releaseDate,this.duration);



  Movie.fromJson (Map<String, dynamic> json)
      :this.id = json['id'],
      this.year = json['year'],
      this.criticsReview = json['criticsReview'],
      this.rating = json['rating'],
      this.genre = List<String>.from(json['genre']),
      this.theaters = List<String>.from(json['theaters']),
      this.plot = json['plot'],
      this.title = json['title'],
      this.poster = json['poster'],
      this.releaseDate = json['releasedate'],
      this.duration = json['duration'];
  int getId() {
    return this.id;
  }

  int getYear() {
    return this.year;
  }

  int getCriticsReview() {
    return this.criticsReview;
  }

  List<String> getGenre() {
    return this.genre;
  }

  List<String> getTheaters(){
    return this.theaters;
  }

  double getRating(){
    return this.rating;
  }

  String getPlot() {
    return this.plot;
  }

  String getTitle(){
    return this.title;
  }

  String getPoster() {
    return this.poster;
  }

  String getReleaseDate() {
    return this.releaseDate;
  }
  String getDuration() {
    return this.duration;
  }



  @override
  String toString() {
    return 'Movie{id: $id, year: $year, criticsReview: $criticsReview, rating: $rating, genra: $genre, theaters: $theaters, plot: $plot, title: $title, poster: $poster}';
  }
}


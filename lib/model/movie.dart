// Our movie model
class Movie {
  final int id, year, numOfRatings, criticsReview, metascoreRating;
  final double rating;
  final List<String> genra;
  final String plot, title, poster, backdrop;

  Movie(this.id, this.year, this.numOfRatings, this.criticsReview, this.metascoreRating, this.rating, this.genra, this.plot, this.title, this.poster, this.backdrop);



  Movie.fromJson (Map<String, dynamic> json)
      :this.id = json['id'],
      this.year = json['year'],
      this.numOfRatings = json['numOfRatings'],
      this.criticsReview = json['criticsReview'],
      this.metascoreRating = json['metascoreRating'],
      this.rating = json['rating'],
      this.genra = json['genra'],
      this.plot = json['plot'],
      this.title = json['title'],
      this.poster = json['poster'],
      this.backdrop = json['backdrop'];

  int getId() {
    return this.id;
  }

  int getYear() {
    return this.year;
  }

  int getNumOfRatings() {
    return this.numOfRatings;
  }

  int getCriticsReview() {
    return this.criticsReview;
  }

  int getMetascoreRating() {
    return this.metascoreRating;
  }

  List<String> getGenra() {
    return this.genra;
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

  String getBackdrop(){
    return this.backdrop;
  }

  @override
  String toString() {
    return 'Movie{id: $id, year: $year, numOfRatings: $numOfRatings, criticsReview: $criticsReview, metascoreRating: $metascoreRating, rating: $rating, genra: $genra, plot: $plot, title: $title, poster: $poster, backdrop: $backdrop}';
  }
}


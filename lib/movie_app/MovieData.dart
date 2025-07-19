
import 'package:hive/hive.dart';

part 'MovieData.g.dart';

@HiveType(typeId: 0)
class MovieData
{
  @HiveField(0)
  int page;

  @HiveField(1)
  List<Movie> results;
  //int total_pages;
  //int total_results;

  MovieData({
    required this.page,
    required this.results
  });

  // Data map -> model object
  factory MovieData.fromJsonToModelObject(Map<String, dynamic> mappedJson) {
    var listMappedObjects = mappedJson["results"];

    var movies = List<Movie>.from(
        listMappedObjects.map<Movie>((dynamic mappedMovie) =>
            Movie.fromMappedToModelObject(mappedMovie)
        )
    );
    return MovieData(
      page: mappedJson["page"],
      results: movies// stream of data
    );
  }
}

@HiveType(typeId: 1)
class Movie {

  @HiveField(0)
  int id;

  @HiveField(1)
  String title;

  @HiveField(2)
  String poster_path;

  Movie({ required this.id,required this.title, required this.poster_path });

  factory Movie.fromMappedToModelObject(Map<String, dynamic> mappedMoviesJson) {
    return Movie(
        id: mappedMoviesJson["id"],
        title: mappedMoviesJson["title"],
        poster_path: mappedMoviesJson["poster_path"]
    );
  }
}
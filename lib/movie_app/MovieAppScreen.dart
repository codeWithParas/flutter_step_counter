

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_ws_tb/movie_app/MovieData.dart';
import 'package:http/http.dart';

class MovieAppScreen extends StatefulWidget {
  const MovieAppScreen({super.key});

  @override
  State<MovieAppScreen> createState() => _MovieAppScreenState();
}

class _MovieAppScreenState extends State<MovieAppScreen> {

  //var POPULAR_API = 'https://api.themoviedb.org/3/trending/movie/day?language=en-US&api_key=dee8af777f2e8990d4b19baad0388e42';
  //var POPULAR_API = 'https://api.themoviedb.org/3/trending/movie/day?language=en-US&api_key=dee8af777f2e8990d4b19baad0388e42&page=3';
  var POPULAR_API = 'https://api.themoviedb.org/3/movie/popular?language=en-US&page=1&api_key=dee8af777f2e8990d4b19baad0388e42';
  List<Movie> movieList = [];

  @override
  void initState() {

    if(movieList.isEmpty) {
      fetchDataFromServer();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Movies & Shows"),
      ),
      body: getMovieListView(),
    );
  }

  ListView getMovieListView() {
    return ListView.builder(
        itemCount: movieList.length,
        itemBuilder: (context, index) {
          return Text("Movie Title : ${movieList[index].title}");
        });
  }

  void fetchDataFromServer() async {
    // Different thread running
    //print("###### REQUEST ###### ");
    Response response = await get(Uri.parse(POPULAR_API));
    print("###### RESPONSE ###### ${response.body.toString()}");

    if(response.statusCode == 200) {
      _showAlertDialog("Success", "Request Successful");
      print("###### RESPONSE SUCCESS ###### ${response.body}");
      // Map<Key, Value> s
      var mappedJson = jsonDecode(response.body.toString());
      MovieData data = MovieData.fromJsonToModelObject(mappedJson);

      print("###### RESPONSE SIZE MOVIES LIST ###### ${data.results.length}");

      // Update list object
      setState(() {
        movieList.addAll(data.results);
        // It recreate your UI layer
      });


    } else {
      _showAlertDialog("Failure", "Request failed");
      print("###### RESPONSE ERROR ###### ${response.statusCode}");
    }
  }

  void _showAlertDialog(String title, String msg){
    var dialog = AlertDialog(
      title: Text(title),
      content: Text(msg),
    );
    showDialog(context: context, builder: (_) => dialog);
  }
}

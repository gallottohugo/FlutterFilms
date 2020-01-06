import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:films/src/models/actor_model.dart';
import 'package:films/src/models/movie_model.dart';
import 'package:http/http.dart' as http;

class MoviesProvier{
	String _url = 'api.themoviedb.org';
    String _apiKey = 'e799781b8e4bccca31d1eb4462d736ad';
  	String _language = 'en-US';
	int _page = 0;
	bool _loading = false;


	//STREAM
	List<Movie> _popular_movies = new List();
	final _streamController = StreamController<List<Movie>>.broadcast();
	Function(List<Movie>) get popularSink => _streamController.sink.add;
	Stream<List<Movie>> get popularStream  => _streamController.stream;

	void diosposeStreams(){
		_streamController?.close();
	}


	Future<List<Movie>> _connectToServer(Uri url) async{
		final response = await http.get(url);
		final decodedData = json.decode(response.body);
		final movies = Movies.fromJsonList(decodedData['results']);
		return movies.listMovies;
	}

	Future<List<Movie>> getNowPlaying() async {
		final url = Uri.https(_url, '3/movie/now_playing', {
			'api_key': _apiKey,
			'language': _language
		});
		return _connectToServer(url);
	}

	void getPopulars() async {

		if (_loading) return;
		
		_loading = true;
		_page++;

		final url = Uri.https(_url, '3/movie/popular', {
			'api_key' : _apiKey,
			'language': _language,
			'page'    : _page.toString()
		});

		final response = await _connectToServer(url);
		_popular_movies.addAll(response);
		popularSink(_popular_movies);

		_loading = false;
	}


	Future<List<Actor>> getActors (int movie_id) async {
		final url = Uri.https(_url, '3/movie/$movie_id/credits', {
			'api_key': _apiKey,
			'language': _language
		});

		final response = await http.get(url);
		final decodedData = json.decode(response.body);
		final actors = Actors.fromJsonList(decodedData['cast']);
		return actors.actors;
	}



	Future<List<Movie>> searchFilm(String query) async {
		final url = Uri.https(_url, '3/search/movie', {
			'api_key': _apiKey,
			'language': _language,
			'query': query
		});
		return await _connectToServer(url);
	}
}
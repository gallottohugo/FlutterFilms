import 'dart:convert';
import 'package:films/src/models/movie_model.dart';
import 'package:http/http.dart' as http;

class MoviesProvier{
    String _apiKey = 'e799781b8e4bccca31d1eb4462d736ad';
  	String _url = 'api.themoviedb.org';
  	String _language = 'en-US';

	Future<List<Movie>> getResponse(Uri url) async{
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
		return getResponse(url);
	}

  	Future<List<Movie>> getPopulars() async {
		final url = Uri.https(_url, '3/movie/popular', {
			'api_key': _apiKey,
			'language': _language
		});
		return getResponse(url);
	}
}
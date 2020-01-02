class Movies {
	List<Movie> listMovies = new List();
	
	Movies();

	Movies.fromJsonList(List<dynamic> jsonList){
		if (jsonList == null) return;
		for (final item in jsonList){
			final movie = new Movie.fromJsonMap(item);
			listMovies.add(movie);
		}
	}
}


class Movie {
  	double popularity;
  	int voteCount;
  	bool video;
  	String posterPath;
  	int id;
  	bool adult;
  	String backdropPath;
  	String originalLanguage;
  	String originalTitle;
  	List<int> genreIds;
  	String title;
  	double voteAverage;
  	String overview;
  	String releaseDate;

  	Movie({
    	this.popularity,
    	this.voteCount,
    	this.video,
    	this.posterPath,
    	this.id,
    	this.adult,
    	this.backdropPath,
    	this.originalLanguage,
    	this.originalTitle,
    	this.genreIds,
    	this.title,
    	this.voteAverage,
    	this.overview,
    	this.releaseDate,
  	});


	Movie.fromJsonMap( Map<String, dynamic> json){
		id               = json['id'];
		title            = json['title'];
		popularity       = json['popularity'] / 1;
    	voteCount        = json['vote_count'];
    	video            = json['video'];
    	posterPath       = json['poster_path'];
    	adult            = json['adult'];
    	backdropPath     = json['backdrop_path'];
    	originalLanguage = json['original_language'];
    	originalTitle    = json['original_title'];
    	genreIds         = json['genre_ids'].cast<int>();
    	voteAverage      = json['vote_average'] / 1;
    	overview         = json['overview'];
    	releaseDate      = json['release_date'];
	}
}



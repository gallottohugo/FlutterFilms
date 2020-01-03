import 'package:films/src/models/movie_model.dart';
import 'package:flutter/material.dart';

class CardSwiperHorizontalWidget extends StatelessWidget {
  	final List<Movie> movies;
	final Function nextPage;

  	CardSwiperHorizontalWidget({@required this.movies, @required this.nextPage});


	final _pageController = new PageController(initialPage: 1, viewportFraction: 0.3);


  	@override
  	Widget build(BuildContext context) {
		final _screenSize = MediaQuery.of(context).size;
		_pageController.addListener((){
			if (_pageController.position.pixels >= _pageController.position.maxScrollExtent){
				//Función declarada en el home page
				nextPage();
			}
		});

    	return Container(
			height: _screenSize.height * 0.25,
			child: PageView.builder(
				pageSnapping: false,
				controller: _pageController,
				itemCount: movies.length,
				itemBuilder: (context, i) => _card(context, movies[i])
			),
    	);
  	}


	Widget _card(BuildContext context, Movie movie){
		Container card = Container(
			margin: EdgeInsets.only(right: 15.0),
			child: Column(
				children: <Widget>[
					ClipRRect(
						borderRadius: BorderRadius.circular(20.0),
						child: FadeInImage(
							image: NetworkImage(movie.getPosterImg()),
							placeholder: AssetImage('assets/img/no-image.jpg'),
							fit: BoxFit.cover,
							height: 160.0,
							width: 100.0,
						),
					), 
					SizedBox(height: 5.0,),
					Center(
						child: Text(
							movie.title, 
							overflow: TextOverflow.ellipsis,
							style: Theme.of(context).textTheme.caption,
						),
					)
				],
			),
		);

		return GestureDetector(
			child: card,
			onTap: (){
				Navigator.pushNamed(context, 'movies_show', arguments: movie); 
			},
		);
	}
}
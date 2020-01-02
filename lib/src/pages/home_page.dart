import 'package:films/src/providers/movies_provider.dart';
import 'package:films/src/widgets/card_swiper_widget.dart';
import 'package:flutter/material.dart';


class HomePage extends StatelessWidget {
  	@override
	Widget build(BuildContext context) {
    	return Scaffold(
			
			appBar: AppBar(
				centerTitle: false,
				title: Text('Movies in cinema'),
				backgroundColor: Colors.indigoAccent,
				actions: <Widget>[
					IconButton(
						icon: Icon(Icons.search),
						onPressed: (){},
					)
				],
			),
      		body: Container(
				  child: Column(
					  children: <Widget>[
						  _swiperCards()
					  ],
				  ),
			  )
    	);
  	}

	Widget _swiperCards(){
		final moviesProvier = new MoviesProvier();
		moviesProvier.getNowPlaying();	
		return CardSwiperWidget(
			movies: ['1','2','3','4','5','6'],
		);
	}
}
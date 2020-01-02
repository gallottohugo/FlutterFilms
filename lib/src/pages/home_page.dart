import 'package:films/src/providers/movies_provider.dart';
import 'package:films/src/widgets/card_swiper_widget.dart';
import 'package:flutter/material.dart';


class HomePage extends StatelessWidget {

	final moviesProvier = new MoviesProvier();

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
		
		return FutureBuilder(
		  	future: moviesProvier.getNowPlaying(),
		  	builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
				if (snapshot.hasData){
					return CardSwiperWidget(movies: snapshot.data,);
				}
				else{
					return Container(
						height: 400.0,
					  	child: Center(
					  		child: CircularProgressIndicator()
					  	),
					);
				}
				
		  	},
		);
	}
}
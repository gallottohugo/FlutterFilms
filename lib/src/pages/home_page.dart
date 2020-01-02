import 'package:films/src/providers/movies_provider.dart';
import 'package:films/src/widgets/card_swiper_horizontal_widget.dart';
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
						_swiperCards(),
						Divider(),
						_swiperFooter(context)
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

	Widget _swiperFooter(BuildContext context){
		return Container(
			padding: EdgeInsets.only(top: 10.0),
			width: double.infinity,
			child: Column(
				crossAxisAlignment: CrossAxisAlignment.start,
				children: <Widget>[
					Container(
						padding: EdgeInsets.all(10.0),
						child: Text('Popular movies', style: Theme.of(context).textTheme.subtitle,)
					),
					SizedBox(height: 5.0,),
					FutureBuilder(
					  future: moviesProvier.getPopulars(),
					  builder: (BuildContext context, AsyncSnapshot snapshot) {
						if (snapshot.hasData){
							return CardSwiperHorizontalWidget(movies: snapshot.data,);
						}
						else{
							return Center(child: CircularProgressIndicator());
								
						}
					  },
					),
				],
			),
		);
	}
}
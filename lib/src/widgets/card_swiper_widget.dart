import 'package:films/src/models/movie_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';


class CardSwiperWidget extends StatelessWidget {

	final List<Movie> movies;
	
	CardSwiperWidget({@required this.movies});


  	@override
  	Widget build(BuildContext context) {


		final _screenSize = MediaQuery.of(context).size;

    	return Container(
			padding: EdgeInsets.only(top: 20.0),
		  	child: Swiper(				  
				itemWidth: _screenSize.width * 0.6,
				itemHeight: _screenSize.height * 0.5,
				layout: SwiperLayout.STACK,
				itemCount: movies.length,
				//pagination: new SwiperPagination(),
        		//control: new SwiperControl(),
        		itemBuilder: (BuildContext context, int index){
					//create a new id to hero animation
					movies[index].uniqueId = '${movies[index].id}-main-card';
					
          			Hero heroCard = Hero(
						tag: movies[index].uniqueId,
						child: ClipRRect( 
							borderRadius: BorderRadius.circular(20),
							child: FadeInImage(
								image: NetworkImage(movies[index].getPosterImg()),
								placeholder: AssetImage('assets/img/no-image.jpg'),
								fit: BoxFit.cover
							)
						),
					);

					return GestureDetector(
						child: heroCard,
						onTap: (){
							Navigator.pushNamed(context, 'movies_show', arguments: movies[index]); 
						},
					);
        		},
      		),
		);
  	} 
}
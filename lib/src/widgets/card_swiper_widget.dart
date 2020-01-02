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
				itemWidth: _screenSize.width * 0.7,
				itemHeight: _screenSize.height * 0.5,
				layout: SwiperLayout.STACK,
				itemCount: movies.length,
				//pagination: new SwiperPagination(),
        		//control: new SwiperControl(),
        		itemBuilder: (BuildContext context, int index){

					String url_img = movies[index].getPosterImg();
          			return ClipRRect(
						borderRadius: BorderRadius.circular(20),
						child: FadeInImage(
							image: NetworkImage(url_img),
							placeholder: AssetImage('assets/img/no-image.jpg'),
							fit: BoxFit.cover
						)
					);
        		},
      		),
		);
  	} 
}
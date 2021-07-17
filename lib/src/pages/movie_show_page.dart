import 'package:films/src/models/actor_model.dart';
import 'package:films/src/models/movie_model.dart';
import 'package:films/src/providers/movies_provider.dart';
import 'package:flutter/material.dart';

class MovieShowPage extends StatelessWidget {
  	@override
  	Widget build(BuildContext context) {

		final Movie movie = ModalRoute.of(context).settings.arguments;

    	return Scaffold(
			body: CustomScrollView(
				slivers: <Widget>[
					_newAppBar(movie),
					SliverList(
						delegate: SliverChildListDelegate(
							[
								SizedBox(height: 10.0,),
								_newMovieTitle(context, movie),
								Divider(),
								_newDescription(context, movie),	
								Divider(),
								Container(
									padding: EdgeInsets.all(20.0),
									child: Text(
										'Actors',
										style: Theme.of(context).textTheme.title,
									),
								),
								_newActors(context, movie),
							]
						),
					)
				],
			),
		);
  	}


	Widget _newAppBar(Movie movie){
		return SliverAppBar(
			iconTheme: null,
			leading: null,
			stretch: true,
			elevation: 2.0,
			backgroundColor: Colors.indigoAccent,
			expandedHeight: 200.0,
			//floating: false,
			pinned: true,
			flexibleSpace: FlexibleSpaceBar(
				centerTitle: true,
				title: Text(					
					movie.title,
					style: TextStyle(color: Colors.white, fontSize: 16.0),
				),
				background: FadeInImage(
					image: NetworkImage(movie.getBackgroundImg()),
					placeholder: AssetImage('assets/img/loading.gif'),
					fit: BoxFit.cover,
				),
			),
		);
	}

	Widget _newMovieTitle(BuildContext context, Movie movie){
		return Container(
			padding: EdgeInsets.symmetric(horizontal: 10.0),
			child: Row (
				children: <Widget>[
					Hero(
						tag: movie.uniqueId,
						child: ClipRRect(
							borderRadius: BorderRadius.circular(10),
							child: Image(
								image: NetworkImage(movie.getPosterImg()),
								height: 150.0,
							),
						),
					),
					SizedBox(width: 20.0,),
					Flexible(
						child: Column(
							crossAxisAlignment: CrossAxisAlignment.start,
							children: <Widget>[
								Text(
									movie.title, 
									style: Theme.of(context).textTheme.title,
									overflow: TextOverflow.ellipsis,
								),
								Text(
									movie.originalTitle, 
									style: Theme.of(context).textTheme.subhead,
									overflow: TextOverflow.ellipsis,
								),
								Row(
									children: <Widget>[
										Icon(Icons.star_border),
										SizedBox(width: 5.0,),
										Text(
											movie.voteAverage.toString(),
											style: Theme.of(context).textTheme.subhead,
										)
									],									
								)
							],
						),
					)
				],
			),
		);
	}

	Widget _newDescription(BuildContext context, Movie movie){
		return Container(
			padding: EdgeInsets.all(20.0),
			child: Text(
				movie.overview,
				textAlign: TextAlign.justify,
			),
		);
	}

	Widget _newActors(BuildContext context, Movie movie){
		final movieProvider = new MoviesProvier();
		return FutureBuilder(
		  	future: movieProvider.getActors(movie.id),
		  	builder: (BuildContext context, AsyncSnapshot<List<Actor>> snapshot) {
				if (snapshot.hasData){
					return _newActorsPageView(snapshot.data);
				} else {
					return Center(child: CircularProgressIndicator(),);
				}
		  	},
		);
	}

	Widget _newActorsPageView(List<Actor> actors){
		return SizedBox(
			height: 200.0,
			child: PageView.builder(
				pageSnapping: false,
				itemCount: actors.length,
				controller: PageController(
					viewportFraction: 0.3,
					initialPage: 1
				),
				itemBuilder: (context, i){
					return Container(
						padding: EdgeInsets.all(10.0),
						child: Column(
							children: <Widget>[
								ClipRRect(
									borderRadius: BorderRadius.circular(20.0),
									child: FadeInImage(
										image: NetworkImage(actors[i].getProfileImg()),
										placeholder: AssetImage('assets/img/no-image.jpg'),
										fit: BoxFit.cover,
										height: 100,
										width: 75.0,
									),
								),
								SizedBox(
									height: 10,
								),
								Center(
									child: Text(
										actors[i].name,
										overflow: TextOverflow.ellipsis,
									),
								)
							],
						)		
					);
				},
			),
		);
	}
}
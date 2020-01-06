import 'package:films/src/models/movie_model.dart';
import 'package:films/src/providers/movies_provider.dart';
import 'package:flutter/material.dart';

 class DataSearch extends SearchDelegate{
	
	final moviesProvier = new MoviesProvier();

	@override
    List<Widget> buildActions(BuildContext context) {
      	// Acciones de nuestro AppBar
      	return [
			IconButton(
				icon: Icon(Icons.clear),
				onPressed: (){
					query = ''; 
				},
			)
		];
    }

    @override
    Widget buildLeading(BuildContext context) {
      	// Icono a la izquierda del app search
      	return IconButton(
			icon: AnimatedIcon(
				icon: AnimatedIcons.menu_arrow,
				progress: transitionAnimation,
			),
			onPressed: (){
				close(context, null);
			},
		  );
    }

    @override
    Widget buildResults(BuildContext context) {
      	// Crea los resultados que vamos a mostrar
      	return Container();
    }

    @override
    Widget buildSuggestions(BuildContext context) {
      	// Son las sugerencias que aparecen cuando la persona escribe
		if (query.isEmpty){ return Container(); } 

		return FutureBuilder(
		  	future: moviesProvier.searchFilm(query),
		  	builder: (BuildContext context, AsyncSnapshot<List<Movie>> snapshot) {
				if (snapshot.hasData){
					final films = snapshot.data;
					return ListView(
						children: films.map((f){
							return ListTile(
								leading: FadeInImage(
									image: NetworkImage(f.getPosterImg()),
									placeholder: AssetImage('assets/img/no-image.jpg'),
									width: 50.0,
									fit: BoxFit.cover,
								),
								title: Text(f.title),
								subtitle: Text(f.originalTitle),
								onTap: (){
									close(context, null);
									f.uniqueId = '';
									Navigator.pushNamed(context, 'movies_show', arguments: f);
								},
							);
						}).toList(),
					);
				} else {
					return Center(
						child: CircularProgressIndicator(),
					);
				}
		  	},
		);	
    }
}




/*
	TO SEARCH IN LOCAL LIST
	final all_films = [
		'Spiderman',
		'Spiderman 1',
		'Spiderman 2',
		'Spiderman 3',
		'Que pasó ayer',
		'Tonto y re tonto',
		'El día de la inpedencia',
		'Hugo',
		'Iurguen'
	];

	final last_films = [
		'Spiderman',
		'Capitan America'
	];

	//if query is empry asigna el last_films sino busca las peliculas que empiecen con el texto en el listado completo
	final filmList = ( query.isEmpty ) ? last_films : all_films.where((p)=> p.toLowerCase().contains(query.toLowerCase())).toList();

	return ListView.builder(
		itemCount: filmList.length,
		itemBuilder: (context, index){
			return ListTile(
				leading: Icon(Icons.movie),
				title: Text(filmList[index]),
				onTap: (){

				},
			);
		},
	);

 */
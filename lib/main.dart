import 'package:films/src/pages/home_page.dart';
import 'package:flutter/material.dart';
 
void main() => runApp(FilmApp());
 
class FilmApp extends StatelessWidget {
  	@override
  	Widget build(BuildContext context) {
		return MaterialApp(
			debugShowCheckedModeBanner: false,
	  		title: 'Films',
	  		initialRoute: 'home',
			routes: {
				'home': (BuildContext context) => HomePage(),
			},
		);
  	}
}
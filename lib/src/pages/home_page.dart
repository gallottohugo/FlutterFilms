import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  	@override
	Widget build(BuildContext context) {
    	return Scaffold(
			
			appBar: AppBar(
				title: Text('Films'),
			),
      		body: SafeArea(
				  child: Text('Films home page'),
			  ),
    	);
  	}
}
import 'package:flutter/material.dart';

class DetailsScreen extends StatelessWidget {
   
  const DetailsScreen({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {

    //TODO: cambiar luego por una instancia de movie
    final String movie = ModalRoute.of(context)?.settings.arguments.toString() ?? 'no moview';

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _CustomAppBar(),
        ],
      )
    );
  }
}

class _CustomAppBar extends StatelessWidget {
  const _CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: Colors.indigo,
      expandedHeight: 200,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        titlePadding: EdgeInsets.all(0),
        title: Container(
          width: double.infinity,
          alignment: Alignment.bottomCenter,
          color: Colors.black12,
          child: const Text('Movie.Title', style: TextStyle( fontSize: 16 ),),
        ),
        background: FadeInImage(
          placeholder: AssetImage('assets/loading.gif'), 
          image: NetworkImage('https://via.placeholder.com/500x300'),
          fit: BoxFit.cover,
        ),
      ),

    );
  }
}
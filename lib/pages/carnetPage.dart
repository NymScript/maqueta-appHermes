import 'package:flutter/material.dart';
import 'package:maqueta/widgets/HomeAppBar.dart';

class Carnetpage extends StatefulWidget {
  const Carnetpage({super.key});

  @override
  State<Carnetpage> createState() => _CarnetpageState();
}

class _CarnetpageState extends State<Carnetpage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: ListView(
        children: [
          HomeAppBar(),
          Text(
            "Pagina carnet"
          )
        ],
      ),
  
      
    
    );
  }
}
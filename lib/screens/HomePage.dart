import 'package:flutter/material.dart';
import '../widgets/MyAppBar.dart';

class HomePage extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: MyAppBar(
        title: 'Beranda',
        actions: [
          IconButton(
            icon: const Icon(
              Icons.search, color: Colors.white
            ),
            onPressed: (){

            },
          ),
        ],
      ),
      body: const Center(
        child: Text('met dateng kawan'),
      ),
    );
  }
}
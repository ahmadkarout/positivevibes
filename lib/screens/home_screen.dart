import 'package:flutter/material.dart';
import 'dart:core';

import 'OptionsCard.dart';
import 'dialog.dart';
import 'data.dart' show data ;

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  final List<Map<String, dynamic>> _data = data;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Row(
          children: [
            SizedBox(
              width: 4,
            ),
            Icon(
              Icons.favorite,
              color: Colors.pink,
            ),
            SizedBox(
              width: 10,
            ),
            Icon(
              Icons.favorite,
              color: Colors.pink,
            ),
            SizedBox(
              width: 10,
            ),
            Icon(
              Icons.favorite,
              color: Colors.pink,
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              'PositiveVibes',
              style: TextStyle(
                color: Colors.black,
                fontSize: 28,
                fontFamily: 'DancingScript',
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Icon(
              Icons.favorite,
              color: Colors.pink,
            ),
            SizedBox(
              width: 10,
            ),
            Icon(
              Icons.favorite,
              color: Colors.pink,
            ),
            SizedBox(
              width: 10,
            ),
            Icon(
              Icons.favorite,
              color: Colors.pink,
            ),
          ],
        ),

      )
      ,
      body: Padding(
        padding: const EdgeInsets.only(top: 12.0),
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 16.0,
          mainAxisSpacing: 16.0,
          childAspectRatio: 0.75,
          children: List.generate(
            _data.length,
                (index) => GestureDetector(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return HelloDialog(title: _data[index]['title'],);
                  },
                );
              },
              child: CardWidget(
                title: _data[index]['title'],
                imageUrl: _data[index]['thumbnailUrl'],
                subtitle: _data[index]['description'],
              ),
            ),
          ),
        ),
      ),
    );
  }
}


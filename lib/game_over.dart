import 'package:flutter/material.dart';

import 'game_page.dart';

class GameOver extends StatelessWidget {

  final int score;

  GameOver({
   required this.score
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:const Text("Try Again"),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
      ),
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          color: Colors.white38,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text('Game Over', style: TextStyle(color: Colors.red,
                  fontSize: 30.0, fontWeight: FontWeight.bold, fontStyle: FontStyle.italic,
                  shadows: [
                Shadow( // bottomLeft
                    offset: Offset(-1.5, -1.5),
                    color: Colors.black
                ),
                Shadow( // bottomRight
                    offset: Offset(1.5, -1.5),
                    color: Colors.black
                ),
                Shadow( // topRight
                    offset: Offset(1.5, 1.5),
                    color: Colors.black
                ),
                Shadow( // topLeft
                    offset: Offset(-1.5, 1.5),
                    color: Colors.black
                ),
              ])
              ),

              const SizedBox(height: 50.0),

              Text('Your Score is: $score', style: const TextStyle(color: Colors.black54,
                  fontSize: 20.0)),

              const SizedBox(height: 50.0),

              ElevatedButton.icon(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(Colors.green), // Set your desired background color
                    padding: MaterialStateProperty.all<EdgeInsetsGeometry>(EdgeInsets.all(15.0)), // Adjust padding
                    shape: MaterialStateProperty.all<OutlinedBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0), // Adjust border radius
                      ),
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) =>
                        GamePage()));
                  },
                  icon: const Icon(Icons.refresh, color: Colors.white, size: 30.0),
                  label: const Text("Try Again", style: TextStyle(color: Colors.white, fontSize: 20.0))
              ),
            ],
          ),
        )
    );
  }
}
import 'package:flutter/material.dart';
import 'game_page.dart';
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home page"),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
      ),
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.network('https://firebasestorage.googleapis.com/v0/b/mainecommerce-e9457.appspot.com/o/CnicPDF%2Fdownload.jpg?alt=media&token=9fd721f8-5c00-48ee-a229-bbc35e9b5a91'),
              const SizedBox(height: 50.0),
              const Text('Welcome to SnakeGame by CodingWithZohaib',
                  style: TextStyle(color: Colors.black54, fontSize: 30.0, fontStyle:
                  FontStyle.italic, fontWeight: FontWeight.bold), textAlign: TextAlign.center),
              const SizedBox(height: 50.0),

              ElevatedButton.icon(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.deepPurple), // Set your desired background color
                  padding: MaterialStateProperty.all<EdgeInsetsGeometry>(EdgeInsets.all(15.0)), // Adjust padding
                  shape: MaterialStateProperty.all<OutlinedBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0), // Adjust border radius
                    ),
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => GamePage()));
                },
                icon: const Icon(Icons.play_circle_filled, color: Colors.white, size: 30.0),
                label: const Text("Start the Game...", style: TextStyle(color: Colors.white, fontSize: 20.0)),
              )
            ],
          ),
        )
    );
  }
}
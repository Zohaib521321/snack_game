import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'game_over.dart';
class GamePage extends StatefulWidget {
  @override
  _GamePageState createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> with TickerProviderStateMixin {

  int _playerScore=0;
  bool? _hasStarted;
  Animation<dynamic>? _snakeAnimation;
  AnimationController? _snakeController;
  final List _snake = [404, 405, 406, 407];
  final int _noOfSquares = 500;
  final Duration _duration = const Duration(milliseconds: 250);
  final int _squareSize = 20;
  String _currentSnakeDirection="";
  int? _snakeFoodPosition;
  final Random _random = Random();

  @override
  void initState() {
    super.initState();
    _setUpGame();
  }

  void _setUpGame() {
    _playerScore = 0;
    _currentSnakeDirection = 'RIGHT';
    _hasStarted = true;
    do {
      _snakeFoodPosition = _random.nextInt(_noOfSquares);
    } while(_snake.contains(_snakeFoodPosition));
    _snakeController = AnimationController(vsync: this, duration: _duration);
    _snakeAnimation = CurvedAnimation(curve: Curves.easeInOut, parent: _snakeController!);
  }

  void _gameStart() {
    Timer.periodic(const Duration(milliseconds: 250), (Timer timer) {
      _updateSnake();  //after 250 millisecond call it repeatedly
      if(_hasStarted!) timer.cancel();
    });
  }

  bool _gameOver() {  //head of the snake collides with any part of its body
    for (int i = 0; i < _snake.length - 1; i++) {
      if (_snake.last == _snake[i]) return true;
    }
    return false;
  }

  void _updateSnake() {
    // Check if game has started
    if(!_hasStarted!) {
      setState(() {
        _playerScore = (_snake.length - 4) * 5;//4 firstly nodes when games start if length=0=>0*5=0
        //Based on the current direction
        switch (_currentSnakeDirection) {
          case 'DOWN': //direction is down
          //To bottom edge of the game board
            if (_snake.last > _noOfSquares) {   //
              _snake.add(_snake.last + _squareSize - (_noOfSquares + _squareSize));
            } else {
              _snake.add(_snake.last + _squareSize);
            }
            break;
          case 'UP':
            if (_snake.last < _squareSize) {
              _snake.add(_snake.last - _squareSize + (_noOfSquares + _squareSize));
            } else {
              _snake.add(_snake.last - _squareSize);
            }
            break;
          case 'RIGHT':
            if ((_snake.last + 1) % _squareSize == 0) {
              _snake.add(_snake.last + 1 - _squareSize);
            } else {
              _snake.add(_snake.last + 1);
            }
            break;
          case 'LEFT':
            if ((_snake.last) % _squareSize == 0) {
              _snake.add(_snake.last - 1 + _squareSize);
            } else {
              _snake.add(_snake.last - 1);
            }
        }
        //Snake has eaten the food
        if (_snake.last != _snakeFoodPosition) {
          _snake.removeAt(0);
        } else {
          //if yes generate random number between 1 to 500(NOSquares)..
          do {
            _snakeFoodPosition = _random.nextInt(_noOfSquares);
          } while (_snake.contains(_snakeFoodPosition));      //Until food is generated
        }

        if (_gameOver()) {     //game over
          setState(() {
            _hasStarted = !_hasStarted!;  //has started to false
          });
          //To end screen
          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) =>
              GameOver(score: _playerScore)));
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SnakeGameFlutter',
            style: TextStyle(color: Colors.white, fontSize: 20.0)),
        centerTitle: false,
        backgroundColor: Colors.deepPurple,
        actions: <Widget>[
          Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Text('Score: $_playerScore', style: const TextStyle(fontSize: 16.0)),
              )
          )
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
          backgroundColor: Colors.deepPurple,
          elevation: 10,
          shape: RoundedRectangleBorder(
            side: BorderSide(
              color: Colors.deepPurple.shade400
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          label: Text(
            _hasStarted! ? 'Start' : 'Pause',
            style: const TextStyle(),
          ),
          onPressed: () {
            setState(() {
              if(_hasStarted!) {
                _snakeController!.forward();
              } else {
                _snakeController!.reverse();
              }
              _hasStarted = !_hasStarted!;
              _gameStart();
            });
          },
          icon: AnimatedIcon(icon: AnimatedIcons.play_pause, progress: _snakeAnimation! as Animation<double>)
      ),
      body: Center(
        child: GestureDetector(
          onVerticalDragUpdate: (drag) {
            if (drag.delta.dy > 0 && _currentSnakeDirection != 'UP') {
              _currentSnakeDirection = 'DOWN';
            } else if (drag.delta.dy < 0 && _currentSnakeDirection != 'DOWN') _currentSnakeDirection = 'UP';
          },
          onHorizontalDragUpdate: (drag) {
            if (drag.delta.dx > 0 && _currentSnakeDirection != 'LEFT') {
              _currentSnakeDirection = 'RIGHT';
            } else if (drag.delta.dx < 0 && _currentSnakeDirection != 'RIGHT')  _currentSnakeDirection = 'LEFT';
          },
          child: Container(
            width: MediaQuery.of(context).size.width,
            child: GridView.builder(
              itemCount: _squareSize + _noOfSquares,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: _squareSize),
              itemBuilder: (BuildContext context, int index) {
                return Center(
                  child: Container(
                    color: Colors.green,
                    padding: _snake.contains(index) ?
                    const EdgeInsets.all(1) : const EdgeInsets.all(0),
                    child: ClipRRect(
                      borderRadius: index == _snakeFoodPosition
                          || index == _snake.last ? BorderRadius.circular(7) :
                      _snake.contains(index) ? BorderRadius.circular(2.5) :
                      BorderRadius.circular(1),
                      child: Container(
                          color: _snake.contains(index) ? Colors.deepPurple :
                          index == _snakeFoodPosition ? Colors.green :
                          Colors.deepPurple.shade200
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
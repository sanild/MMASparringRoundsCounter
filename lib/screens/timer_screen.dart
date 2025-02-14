import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../services/timer_service.dart';
import '../models/round_settings.dart';

class TimerScreen extends StatefulWidget {
  final RoundSettings settings;
  TimerScreen({required this.settings});

  @override
  _TimerScreenState createState() => _TimerScreenState();
}

class _TimerScreenState extends State<TimerScreen> {
  TimerService _timerService = TimerService();
  bool _isTimerRunning = false;
  int _currentRound = 1;
  bool _isResting = false;

  // Define the background colors
  Color get _backgroundColor {
    if (!_isTimerRunning) return Colors.blueGrey;
    return _isResting ? Colors.redAccent : Colors.greenAccent;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedContainer(
        duration: Duration(milliseconds: 500),
        curve: Curves.easeInOut,
        color: _backgroundColor,
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // Title text with custom font and shadow for depth
              Text(
                _isResting ? 'Rest Period' : 'Round $_currentRound',
                style: GoogleFonts.roboto(
                  textStyle: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    shadows: [
                      Shadow(
                        blurRadius: 4,
                        color: Colors.black45,
                        offset: Offset(2, 2),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(height: 30),
              // Timer display (you could also animate this further)
              StreamBuilder(
                stream: _timerService.timerStream,
                builder: (context, snapshot) {
                  return Text(
                    snapshot.data ?? '00:00',
                    style: GoogleFonts.robotoMono(
                      textStyle: TextStyle(
                        fontSize: 85,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        shadows: [
                          Shadow(
                            blurRadius: 4,
                            color: Colors.black45,
                            offset: Offset(2, 2),
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
              SizedBox(height: 50),
              // Buttons in a nicely spaced row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black87,
                      padding: EdgeInsets.symmetric(
                          horizontal: 30.0, vertical: 15.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: _toggleTimer,
                    child: Text(
                      _isTimerRunning ? 'Stop' : 'Start',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black87,
                      padding: EdgeInsets.symmetric(
                          horizontal: 30.0, vertical: 15.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: _resetTimer,
                    child: Text(
                      'Reset',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _toggleTimer() {
    if (_isTimerRunning) {
      _timerService.stopTimer();
    } else {
      _timerService.startTimer(
        widget.settings.rounds,
        widget.settings.roundDuration,
        widget.settings.restDuration,
        (int round, bool isResting) {
          setState(() {
            _currentRound = round;
            _isResting = isResting;
          });
        },
      );
    }
    setState(() {
      _isTimerRunning = !_isTimerRunning;
    });
  }

  void _resetTimer() {
    _timerService.resetTimer();
    setState(() {
      _isTimerRunning = false;
      _currentRound = 1;
      _isResting = false;
    });
  }
}

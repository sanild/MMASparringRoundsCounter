import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../services/timer_service.dart';
import 'package:provider/provider.dart';
import '../models/round_settings.dart';
import 'package:flutter/services.dart';
import '../providers/settings_provider.dart';

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
    if (!_isTimerRunning) return const Color.fromARGB(255, 189, 240, 246);
    return _isResting ? Colors.redAccent : Colors.greenAccent;
  }

  @override
  Widget build(BuildContext context) {
    final bool vibrationEnabled = Provider.of<SettingsProvider>(context).enableVibration;
    return Scaffold(
      body: AnimatedContainer(
        duration: Duration(milliseconds: 500),
        curve: Curves.easeInOut,
        color: _backgroundColor,
        child: Center(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 40.0),
            padding: const EdgeInsets.all(30.0),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.8), // Translucent effect
              borderRadius: BorderRadius.circular(16.0), // Rounded edges
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                // Title text with custom font
                Text(
                  _isResting ? 'Rest Period' : 'Round $_currentRound',
                  style: GoogleFonts.roboto(
                    textStyle: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
                SizedBox(height: 30),
                // Timer display
                StreamBuilder(
                  stream: _timerService.timerStream,
                  builder: (context, snapshot) {
                    return Text(
                      snapshot.data ?? '00:00',
                      style: GoogleFonts.montserrat(
                        textStyle: TextStyle(
                          fontSize: 85,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    );
                  },
                ),
                SizedBox(height: 50),
                // Buttons row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black87,
                        padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 15.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: () => _toggleTimer(vibrationEnabled),
                      child: Text(
                        _isTimerRunning ? 'Stop' : 'Start',
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black87,
                        padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 15.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: () => _resetTimer(vibrationEnabled),
                      child: Text(
                        'Reset',
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _toggleTimer(vibrationEnabled) {
    if (vibrationEnabled){
      HapticFeedback.vibrate();
      }
    
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

   _resetTimer(vibrationEnabled) {
     if (vibrationEnabled){
      HapticFeedback.vibrate();
      }
        _timerService.resetTimer();
    setState(() {
      _isTimerRunning = false;
      _currentRound = 1;
      _isResting = false;
    });
  }
}

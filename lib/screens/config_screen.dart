import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sparring_rounds_app/screens/nav_bar.dart';
import 'timer_screen.dart';
import '../models/round_settings.dart';
import 'package:flutter/cupertino.dart';

class ConfigScreen extends StatefulWidget {
  @override
  _ConfigScreenState createState() => _ConfigScreenState();
}

class _ConfigScreenState extends State<ConfigScreen> {
  final TextEditingController _roundsController = TextEditingController();
  final TextEditingController _roundTimeController = TextEditingController();
  final TextEditingController _restTimeController = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void _startTimerScreen() {
    if (_roundsController.text.isEmpty ||
        _roundTimeController.text.isEmpty ||
        _restTimeController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          duration: const Duration(seconds: 1),
          content: const Text('Please fill out all fields.'),
          backgroundColor: Colors.blueGrey,
        ),
      );
      return;
    }

    final int rounds = int.tryParse(_roundsController.text) ?? 3;
    final double roundTime = double.tryParse(_roundTimeController.text) ?? 3.0;
    final double restTime = double.tryParse(_restTimeController.text) ?? 1.0;

    final int roundTimeSeconds = (roundTime * 60).toInt();
    final int restTimeSeconds = (restTime * 60).toInt();

    Navigator.push(
      context,
      MaterialPageRoute(
        builder:
            (context) => TimerScreen(
              settings: RoundSettings(
                rounds: rounds,
                roundDuration: roundTimeSeconds,
                restDuration: restTimeSeconds,
              ),
            ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // This Container provides the background image for the entire screen.
      constraints: BoxConstraints.expand(),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/background-large.jpg"),
          fit: BoxFit.cover,
        ),
      ),
      // The Scaffold is wrapped inside the Container and its background is transparent.
      child: Scaffold(
        key: _scaffoldKey,
        backgroundColor: Colors.transparent,
        drawer: NavBar(),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 2,
          leading: IconButton(
            onPressed: () {
              _scaffoldKey.currentState!.openDrawer();
            },
            icon: Icon(CupertinoIcons.bars, color: Colors.white, size: 40.0),
          ),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Card(
            color: Colors.black.withOpacity(
              0.8,
            ), // Only the card is semi-transparent
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.0),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 24.0,
                vertical: 32.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  // Header Text
                  Text(
                    'Set up Timer',
                    style: GoogleFonts.montserrat(
                      textStyle: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 24.0),
                  // Rounds Input
                  TextField(
                    style: TextStyle(color: Colors.white, fontSize: 20),
                    controller: _roundsController,
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                    decoration: InputDecoration(
                      labelText: 'Number of Rounds',
                      labelStyle: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.repeat, color: Colors.white),
                    ),
                  ),
                  SizedBox(height: 16),
                  // Round Duration Input
                  TextField(
                    style: TextStyle(color: Colors.white, fontSize: 20),
                    controller: _roundTimeController,
                    keyboardType: TextInputType.numberWithOptions(
                      decimal: true,
                    ),
                    decoration: InputDecoration(
                      labelText: 'Round Duration (minutes)',
                      labelStyle: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.timer, color: Colors.white),
                    ),
                  ),
                  SizedBox(height: 16),
                  // Rest Duration Input
                  TextField(
                    style: TextStyle(color: Colors.white, fontSize: 20),
                    controller: _restTimeController,
                    keyboardType: TextInputType.numberWithOptions(
                      decimal: true,
                    ),
                    decoration: InputDecoration(
                      labelText: 'Rest Duration (minutes)',
                      labelStyle: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(
                        Icons.pause_circle_filled,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(height: 24),
                  // Start Timer Button
                  ElevatedButton(
                    onPressed: _startTimerScreen,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      padding: EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      'Start Timer',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

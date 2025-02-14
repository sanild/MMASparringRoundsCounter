import 'package:flutter/material.dart';
import 'package:sparring_rounds_app/screens/nav_bar.dart';
import 'timer_screen.dart';
import '../models/round_settings.dart';

class ConfigScreen extends StatefulWidget {
  @override
  _ConfigScreenState createState() => _ConfigScreenState();
}

class _ConfigScreenState extends State<ConfigScreen> {
  final TextEditingController _roundsController = TextEditingController();
  final TextEditingController _roundTimeController = TextEditingController();
  final TextEditingController _restTimeController = TextEditingController();

  void _startTimerScreen() {
    
    if (_roundsController.text.isEmpty ||
        _roundTimeController.text.isEmpty ||
        _restTimeController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          duration: const Duration(seconds: 1),
          content: Text('Please fill out all fields.'),
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
        builder: (context) => TimerScreen(
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
    return Scaffold(
      drawer: NavBar(),
      appBar: AppBar(
        elevation: 2,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Card(
          elevation: 4,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                // Header Text
                Text(
                  'Set Up Your Sparring Timer',
                  style: Theme.of(context).textTheme.titleLarge,
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 24.0),
                // Rounds Input
                TextField(
                  controller: _roundsController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Number of Rounds',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.repeat),
                  ),
                ),
                SizedBox(height: 16),
                // Round Duration Input
                TextField(
                  controller: _roundTimeController,
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  decoration: InputDecoration(
                    labelText: 'Round Duration (minutes)',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.timer),
                  ),
                ),
                SizedBox(height: 16),
                // Rest Duration Input
                TextField(
                  controller: _restTimeController,
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  decoration: InputDecoration(
                    labelText: 'Rest Duration (minutes)',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.pause_circle_filled),
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
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

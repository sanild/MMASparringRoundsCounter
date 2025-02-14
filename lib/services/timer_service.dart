import 'dart:async';
import 'package:audioplayers/audioplayers.dart';

class TimerService {
  final StreamController<String> _timerStreamController =
      StreamController.broadcast();
  Stream<String> get timerStream => _timerStreamController.stream;
  Timer? _timer;
  int _remainingTime = 0;
  int _currentRound = 1;
  bool _isResting = false;
  late int _totalRounds, _roundDuration, _restDuration;
  Function(int, bool)? _updateCallback;
  final AudioPlayer _audioPlayer = AudioPlayer();

  void startTimer(
    int totalRounds,
    int roundDuration,
    int restDuration,
    Function(int, bool) updateCallback,
  ) async {
    _totalRounds = totalRounds;
    _roundDuration = roundDuration;
    _restDuration = restDuration;
    _updateCallback = updateCallback;
    _currentRound = 1;
    _isResting = false;

    // Play countdown audio at 3 and show countdown
    await _playCountdown();

    _remainingTime = _roundDuration;
    _updateCallback!(_currentRound, _isResting);

    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_remainingTime > 0) {
        _remainingTime--;
      } else {
        if (!_isResting) {
          // If it's the end of a round and there are more rounds,
          // transition into the rest period.
          if (_currentRound < _totalRounds) {
            _isResting = true;
            _remainingTime = _restDuration;
          } else {
            stopTimer();
            return;
          }
        } else {
          // Transition from rest period to the next round.
          _isResting = false;
          _currentRound++;
          _remainingTime = _roundDuration;
          // Play the buzzer sound when a new round starts.
          _audioPlayer.play(AssetSource('audio/buzzer.wav'));
        }
        _updateCallback!(_currentRound, _isResting);
      }
      _timerStreamController.add(_formatTime(_remainingTime));
    });
  }

  Future<void> _playCountdown() async {
    for (int i = 3; i >= 1; i--) {
      _timerStreamController.add(i.toString());
      if (i == 3) {
        await _audioPlayer.play(AssetSource('audio/initialTimerAudio.wav'));
      }
      await Future.delayed(Duration(seconds: 1));
    }
    _timerStreamController.add("FIGHT");
    await _audioPlayer.play(AssetSource('audio/buzzer.wav'));
  }

  void stopTimer() {
    _timer?.cancel();
  }

  void resetTimer() {
    _timer?.cancel();
    _remainingTime = 0;
    _timerStreamController.add(_formatTime(_remainingTime));
  }

  String _formatTime(int seconds) {
    int minutes = seconds ~/ 60;
    int secs = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${secs.toString().padLeft(2, '0')}';
  }
}

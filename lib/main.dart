import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

void main() {
  runApp(BreathingTimerApp());
}

class BreathingTimerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Breathing Timer App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BreathingTimerHomePage(),
    );
  }
}

class BreathingTimerHomePage extends StatefulWidget {
  @override
  _BreathingTimerHomePageState createState() => _BreathingTimerHomePageState();
}

class _BreathingTimerHomePageState extends State<BreathingTimerHomePage> {
  List<TimerData> _timers = [];
  TimerData? _currentTimer;
  final AudioPlayer _audioPlayer = AudioPlayer();
  Timer? _updateTimer;

  @override
  void initState() {
    super.initState();
    _startNextTimer();
  }

  void _playSound() async {
    await _audioPlayer.play(AssetSource('assets/alarm_sound.mp3'));
  }

  void _addTimer(Duration duration) {
    setState(() {
      _timers.add(TimerData(duration, _playSound, _startNextTimer));
    });
    if (_currentTimer == null) {
      _startNextTimer();
    }
  }

  void _startNextTimer() {
    if (_timers.isNotEmpty) {
      setState(() {
        _currentTimer = _timers.removeAt(0);
        _currentTimer!.start();
      });
      _updateTimer = Timer.periodic(Duration(seconds: 1), (timer) {
        setState(() {});
      });
    } else {
      setState(() {
        _currentTimer = null;
      });
      _updateTimer?.cancel();
    }
  }

  void _setCustomDuration(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext builder) {
        Duration _selectedDuration = Duration(minutes: 0, seconds: 10);
        return Container(
          height: MediaQuery.of(context).copyWith().size.height / 3,
          child: Column(
            children: <Widget>[
              Expanded(
                child: CupertinoTimerPicker(
                  mode: CupertinoTimerPickerMode.ms,
                  initialTimerDuration: _selectedDuration,
                  onTimerDurationChanged: (Duration newDuration) {
                    _selectedDuration = newDuration;
                  },
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  _addTimer(_selectedDuration);
                  Navigator.pop(context);
                },
                child: Text('Add Timer'),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    for (var timerData in _timers) {
      timerData.timer?.cancel();
    }
    _currentTimer?.timer?.cancel();
    _updateTimer?.cancel();
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Breathing Timer App'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            if (_currentTimer != null)
              Text(
                'Current Timer: ${_currentTimer!.remainingTime.inMinutes}:${(_currentTimer!.remainingTime.inSeconds % 60).toString().padLeft(2, '0')}',
                style: Theme.of(context).textTheme.bodyLarge,
              )
            else
              Text(
                'No Active Timer',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: _timers.length,
                itemBuilder: (context, index) {
                  return TimerTile(
                    timerData: _timers[index],
                    onRemove: () {
                      setState(() {
                        _timers[index].timer?.cancel();
                        _timers.removeAt(index);
                      });
                    },
                    key: ValueKey(index),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _setCustomDuration(context),
        child: Icon(Icons.add),
      ),
    );
  }
}

class TimerData {
  TimerData(this.duration, this.playSound, this.onComplete)
      : remainingTime = duration;

  final Duration duration;
  final Function playSound;
  final Function onComplete;
  Duration remainingTime;
  Timer? timer;

  void start() {
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (remainingTime.inSeconds > 0) {
        remainingTime -= Duration(seconds: 1);
      } else {
        timer.cancel();
        playSound();
        onComplete();
      }
    });
  }
}

class TimerTile extends StatelessWidget {
  const TimerTile({
    required Key key,
    required this.timerData,
    required this.onRemove,
  }) : super(key: key);

  final TimerData timerData;
  final VoidCallback onRemove;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
          'Duration: ${timerData.duration.inMinutes}:${(timerData.duration.inSeconds % 60).toString().padLeft(2, '0')}'),
      trailing: IconButton(
        icon: Icon(Icons.delete),
        onPressed: onRemove,
      ),
    );
  }
}

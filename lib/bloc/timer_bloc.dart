import 'dart:async';

const iniciar = 'Iniciar';
const pause = 'Pausar';

class TimerBloc {
  int _countSeconds = 0;
  int _countMinutes = -1;

  StreamController<int> _controllerSeconds;
  StreamController<int> _controllerMinutes;
  StreamController<String> _controllerButton;

  Timer _timer;

  TimerBloc(){
    _controllerSeconds = StreamController<int>();
    _controllerMinutes = StreamController<int>();
    _controllerButton = StreamController<String>();

    _controllerButton.sink.add(iniciar);
  }

  Stream<int> get streamSeconds {
    return _controllerSeconds.stream;
  }

  Stream<int> get streamMinutes {
    return _controllerMinutes.stream;
  }

  Stream get streamButton {
    return _controllerButton.stream;
  }

  void _onPlay(){
    _timer = Timer.periodic(Duration(seconds: 1), (_){
      if (!_controllerSeconds.isClosed){
        if (_countSeconds == 0){
          _controllerMinutes.sink.add(++_countMinutes);
        }

        _controllerSeconds.sink.add(_countSeconds++);

        if (_countSeconds == 60){
          _countSeconds = 0;
        }
      }
    });
  }

  void _onPause() {
    if (_timer != null){
      _timer.cancel();
      _timer = null;
    }
  }

  void onPressed() {
    if (_timer != null && _timer.isActive){
      _controllerButton.sink.add(iniciar);
      _onPause();
    } else {
      _controllerButton.sink.add(pause);
      _onPlay();
    }
  }
}
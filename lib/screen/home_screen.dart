import 'package:flutter/material.dart';
import 'package:timer_stream_app/bloc/timer_bloc.dart';

class HomeScreen extends StatelessWidget {
  final TimerBloc _timerBloc = TimerBloc();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Timer Stream'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                StreamBuilder<String>(
                  stream: _timerBloc.streamMinutes.map((value){
                    return value.toString();
                  }),
                  builder: (_, snapshot){
                    final textAux = snapshot.data ?? '';
                    return Text(textAux, style: TextStyle(fontSize: 40),);
                  },
                ),
                Text(':', style: TextStyle(fontSize: 40),),
                StreamBuilder<String>(
                  stream: _timerBloc.streamSeconds.map((value){
                    return value.toString().padLeft(2, '0');
                  }),
                  builder: (_, snapshot){
                    final textAux = snapshot.data ?? '';
                    return Text(textAux, style: TextStyle(fontSize: 40),);
                  },
                ),
              ],
            ),
            SizedBox(height: 20,),
            StreamBuilder<String>(
                stream: _timerBloc.streamButton,
                builder: (context, snapshot) {
                  return RaisedButton(
                    child: Text(snapshot.data ?? ''),
                    onPressed: _timerBloc.onPressed,
                  );
                }
            ),
          ],
        ),
      ),
    );
  }
}
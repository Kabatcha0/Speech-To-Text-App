import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:highlight_text/highlight_text.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:speechtotext/cubit/states.dart';

class SpeechCubit extends Cubit<SpeechStates> {
  SpeechCubit() : super(SpeechInitialState());
  static SpeechCubit get(context) => BlocProvider.of(context);
  bool isListen = false;
  Map<String, HighlightedWord>? highlight;
  String text = "press";
  stt.SpeechToText? speechToText;
  void init() {
    speechToText = stt.SpeechToText();
    emit(SpeechInitState());
  }

  double con = 0;
  void changeFloating() {
    isListen = !isListen;
    emit(SpeechButtomState());
  }

  void speech() async {
    if (isListen == true) {
      bool available = await speechToText!
          .initialize(onStatus: (v) {}, onError: (v) {})
          .then((value) {
        speechToText!.listen(
            localeId: "en",
            onResult: (v) {
              highlight = {
                "hello": HighlightedWord(
                    onTap: () {},
                    textStyle: const TextStyle(
                        color: Colors.blue,
                        fontSize: 23,
                        fontWeight: FontWeight.bold))
              };
              text = v.recognizedWords;
              emit(SpeechTrueState());
              if (v.hasConfidenceRating && v.confidence > 0) {
                con = v.confidence;
              }
            });
        return isListen = true;
      });
    } else {
      speechToText!.stop();
      emit(SpeechFalseState());
    }
  }
}

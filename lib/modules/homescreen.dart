import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:highlight_text/highlight_text.dart';
import 'package:speechtotext/cubit/cubit.dart';
import 'package:speechtotext/cubit/states.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SpeechCubit()..init(),
      child: BlocConsumer<SpeechCubit, SpeechStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = SpeechCubit.get(context);
          return Scaffold(
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextHighlight(
                        text: cubit.text,
                        words: cubit.highlight!,
                        textStyle: const TextStyle(
                            color: Colors.black,
                            fontSize: 25,
                            fontWeight: FontWeight.normal),
                      )
                    ],
                  ),
                ),
              ),
            ),
            floatingActionButton: AvatarGlow(
              animate: cubit.isListen,
              endRadius: 50,
              glowColor: Colors.blue,
              repeat: true,
              repeatPauseDuration: const Duration(milliseconds: 100),
              duration: const Duration(seconds: 2),
              child: FloatingActionButton(
                elevation: 0,
                onPressed: () {
                  cubit.changeFloating();
                  cubit.speech();
                },
                child: cubit.isListen
                    ? const Icon(Icons.mic)
                    : const Icon(Icons.mic_none),
              ),
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
          );
        },
      ),
    );
  }
}

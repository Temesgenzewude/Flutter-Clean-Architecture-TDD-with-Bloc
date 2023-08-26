import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../injection_container.dart';
import '../bloc/number_trivia_bloc.dart';
import '../widgets/widgets.dart';

class NumberTriviaPage extends StatelessWidget {
  const NumberTriviaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Number Trivia'),
        ),
        body: SingleChildScrollView(child: buildBody(context)));
  }

  BlocProvider<NumberTriviaBloc> buildBody(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<NumberTriviaBloc>(),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 10),
            BlocBuilder<NumberTriviaBloc, NumberTriviaState>(
                builder: (context, state) {
              if (state is Empty) {
                return const DisplayMessage(
                  message: "Start searching!",
                );
              } else if (state is Loading) {
                return const LoadingWidget();
              } else if (state is Loaded) {
                return DisplayTrivia(trivia: state.trivia);
              } else if (state is Error) {
                return DisplayMessage(message: state.message);
              } else {
                return const DisplayMessage(
                    message: "Unknown error: Unhandled state");
              }
            }),
            const SizedBox(height: 20),
            const TriviaController(),
          ],
        ),
      ),
    );
  }
}

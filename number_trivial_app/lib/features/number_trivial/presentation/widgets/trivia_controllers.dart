import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/number_trivia_bloc.dart';

class TriviaController extends StatefulWidget {
  const TriviaController({
    super.key,
  });

  @override
  State<TriviaController> createState() => _TriviaControllerState();
}

class _TriviaControllerState extends State<TriviaController> {
  late String inputStr;
  final TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      TextField(
        onChanged: (value) {
          inputStr = value;
        },
        onSubmitted: (_) {
          dispatchConcrete();
        },
        controller: controller,
        keyboardType: TextInputType.number,
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          hintText: 'Input a number',
        ),
      ),
      const SizedBox(height: 10),
      Row(
        children: [
          Expanded(
            child: ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.green),
                textStyle: MaterialStateProperty.all(
                  const TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
              onPressed: dispatchConcrete,
              child: const Text('Search'),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: ElevatedButton(
              onPressed: dispatchRandom,
              child: const Text('Get random trivia'),
            ),
          ),
        ],
      ),
    ]);
  }

  void dispatchConcrete() {
    controller.clear();
    BlocProvider.of<NumberTriviaBloc>(context)
        .add(GetTriviaForConcreteNumber(numberString: inputStr));
  }

  void dispatchRandom() {
    BlocProvider.of<NumberTriviaBloc>(context).add(GetTriviaForRandomNumber());
  }
}

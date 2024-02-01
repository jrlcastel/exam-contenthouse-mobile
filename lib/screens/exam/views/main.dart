import 'package:flutter/material.dart';
import 'package:mobile_exam/core/app/view.dart' as base;
import 'package:mobile_exam/screens/exam/bloc.dart';

class ViewState extends base.ViewState {
  final String message;
  final String image;
  final int counter;
  ViewState({
    required this.message,
    required this.image,
    required this.counter,
  });

  @override
  Widget content(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView(
        children: [
          const SizedBox(height: 20),
          Image.network(
            image,
          ),
          const SizedBox(height: 20),
          Text(message),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () => context.bloc.increment(),
            child: Text('Counter: ${counter.toString()}'),
          )
        ],
      ),
    );
  }
}

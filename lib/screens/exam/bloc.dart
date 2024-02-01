export 'package:provider/provider.dart';

import 'package:flutter/material.dart';
import 'package:mobile_exam/core/app/bloc.dart' as base;
import 'package:mobile_exam/core/extensions/map.dart';
import 'package:mobile_exam/core/services/server.dart';

import 'views/main.dart' as main_view;
import 'views/loading.dart' as loading_view;
import 'views/error.dart' as error_view;

extension Extension on BuildContext {
  Bloc get bloc => read<Bloc>();
}

class Bloc extends base.Bloc {
  Bloc(BuildContext context)
      : super(loading_view.ViewState(), context: context);

  increment() async {
    emit(loading_view.ViewState());
    await context.server.addToCount(1);
    await _fetchData();
  }

  _fetchData() async {
    final service = context.server;
    final data = await service.data;
    final statusCode = data.tryGet("status_code");

    if (statusCode == 200) {
      emit(main_view.ViewState(
        image: data['image'],
        message: data['message'],
        counter: data['count'],
      ));
      return;
    }

    emit(error_view.ViewState(data['error_message']));
  }

  @override
  void init() async {
    await _fetchData();
  }
}

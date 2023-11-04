import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'tutorial_event.dart';
part 'tutorial_state.dart';

class TutorialBloc extends Bloc<TutorialEvent, TutorialState> {
  TutorialBloc() : super(TutorialInitial()) {
    on<TutorialEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}

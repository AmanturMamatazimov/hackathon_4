import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'tender_event.dart';
part 'tender_state.dart';

class TenderBloc extends Bloc<TenderEvent, TenderState> {
  TenderBloc() : super(TenderInitial()) {
    on<TenderEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
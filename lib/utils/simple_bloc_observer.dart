import 'package:bloc/bloc.dart';
import 'utils.dart';

class SimpleBlocObserver extends BlocObserver {
  @override
  void onChange(BlocBase bloc, Change change) {
    // clog('onChange $change');
    super.onChange(bloc, change);
  }

  @override
  void onClose(BlocBase bloc) {
    // clog('onClose $bloc');
    super.onClose(bloc);
  }

  @override
  void onCreate(BlocBase bloc) {
    // clog('onCreate $bloc');
    super.onCreate(bloc);
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    clog('onError $bloc');
    super.onError(bloc, error, stackTrace);
  }

  @override
  void onEvent(Bloc bloc, Object? event) {
    // clog('onEvent $bloc $event');
    super.onEvent(bloc, event);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    // log('onTransition $bloc');
    super.onTransition(bloc, transition);
  }
}

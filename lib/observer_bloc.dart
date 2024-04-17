import 'dart:developer'; // Import log function for logging

import 'package:bloc/bloc.dart'; // Import bloc library

// Observer class to observe bloc state changes
class TodoObserver extends BlocObserver {
  // Called when a bloc is created
  @override
  void onCreate(BlocBase bloc) {
    super.onCreate(bloc);
    log('onCreate -- bloc: ${bloc.runtimeType}'); // Log bloc creation
  }

  // Called when a new event is added to the bloc
  @override
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);
    log('onEvent -- bloc: ${bloc.runtimeType}, event: $event'); // Log bloc event
  }

  // Called when the bloc's state is changed
  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    log('onChange -- bloc: ${bloc.runtimeType}, change: $change'); // Log bloc state change
  }

  // Called when a transition occurs in the bloc
  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    log('onTransition -- bloc: ${bloc.runtimeType}, transition: $transition'); // Log bloc transition
  }

  // Called when an error occurs in the bloc
  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    log('onError -- bloc: ${bloc.runtimeType}, error: $error'); // Log bloc error
    super.onError(bloc, error, stackTrace);
  }

  // Called when a bloc is closed
  @override
  void onClose(BlocBase bloc) {
    super.onClose(bloc);
    log('onClose -- bloc: ${bloc.runtimeType}'); // Log bloc closure
  }
}

import 'package:bloc/bloc.dart';
import 'package:fuji_maintenance_system/core/service/webservice/api_service.dart';

class SimpleBlocObserver implements BlocObserver {
  @override
  void onChange(BlocBase bloc, Change change) {
    logger.d('onChange -- ${bloc.runtimeType}, $change');
  }

  @override
  void onClose(BlocBase bloc) {
    logger.d('onClose -- ${bloc.runtimeType}');
  }

  @override
  void onCreate(BlocBase bloc) {
    logger.d('onCreate -- ${bloc.runtimeType}');
  }

  @override
  void onDone(
    Bloc bloc,
    Object? event, [
    Object? error,
    StackTrace? stackTrace,
  ]) {
    logger.d('onDone -- ${bloc.runtimeType}, $event');
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    logger.e('onError -- ${bloc.runtimeType}, $error');
  }

  @override
  void onEvent(Bloc bloc, Object? event) {
    logger.d('onEvent -- ${bloc.runtimeType}, $event');
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    logger.d('onTransition -- ${bloc.runtimeType}, $transition');
  }
}

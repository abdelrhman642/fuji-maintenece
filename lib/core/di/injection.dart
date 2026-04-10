import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:flutter_project/core/di/injection.config.dart';

final getIt = GetIt.instance;

@InjectableInit(
  initializerName: r'$initGetIt',
  preferRelativeImports: true,
  asExtension: false,
)
Future<void> configureDependencies() => $initGetIt(getIt);

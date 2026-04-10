import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fuji_maintenance_system/interfaces/admin/features/visits/data/repositories/visits_repo.dart';

part 'visits_state.dart';

/// Cubit for managing visits feature state
class VisitsCubit extends Cubit<VisitsState> {
  VisitsCubit(this._repo) : super(const VisitsInitial());

  final VisitsRepo _repo;
}

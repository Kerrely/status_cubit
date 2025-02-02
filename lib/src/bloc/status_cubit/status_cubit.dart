import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:status_cubit/src/bloc/status_cubit/status_cubit_methods.dart';

part 'status_state.dart';

abstract class StatusCubit<T> extends Cubit<StatusState<T>> with StatusCubitMethods<T> {
  StatusCubit() : super(StatusNoneState<T>());
}

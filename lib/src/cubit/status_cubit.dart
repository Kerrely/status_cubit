import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'status_state.dart';

abstract class StatusCubit<T> extends Cubit<StatusState<T>> {
  StatusCubit(super.initialState);

  emitSuccess(T data) {
    emit(StatusSuccessState<T>(payload: data));
  }

  emitError({Object? error, String? message}) {
    emit(StatusErrorState<T>(error: error, message: message));
  }

  emitLoading() {
    emit(StatusLoadingState<T>());
  }
}

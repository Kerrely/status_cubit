import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:status_cubit/src/bloc/status_cubit/status_cubit.dart';

/// Helper mixin to privatize the helper methods for cubit to more easily emit [StatusState]s
mixin StatusCubitMethods<T> on Cubit<StatusState<T>> {
  /// Emits a [StatusSuccessState] with the provided [data].
  ///
  /// [StatusBlocListener] will call the `onSuccess` callback.
  /// [StatusBlocBuilder] will return the `onSuccess` widget.
  @protected
  @visibleForTesting
  void emitSuccess(T data) {
    emit(StatusSuccessState<T>(payload: data));
  }

  /// Emits a [StatusErrorState] with the provided [error] and [message].
  ///
  /// `StatusBlocListener` will call the `onError` callback.
  /// `StatusBlocBuilder` will return the `onError` widget.
  @protected
  @visibleForTesting
  void emitError({
    Object? error,
    String? message,
  }) {
    emit(
      StatusErrorState<T>(
        error: error,
        message: message,
      ),
    );
  }

  /// Emits a [StatusLoadingState].
  ///
  /// `StatusBlocListener` will call the `onLoading` callback.
  /// `StatusBlocBuilder` will return the `onLoading` widget.
  @protected
  @visibleForTesting
  void emitLoading() {
    emit(StatusLoadingState<T>());
  }

  /// Emits a [StatusNoneState]. This will make the cubit to be in the initial state.
  ///
  /// `StatusBlocListener` will not call any callback.
  /// `StatusBlocBuilder` will return the `onDefault` widget.
  @protected
  @visibleForTesting
  void reset() {
    emit(StatusNoneState<T>());
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:status_cubit/src/bloc/status_cubit/status_cubit.dart';

/// A [BlocListener] that listens to the [StatusCubit] and calls the appropriate callbacks based on the [StatusState].
///
/// `onFinished` will be called when the state is either [StatusSuccessState] or [StatusErrorState]. Meaning that there
/// has been some process running and it has finished. This is useful for cleaning up resources or popping
/// the loading etc. **Note: This will be called before the `onSuccess` or `onError` callback.** That is why
/// this does not provide the state as a parameter. If you need to distinguish whether it failed or succeeded,
/// use the `onSuccess` or `onError` callback.
///
/// `onSuccess` will be called when the state is [StatusSuccessState]. **`onFinished` will be called before this.**
///
/// `onError` will be called when the state is [StatusErrorState]. **`onFinished` will be called before this.**
class StatusBlocListener<T extends StatusCubit<V>, V> extends BlocListener<T, StatusState<V>> {
  final void Function(BuildContext context, StatusSuccessState<V> state)? onSuccess;
  final void Function(BuildContext context, StatusErrorState<V> state)? onError;
  final void Function(BuildContext context, StatusLoadingState<V> state)? onLoading;
  final void Function(BuildContext context)? onFinished;

  StatusBlocListener({
    this.onSuccess,
    this.onError,
    this.onLoading,
    this.onFinished,
    super.child,
    super.bloc,
    super.listenWhen,
    super.key,
  }) : super(
          listener: (BuildContext context, StatusState<V> state) {
            if (state.isFinished) {
              onFinished?.call(context);
            }
            switch (state) {
              case StatusSuccessState<V>():
                onSuccess?.call(context, state);
              case StatusErrorState<V>():
                onError?.call(context, state);
              case StatusLoadingState<V>():
                onLoading?.call(context, state);
            }
          },
        );
}

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:status_cubit/src/cubit/status_cubit.dart';

class StatusBlocListener<T> extends BlocListener<StatusCubit<T>, StatusState<T>> {
  final void Function(BuildContext context, StatusSuccessState<T> state)? onSuccess;
  final void Function(BuildContext context, StatusErrorState<T> state)? onError;
  final void Function(BuildContext context, StatusLoadingState<T> state)? onLoading;

  StatusBlocListener({
    this.onSuccess,
    this.onError,
    this.onLoading,
    super.child,
    super.bloc,
    super.listenWhen,
    super.key,
  }) : super(
          listener: (BuildContext context, StatusState<T> state) {
            switch (state) {
              case StatusSuccessState<T>():
                onSuccess?.call(context, state);
              case StatusErrorState<T>():
                onError?.call(context, state);
              case StatusLoadingState<T>():
                onLoading?.call(context, state);
            }
          },
        );
}

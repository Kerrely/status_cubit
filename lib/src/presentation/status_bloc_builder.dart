import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:status_cubit/src/cubit/status_cubit.dart';

typedef StatusSuccessBuilder<T> = Widget Function(BuildContext context, StatusSuccessState<T> state);
typedef StatusErrorBuilder<T> = Widget Function(BuildContext context, StatusErrorState<T> state);
typedef StatusLoadingBuilder<T> = Widget Function(BuildContext context, StatusLoadingState<T> state);

class StatusBlocBuilder<T> extends BlocBuilder<StatusCubit<T>, StatusState<T>> {
  final StatusSuccessBuilder? onSuccess;
  final StatusErrorBuilder? onError;
  final StatusLoadingBuilder? onLoading;
  final WidgetBuilder? onDefault;

  StatusBlocBuilder({
    this.onSuccess,
    this.onError,
    this.onLoading,
    this.onDefault,
    super.key,
    super.bloc,
    super.buildWhen,
  }) : super(
          builder: (BuildContext context, StatusState<T> state) {
            final defaultContent = onDefault?.call(context) ?? SizedBox.shrink();
            return switch (state) {
              StatusSuccessState<T>() => onSuccess?.call(context, state) ?? defaultContent,
              StatusErrorState<T>() => onError?.call(context, state) ?? defaultContent,
              StatusLoadingState<T>() => onLoading?.call(context, state) ?? defaultContent,
              _ => defaultContent,
            };
          },
        );
}

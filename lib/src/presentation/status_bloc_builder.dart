import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:status_cubit/src/bloc/status_cubit/status_cubit.dart';

typedef StatusSuccessBuilder<V> = Widget Function(BuildContext context, StatusSuccessState<V> state);
typedef StatusErrorBuilder<V> = Widget Function(BuildContext context, StatusErrorState<V> state);
typedef StatusLoadingBuilder<V> = Widget Function(BuildContext context, StatusLoadingState<V> state);

class StatusBlocBuilder<T extends StatusCubit<V>, V> extends BlocBuilder<T, StatusState<V>> {
  final StatusSuccessBuilder<V>? onSuccess;
  final StatusErrorBuilder<V>? onError;
  final StatusLoadingBuilder<V>? onLoading;
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
          builder: (BuildContext context, StatusState<V> state) {
            final defaultContent = onDefault?.call(context) ?? SizedBox.shrink();
            return switch (state) {
              StatusSuccessState<V>() => onSuccess?.call(context, state) ?? defaultContent,
              StatusErrorState<V>() => onError?.call(context, state) ?? defaultContent,
              StatusLoadingState<V>() => onLoading?.call(context, state) ?? defaultContent,
              _ => defaultContent,
            };
          },
        );
}

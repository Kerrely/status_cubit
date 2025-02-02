part of 'status_cubit.dart';

mixin StatusFinishedMixin<T> on StatusState<T> {}

abstract class StatusState<T> extends Equatable {
  const StatusState();

  bool get isFinished => this is StatusFinishedMixin;
  bool get isSuccess => this is StatusSuccessState;
  bool get isError => this is StatusErrorState;
  bool get isLoading => this is StatusLoadingState;

  @override
  List<Object?> get props => [];
}

class StatusNoneState<T> extends StatusState<T> {}

class StatusLoadingState<T> extends StatusState<T> {}

class StatusSuccessState<T> extends StatusState<T> with StatusFinishedMixin {
  final T? payload;

  const StatusSuccessState({this.payload});

  @override
  List<Object?> get props => [payload];
}

class StatusErrorState<T> extends StatusState<T> with StatusFinishedMixin {
  final Object? error;
  final String? message;

  const StatusErrorState({
    this.error,
    this.message,
  });

  @override
  List<Object?> get props => [
        error,
        message,
      ];
}

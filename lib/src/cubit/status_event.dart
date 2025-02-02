import 'package:equatable/equatable.dart';

abstract class StatusEvent extends Equatable {}

class StatusSuccessEvent<T> extends StatusEvent {
  final T? payload;

  StatusSuccessEvent([
    this.payload,
  ]);

  @override
  List<Object?> get props => [
        payload,
      ];
}

class StatusErrorEvent extends StatusEvent {
  final Object? error;
  final String? message;

  StatusErrorEvent({
    this.error,
    this.message,
  });

  @override
  List<Object?> get props => [
        error,
        message,
      ];
}

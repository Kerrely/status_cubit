import 'package:status_cubit/status_cubit.dart';
import 'package:test/test.dart';

import 'test_status_cubit.dart';

void main() {
  group('StatusCubit', () {
    late TestStatusCubit statusCubit;

    setUp(() {
      statusCubit = TestStatusCubit();
    });

    test('initial state is StatusNoneState', () {
      expect(statusCubit.state, StatusNoneState<int>());
    });

    test('emits StatusSuccessState when success is called', () {
      final expectedStates = [
        StatusSuccessState<int>(payload: 1),
      ];
      expectLater(statusCubit.stream, emitsInOrder(expectedStates));
      statusCubit.emitSuccess(1);
    });

    test('emits StatusErrorState when error is called', () {
      final expectedStates = [
        StatusErrorState<int>(error: 'error', message: 'message'),
      ];
      expectLater(statusCubit.stream, emitsInOrder(expectedStates));
      statusCubit.emitError(error: 'error', message: 'message');
    });

    test('emits StatusLoadingState when loading is called', () {
      final expectedStates = [
        StatusLoadingState<int>(),
      ];
      expectLater(statusCubit.stream, emitsInOrder(expectedStates));
      statusCubit.emitLoading();
    });

    test('emits StatusNoneState when none is called', () {
      final expectedStates = [
        StatusNoneState<int>(),
      ];
      expectLater(statusCubit.stream, emitsInOrder(expectedStates));
      statusCubit.reset();
    });
  });
}

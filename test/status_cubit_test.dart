import 'package:status_cubit/status_cubit.dart';
import 'package:test/test.dart';

class TestStatusCubit extends StatusCubit<int> {
  TestStatusCubit() : super(StatusNoneState());

  void success(int data) {
    emit(StatusSuccessState<int>(payload: data));
  }

  void error(Object error, String message) {
    emit(StatusErrorState<int>(error: error, message: message));
  }
}

void main() {
  group('StatusCubit', () {
    setUp(() {
      // Additional setup goes here.
    });

    test('First Test', () {});
  });
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:status_cubit/status_cubit.dart';

import 'test_status_cubit.dart';

class TestWidget extends StatelessWidget {
  final TestStatusCubit statusCubit;
  final Widget child;

  const TestWidget({
    required this.statusCubit,
    required this.child,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BlocProvider<TestStatusCubit>.value(
        value: statusCubit,
        child: child,
      ),
    );
  }
}

void main() {
  group('StatusBlocBuilder', () {
    late TestStatusCubit statusCubit;

    setUp(() {
      statusCubit = TestStatusCubit();
    });

    testWidgets('renders success widget when state is StatusSuccessState', (tester) async {
      await tester.pumpWidget(
        TestWidget(
          statusCubit: statusCubit,
          child: StatusBlocBuilder<TestStatusCubit, int>(
            onSuccess: (context, state) => const Text('Success!'),
          ),
        ),
      );

      statusCubit.emitSuccess(42);
      await tester.pump();

      expect(find.text('Success!'), findsOneWidget);
    });

    testWidgets('renders error widget when state is StatusErrorState', (tester) async {
      await tester.pumpWidget(
        TestWidget(
          statusCubit: statusCubit,
          child: StatusBlocBuilder<TestStatusCubit, int>(
            onError: (context, state) => const Text('Error!'),
          ),
        ),
      );

      statusCubit.emitError(error: Exception(), message: 'Error occurred');
      await tester.pump();

      expect(find.text('Error!'), findsOneWidget);
    });

    testWidgets('renders loading widget when state is StatusLoadingState', (tester) async {
      await tester.pumpWidget(
        TestWidget(
          statusCubit: statusCubit,
          child: StatusBlocBuilder<TestStatusCubit, int>(
            onLoading: (context, state) => const CircularProgressIndicator(),
          ),
        ),
      );

      statusCubit.emitLoading();
      await tester.pump();

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('renders default widget when no state matches', (tester) async {
      await tester.pumpWidget(
        TestWidget(
          statusCubit: statusCubit,
          child: StatusBlocBuilder<TestStatusCubit, int>(
            onDefault: (context) => const Text('Default'),
          ),
        ),
      );

      statusCubit.reset();
      await tester.pump();

      expect(find.text('Default'), findsOneWidget);
    });
  });
}

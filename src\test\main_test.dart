
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_app/main.dart';

class MockAuthCubit extends MockCubit<AuthState> implements AuthCubit {}
class FakeAuthState extends Fake implements AuthState {}

void main() {
  setUpAll(() {
    registerFallbackValue(FakeAuthState());
  });

  group('Main App Initialization', () {
    testWidgets('MyApp initialization test', (WidgetTester tester) async {
      // Build the MyApp widget.
      await tester.pumpWidget(MyApp());

      // Verify that the initial route is the LoginScreen.
      expect(find.byType(LoginScreen), findsOneWidget);
    });

    testWidgets('App provides AuthCubit', (WidgetTester tester) async {
      await tester.pumpWidget(MyApp());

      // Verify that AuthCubit is provided in the widget tree.
      final authCubit = BlocProvider.of<AuthCubit>(tester.element(find.byType(MyApp)));
      expect(authCubit, isNotNull);
    });

    testWidgets('Navigates to HomeScreen on Authenticated state', (WidgetTester tester) async {
      final mockAuthCubit = MockAuthCubit();
      whenListen(
        mockAuthCubit,
        Stream<AuthState>.fromIterable([Authenticated()]),
        initialState: Unauthenticated(),
      );

      await tester.pumpWidget(
        BlocProvider<AuthCubit>.value(
          value: mockAuthCubit,
          child: MyApp(),
        ),
      );

      await tester.pumpAndSettle();

      // Verify that the navigation is done to HomeScreen.
      expect(find.byType(HomeScreen), findsOneWidget);
    });
  });
}

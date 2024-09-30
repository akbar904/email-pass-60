
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_app/screens/login_screen.dart';
import 'package:simple_app/cubits/auth_cubit.dart';

// Mocking AuthCubit
class MockAuthCubit extends MockCubit<AuthState> implements AuthCubit {}

void main() {
	group('LoginScreen Widget Tests', () {
		testWidgets('should display LoginForm widget', (WidgetTester tester) async {
			// Arrange
			await tester.pumpWidget(MaterialApp(home: LoginScreen()));

			// Act
			final loginFormFinder = find.byType(LoginForm);

			// Assert
			expect(loginFormFinder, findsOneWidget);
		});
	});

	group('AuthCubit Tests', () {
		late MockAuthCubit mockAuthCubit;

		setUp(() {
			mockAuthCubit = MockAuthCubit();
		});

		blocTest<MockAuthCubit, AuthState>(
			'emit Authenticated state when logIn is called with valid credentials',
			build: () => mockAuthCubit,
			act: (cubit) => cubit.logIn('test@example.com', 'password'),
			expect: () => [isA<Authenticated>()],
		);

		blocTest<MockAuthCubit, AuthState>(
			'emit Unauthenticated state when logOut is called',
			build: () => mockAuthCubit,
			act: (cubit) => cubit.logOut(),
			expect: () => [isA<Unauthenticated>()],
		);
	});
}

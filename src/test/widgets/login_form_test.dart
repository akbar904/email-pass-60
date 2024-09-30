
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:com.example.simple_app/widgets/login_form.dart';

class MockAuthCubit extends MockCubit<AuthState> implements AuthCubit {}

void main() {
	group('LoginForm Widget', () {
		late MockAuthCubit mockAuthCubit;

		setUp(() {
			mockAuthCubit = MockAuthCubit();
		});

		testWidgets('should display email and password text fields and login button', (tester) async {
			await tester.pumpWidget(
				MaterialApp(
					home: BlocProvider<AuthCubit>(
						create: (_) => mockAuthCubit,
						child: LoginForm(),
					),
				),
			);

			expect(find.byType(TextField), findsNWidgets(2));
			expect(find.byType(ElevatedButton), findsOneWidget);
		});

		testWidgets('should call logIn when login button is pressed with valid input', (tester) async {
			when(() => mockAuthCubit.logIn(any(), any())).thenAnswer((_) async {});

			await tester.pumpWidget(
				MaterialApp(
					home: BlocProvider<AuthCubit>(
						create: (_) => mockAuthCubit,
						child: LoginForm(),
					),
				),
			);

			final emailField = find.byKey(Key('emailField'));
			final passwordField = find.byKey(Key('passwordField'));
			final loginButton = find.byType(ElevatedButton);

			await tester.enterText(emailField, 'test@example.com');
			await tester.enterText(passwordField, 'password123');
			await tester.tap(loginButton);
			await tester.pump();

			verify(() => mockAuthCubit.logIn('test@example.com', 'password123')).called(1);
		});

		testWidgets('should show CircularProgressIndicator when state is loading', (tester) async {
			whenListen(
				mockAuthCubit,
				Stream.fromIterable([AuthState.loading()]),
				initialState: AuthState.initial(),
			);

			await tester.pumpWidget(
				MaterialApp(
					home: BlocProvider<AuthCubit>(
						create: (_) => mockAuthCubit,
						child: LoginForm(),
					),
				),
			);

			expect(find.byType(CircularProgressIndicator), findsOneWidget);
		});

		testWidgets('should show error message when state is failure', (tester) async {
			whenListen(
				mockAuthCubit,
				Stream.fromIterable([AuthState.failure('Login Failed')]),
				initialState: AuthState.initial(),
			);

			await tester.pumpWidget(
				MaterialApp(
					home: BlocProvider<AuthCubit>(
						create: (_) => mockAuthCubit,
						child: LoginForm(),
					),
				),
			);

			expect(find.text('Login Failed'), findsOneWidget);
		});
	});
}

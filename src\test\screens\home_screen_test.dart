
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter/material.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:com.example.simple_app/screens/home_screen.dart';

// Mock AuthCubit to simulate its behavior
class MockAuthCubit extends MockCubit<AuthState> implements AuthCubit {}

void main() {
	group('HomeScreen Widget Tests', () {
		testWidgets('renders LogoutButton', (WidgetTester tester) async {
			// Arrange
			final authCubit = MockAuthCubit();
			when(() => authCubit.state).thenReturn(AuthState.authenticated());

			// Act
			await tester.pumpWidget(
				MaterialApp(
					home: BlocProvider.value(
						value: authCubit,
						child: HomeScreen(),
					),
				),
			);

			// Assert
			expect(find.byType(LogoutButton), findsOneWidget);
			expect(find.text('Logout'), findsOneWidget);
		});
	});
}

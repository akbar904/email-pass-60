
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:com.example.simple_app/widgets/logout_button.dart';
import 'package:com.example.simple_app/cubits/auth_cubit.dart';

class MockAuthCubit extends MockCubit<AuthState> implements AuthCubit {}

void main() {
	group('LogoutButton Widget Tests', () {
		testWidgets('renders LogoutButton with correct text', (WidgetTester tester) async {
			// Arrange
			final mockAuthCubit = MockAuthCubit();
			
			await tester.pumpWidget(
				MaterialApp(
					home: BlocProvider.value(
						value: mockAuthCubit,
						child: LogoutButton(),
					),
				),
			);
			
			// Act & Assert
			expect(find.text('Logout'), findsOneWidget);
		});

		testWidgets('LogoutButton triggers logOut on AuthCubit when pressed', (WidgetTester tester) async {
			// Arrange
			final mockAuthCubit = MockAuthCubit();
			when(() => mockAuthCubit.logOut()).thenAnswer((_) async {});

			await tester.pumpWidget(
				MaterialApp(
					home: BlocProvider.value(
						value: mockAuthCubit,
						child: LogoutButton(),
					),
				),
			);

			// Act
			await tester.tap(find.byType(ElevatedButton));
			await tester.pump();

			// Assert
			verify(() => mockAuthCubit.logOut()).called(1);
		});
	});
}

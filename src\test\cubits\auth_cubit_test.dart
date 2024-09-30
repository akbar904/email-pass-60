
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:your_package_name/cubits/auth_cubit.dart';
import 'package:your_package_name/models/user_model.dart';

// Define a mock AuthCubit for testing
class MockAuthCubit extends MockCubit<AuthState> implements AuthCubit {}

void main() {
	group('AuthCubit', () {
		late MockAuthCubit authCubit;

		setUp(() {
			authCubit = MockAuthCubit();
		});

		blocTest<AuthCubit, AuthState>(
			'emits [Authenticated] when logIn is successful',
			build: () => authCubit,
			act: (cubit) => cubit.logIn('test@example.com', 'password123'),
			expect: () => [isA<Authenticated>()],
		);

		blocTest<AuthCubit, AuthState>(
			'emits [Unauthenticated] when logOut is called',
			build: () => authCubit,
			act: (cubit) => cubit.logOut(),
			expect: () => [isA<Unauthenticated>()],
		);
	});
}

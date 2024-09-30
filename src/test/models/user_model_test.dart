
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:com.example.simple_app/models/user_model.dart';

void main() {
	group('User Model', () {
		test('should create a User instance with email and password', () {
			final user = User(email: 'test@example.com', password: 'password123');

			expect(user.email, equals('test@example.com'));
			expect(user.password, equals('password123'));
		});

		test('should serialize User to JSON', () {
			final user = User(email: 'test@example.com', password: 'password123');
			final json = user.toJson();

			expect(json, {'email': 'test@example.com', 'password': 'password123'});
		});

		test('should deserialize User from JSON', () {
			final json = {'email': 'test@example.com', 'password': 'password123'};
			final user = User.fromJson(json);

			expect(user.email, equals('test@example.com'));
			expect(user.password, equals('password123'));
		});
	});
}

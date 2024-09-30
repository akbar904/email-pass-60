
import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/user_model.dart';

abstract class AuthState {}

class Unauthenticated extends AuthState {}

class Authenticated extends AuthState {
	final User user;

	Authenticated(this.user);
}

class AuthCubit extends Cubit<AuthState> {
	AuthCubit() : super(Unauthenticated());

	void logIn(String email, String password) {
		// Here you would normally make a call to an authentication service
		// For simplicity, we're assuming the login is always successful
		if (email.isNotEmpty && password.isNotEmpty) {
			final user = User(email, password);
			emit(Authenticated(user));
		} else {
			emit(Unauthenticated());
		}
	}

	void logOut() {
		emit(Unauthenticated());
	}
}

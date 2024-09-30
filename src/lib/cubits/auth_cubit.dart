
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

	void logIn() {
		// Here you would normally make a call to an authentication service
		// For simplicity, we're assuming the login is always successful
		final user = User('zharfan@gmail.com', 'cat');
		emit(Authenticated(user));
	}

	void logOut() {
		emit(Unauthenticated());
	}
}

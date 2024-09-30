
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../widgets/login_form.dart';
import '../cubits/auth_cubit.dart';

class LoginScreen extends StatelessWidget {
	const LoginScreen({Key? key}) : super(key: key);

	@override
	Widget build(BuildContext context) {
		return Scaffold(
			appBar: AppBar(
				title: Text('Login'),
			),
			body: BlocProvider(
				create: (context) => AuthCubit(email: 'zharfan@gmail.com', password: 'cat'),
				child: LoginForm(buttonText: 'Login Yuk'),
			),
		);
	}
}

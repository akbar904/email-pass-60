
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubits/auth_cubit.dart';

class LoginForm extends StatefulWidget {
	const LoginForm({Key? key}) : super(key: key);

	@override
	_LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
	final _emailController = TextEditingController(text: "zharfan@gmail.com");
	final _passwordController = TextEditingController(text: "cat");

	@override
	void dispose() {
		_emailController.dispose();
		_passwordController.dispose();
		super.dispose();
	}

	@override
	Widget build(BuildContext context) {
		return BlocListener<AuthCubit, AuthState>(
			listener: (context, state) {
				if (state is AuthStateFailure) {
					ScaffoldMessenger.of(context).showSnackBar(
						SnackBar(
							content: Text(state.message),
						),
					);
				} else if (state is AuthStateSuccess) {
					Navigator.pushReplacementNamed(context, '/home');
				}
			},
			child: BlocBuilder<AuthCubit, AuthState>(
				builder: (context, state) {
					if (state is AuthStateLoading) {
						return Center(
							child: CircularProgressIndicator(),
						);
					}

					return Padding(
						padding: const EdgeInsets.all(16.0),
						child: Column(
							mainAxisAlignment: MainAxisAlignment.center,
							children: [
								TextField(
									key: Key('emailField'),
									controller: _emailController,
									decoration: InputDecoration(
										labelText: 'Email',
									),
									keyboardType: TextInputType.emailAddress,
								),
								TextField(
									key: Key('passwordField'),
									controller: _passwordController,
									decoration: InputDecoration(
										labelText: 'Password',
									),
									obscureText: true,
								),
								SizedBox(height: 16.0),
								ElevatedButton(
									onPressed: () {
										final email = _emailController.text;
										final password = _passwordController.text;
										context.read<AuthCubit>().logIn(email, password);
									},
									child: Text('Login Yuk'),
								),
							],
						),
					);
				},
			),
		);
	}
}

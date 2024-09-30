
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'screens/login_screen.dart';
import 'screens/home_screen.dart';
import 'cubits/auth_cubit.dart';

void main() {
	runApp(MyApp());
}

class MyApp extends StatelessWidget {
	@override
	Widget build(BuildContext context) {
		return BlocProvider(
			create: (context) => AuthCubit(defaultEmail: 'zharfan@gmail.com', defaultPassword: 'cat'),
			child: MaterialApp(
				title: 'Simple App',
				theme: ThemeData(
					primarySwatch: Colors.blue,
				),
				home: BlocListener<AuthCubit, AuthState>(
					listener: (context, state) {
						if (state is Authenticated) {
							Navigator.of(context).pushReplacement(
								MaterialPageRoute(builder: (context) => HomeScreen()),
							);
						}
					},
					child: BlocBuilder<AuthCubit, AuthState>(
						builder: (context, state) {
							if (state is Unauthenticated) {
								return LoginScreen(loginButtonText: 'Login Yuk');
							} else if (state is Authenticated) {
								return HomeScreen();
							}
							return Scaffold(
								body: Center(child: CircularProgressIndicator()),
							);
						},
					),
				),
			),
		);
	}
}

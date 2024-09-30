
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
			create: (context) => AuthCubit(
				defaultEmail: 'zharfan@gmail.com',
				defaultPassword: 'cat',
			),
			child: MaterialApp(
				title: 'Simple App',
				theme: ThemeData(
					primarySwatch: Colors.blue,
				),
				home: BlocBuilder<AuthCubit, AuthState>(
					builder: (context, state) {
						if (state is Authenticated) {
							return HomeScreen();
						} else {
							return LoginScreen(
								loginButtonText: 'Login Yuk',
							);
						}
					},
				),
			),
		);
	}
}

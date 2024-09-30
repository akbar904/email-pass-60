
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubits/auth_cubit.dart';

class LogoutButton extends StatelessWidget {
	const LogoutButton({Key? key}) : super(key: key);

	@override
	Widget build(BuildContext context) {
		final authCubit = context.read<AuthCubit>();

		return ElevatedButton(
			onPressed: () {
				authCubit.logOut();
			},
			child: const Text('Logout'),
		);
	}
}

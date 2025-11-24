import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../config/theme/app_colors.dart';
import '../../../auth/presentation/blocs/auth/auth_bloc.dart';
import '../../../auth/presentation/blocs/auth/auth_state.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final authState = context.watch<AuthBloc>().state;

    String username = "Guest";

    if (authState is AuthAuthenticated) {
      username = authState.user.name;
    }

    return Row(
      children: [
        const CircleAvatar(
          radius: 22,
          backgroundImage: NetworkImage('https://i.pravatar.cc/150?img=3'),
        ),
        const SizedBox(width: 12),

        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Hi $username',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 2),
              const Text(
                'Everything for your home needs',
                style: TextStyle(
                  color: AppColors.textSecondary,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),

        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.more_vert),
          color: Colors.black,
        ),
      ],
    );
  }
}
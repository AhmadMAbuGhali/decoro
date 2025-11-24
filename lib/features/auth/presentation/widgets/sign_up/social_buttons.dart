import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../config/constants/asset_paths.dart';
import '../../../../../config/theme/app_colors.dart';
import '../../blocs/auth/auth_bloc.dart';
import '../../blocs/auth/auth_event.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SocialButtons extends StatelessWidget {
  const SocialButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Google
          Center(
            child: SizedBox(
              width: 335,
              height: 56,
              child: ElevatedButton.icon(
                onPressed: () {
                  context.read<AuthBloc>().add(AuthGoogleRequested());
                },
                icon: SvgPicture.asset(
                  AssetPaths.googleIcon,
                  width: 25,
                  height: 25,
                ),
                label: const Text(
                  'Sign Up with Google',
                  style: TextStyle(color: Colors.black),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                    side: BorderSide(color: Colors.black),
                  ),
                ),
              ),
            ),
          ),

          const SizedBox(height: 12),

          // Apple
          Center(
            child: SizedBox(
              width: 335,
              height: 56,
              child: ElevatedButton.icon(
                onPressed: () {
                  context.read<AuthBloc>().add(AuthAppleRequested());
                },
                icon: const Icon(Icons.apple, color: Colors.black, size: 25),
                label: const Text(
                  'Sign Up with Apple',
                  style: TextStyle(color: Colors.black),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                    side: BorderSide(color: Colors.black),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
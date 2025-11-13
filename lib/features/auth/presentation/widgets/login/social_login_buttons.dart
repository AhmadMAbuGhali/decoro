import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_svg/flutter_svg.dart';
import '../../../../../../config/constants/asset_paths.dart';
import '../../blocs/auth/auth_bloc.dart';
import '../../blocs/auth/auth_event.dart';

class SocialLoginButtons extends StatelessWidget {
  const SocialLoginButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 10),
        Row(
          children: [
          Expanded(child: Divider()),
             Text("   Or continue with   ", style: TextStyle(color: Colors.black54)),
            Expanded(child: Divider()),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _socialButton(
              onTap: () => context.read<AuthBloc>().add(AuthWithGoogleRequested()),
              asset: AssetPaths.googleIcon,
            ),
            const SizedBox(width: 12),
            _socialButton(
              onTap: () => context.read<AuthBloc>().add(AuthWithAppleRequested()),
              icon: Icons.apple,
            ),
            const SizedBox(width: 12),
            _socialButton(
              onTap: () => context.read<AuthBloc>().add(AuthWithFacebookRequested()),
              asset: AssetPaths.facebookIcon,
            ),
          ],
        ),
      ],
    );
  }

  Widget _socialButton({
    required VoidCallback onTap,
    IconData? icon,
    String? asset,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 52,
        height: 52,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black12),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Center(
          child: icon != null
              ? Icon(icon, color: Colors.black, size: 26)
              : SvgPicture.asset(asset!, width: 26, height: 26),
        ),
      ),
    );
  }
}
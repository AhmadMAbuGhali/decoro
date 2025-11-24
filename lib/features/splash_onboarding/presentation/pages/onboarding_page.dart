import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../app/di.dart';
import '../../../../config/constants/asset_paths.dart';
import '../../../../config/router/route_path.dart';
import '../../data/repositories/onboarding_repository.dart';
import '../blocs/onboarding_bloc.dart';
import '../blocs/onboarding_event.dart';
import '../blocs/onboarding_state.dart';
import '../widgets/onboarding_item.dart';
import '../widgets/progress_indicator.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final PageController _pageController = PageController();
  int currentIndex = 0;

  final List<Map<String, String>> pages = [
    {
      'image': AssetPaths.onBoarding1,
      'title': 'Where Sophistication Meets Every Step',
      'description':
      'Discover handcrafted shoes designed for timeless elegance and unmatched comfort.',
    },
    {
      'image': AssetPaths.onBoarding2,
      'title': 'Style, Comfort, Repeat Every Day',
      'description':
      'Luxury isn’t just a label—it’s how you walk through the world.',
    },
  ];

  void _goNext() {
    if (currentIndex == pages.length - 1) {
      context.read<OnboardingBloc>().add(OnboardingCompleteRequested());
      Navigator.pushReplacementNamed(context, RoutePaths.getLetStart);
    } else {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => OnboardingBloc(sl<OnboardingRepository>()),
      child: BlocListener<OnboardingBloc, OnboardingState>(
        listener: (context, state) {
          if (state is OnboardingSaved && context.mounted) {
            Navigator.pushReplacementNamed(context, RoutePaths.getLetStart);
          }
        },
        child: Scaffold(
          body: SafeArea(
            child: Stack(
              children: [
                PageView.builder(
                  controller: _pageController,
                  itemCount: pages.length,
                  onPageChanged: (i) => setState(() => currentIndex = i),
                  itemBuilder: (_, i) => OnboardingItem(
                    imagePath: pages[i]['image']!,
                    isFullScreen: true,
                  ),
                ),

                // Skip
                Positioned(
                  top: 16,
                  right: 16,
                  child: TextButton(
                    onPressed: _goNext,
                    child: const Text(
                      "Skip",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),

                // Content
                Positioned(
                  left: 24,
                  right: 24,
                  bottom: 140,
                  child: Column(
                    children: [
                      Text(
                        pages[currentIndex]['title']!,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        pages[currentIndex]['description']!,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 20),
                      ProgressIndicatorDots(
                        itemCount: pages.length,
                        currentIndex: currentIndex,
                      )
                    ],
                  ),
                ),

                // Button
                Positioned(
                  left: 24,
                  right: 24,
                  bottom: 50,
                  child: ElevatedButton(
                    onPressed: _goNext,
                    child: Text(
                      currentIndex == pages.length - 1 ? "Start" : "Next",
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
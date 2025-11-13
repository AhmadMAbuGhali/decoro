import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../config/constants/asset_paths.dart';
import '../../data/repositories/onboarding_repository.dart';
import '../blocs/onboarding_bloc.dart';
import '../blocs/onboarding_event.dart';
import '../blocs/onboarding_state.dart';
import '../widgets/onboarding_item.dart';
import '../widgets/progress_indicator.dart';
import '../../../../config/router/route_path.dart';
import '../../../../app/di.dart';

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
      'description': 'Discover handcrafted shoes designed for timeless elegance and unmatched comfort. Made for those who value quality in every step',
    },
    {
      'image': AssetPaths.onBoarding2,
      'title': 'Style, Comfort, Repeat Every Day',
      'description': 'Luxury isn’t just a label—it’s how you walk through the world. Explore curated collections that speak style, class, and confidence.',
    },

  ];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => OnboardingBloc(sl<OnboardingRepository>()),
      child: BlocListener<OnboardingBloc, OnboardingState>(
        listenWhen: (_, state) => state is OnboardingSaved,
        listener: (context, state) {
          if (state is OnboardingSaved) {
            Navigator.of(context).pushReplacementNamed(RoutePaths.home);
          }
        },
        child: Scaffold(
          body: Stack(
            children: [
              PageView.builder(
                controller: _pageController,
                itemCount: pages.length,
                onPageChanged: (index) => setState(() => currentIndex = index),
                itemBuilder: (context, index) {
                  final item = pages[index];
                  // الصورة تغطي الشاشة بالكامل
                  return OnboardingItem(
                    imagePath: item['image']!,

                    isFullScreen: true,
                  );
                },
              ),
              // Skip button top-right
              Positioned(
                top: 80,
                right: 20,
                child: TextButton(
                  onPressed: () {
                    Navigator.of(context).pushReplacementNamed(RoutePaths.getLetStart);

                  },
                  child: const Text(
                    'Skip',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ),
              // Progress dots + texts (title/description) فوق زر Next
              Positioned(
                bottom: 130,
                left: 24,
                right: 24,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      pages[currentIndex]['title']!,
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      pages[currentIndex]['description']!,
                      style: const TextStyle(
                        shadows: [
                          Shadow(
                            offset: Offset(1, 1), // مقدار الإزاحة X و Y
                            blurRadius: 3,        // مقدار التمويه
                            color: Colors.black54, // لون الظل (شفاف جزئي)
                          ),
                          Shadow(
                            offset: Offset(-1, -1),
                            blurRadius: 3,
                            color: Colors.black38,
                          ),
                        ],
                          color: Colors.white, fontSize: 16),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 24),
                    ProgressIndicatorDots(
                      currentIndex: currentIndex,
                      itemCount: pages.length,
                    ),
                  ],
                ),
              ),
              // Next button full width
              Positioned(
                bottom: 50,
                left: 24,
                right: 24,
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      if (currentIndex == pages.length - 1) {
                        Navigator.of(context).pushReplacementNamed(RoutePaths.getLetStart);
                      } else {
                        _pageController.nextPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,

                        );
                      }
                    },
                    child: Text(currentIndex == pages.length - 1 ? 'Start' : 'Next'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
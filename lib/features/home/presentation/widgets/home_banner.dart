import 'package:flutter/material.dart';
import '../../../../config/constants/asset_paths.dart';
import '../../../../config/theme/app_colors.dart';

class HomeBanner extends StatelessWidget {
  const HomeBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 190, // مساحة أفضل للبنر والصورة
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // ===== البانر الأساسي =====
          Container(
            height: 162,
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(14),
            ),
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                // النص + المساحة الفارغة للصورة
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            'Discover Our Furniture Collection',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              height: 1.2,
                            ),
                          ),
                          SizedBox(height: 6),
                          Text(
                            'Enjoy discounts of up to 10% on every order today',
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 12,
                              height: 1.2,
                            ),
                          ),
                        ],
                      ),
                    ),

                    // **حجز مساحة للصورة حتى ما تغطي النص**
                    const SizedBox(width: 120),
                  ],
                ),

                const SizedBox(height: 12),

                // زر View Details
                SizedBox(
                  height: 32,
                  width: 120,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.zero,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      backgroundColor: Colors.white,
                    ),
                    child: Text(
                      "View Details",
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.primary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // ===== الصورة الطالعة من تحت (بدون أي تغيير!) =====
          Positioned(
            right: -20,
            bottom: -25,
            child: SizedBox(
              width: 191,
              height: 231,
              child: Image.asset(
                AssetPaths.chir1,
                fit: BoxFit.contain,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
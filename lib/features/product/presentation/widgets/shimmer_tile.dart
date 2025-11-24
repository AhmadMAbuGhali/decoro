import 'package:flutter/material.dart';

class ShimmerTile extends StatelessWidget {
  const ShimmerTile({super.key});

  @override
  Widget build(BuildContext context) {
    // very simple shimmer-like placeholder with animated opacity
    return LayoutBuilder(builder: (context, constraints) {
      return _AnimatedPlaceholder(width: constraints.maxWidth, height: constraints.maxHeight);
    });
  }
}

class _AnimatedPlaceholder extends StatefulWidget {
  final double width;
  final double height;
  const _AnimatedPlaceholder({required this.width, required this.height});
  @override
  State<_AnimatedPlaceholder> createState() => _AnimatedPlaceholderState();
}

class _AnimatedPlaceholderState extends State<_AnimatedPlaceholder> with SingleTickerProviderStateMixin {
  late AnimationController _c;
  late Animation<double> _a;
  @override
  void initState() {
    super.initState();
    _c = AnimationController(vsync: this, duration: const Duration(seconds: 2))..repeat(reverse: true);
    _a = Tween<double>(begin: 0.2, end: 0.6).animate(_c);
  }

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _a,
      child: Container(
        width: widget.width,
        height: widget.height,
        decoration: BoxDecoration(
          color: Colors.grey.shade300,
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
}
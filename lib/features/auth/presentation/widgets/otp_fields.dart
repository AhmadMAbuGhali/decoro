import 'package:flutter/material.dart';
import '../../../../config/theme/app_colors.dart';

class OtpFields extends StatefulWidget {
  final void Function(String) onChanged;
  const OtpFields({super.key, required this.onChanged});

  @override
  State<OtpFields> createState() => _OtpFieldsState();
}

class _OtpFieldsState extends State<OtpFields> {
  final _controllers =
  List.generate(4, (_) => TextEditingController(), growable: false);

  @override
  void dispose() {
    for (final c in _controllers) {
      c.dispose();
    }
    super.dispose();
  }

  void _updateValue() {
    final code = _controllers.map((e) => e.text).join();
    widget.onChanged(code);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(4, (i) {
        return SizedBox(
          width: 65,
          height: 65,
          child: TextField(
            controller: _controllers[i],
            textAlign: TextAlign.center,
            maxLength: 1,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              counterText: '',
              filled: true,
              fillColor: Colors.grey.shade100,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide:
                const BorderSide(color: AppColors.primary, width: 1.2),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide:
                const BorderSide(color: AppColors.primary, width: 1.8),
              ),
            ),
            onChanged: (value) {
              if (value.isNotEmpty && i < 3) {
                FocusScope.of(context).nextFocus();
              }
              _updateValue();
            },
          ),
        );
      }),
    );
  }
}
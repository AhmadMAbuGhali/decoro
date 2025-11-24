import 'package:flutter/material.dart';

class FilterDropdown extends StatelessWidget {
  final String label;
  final String? value; // 🟢 تسمح بالقيم null
  final List<String> items;
  final Function(String?) onChanged; // 🟢 تسمح بالقيم null

  const FilterDropdown({
    super.key,
    required this.label,
    required this.value,
    required this.items,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(10),
          ),
          child: DropdownButton<String>(
            value: value, // 🟢 null بتزبط الآن
            hint: const Text("Select"),
            isExpanded: true,
            underline: const SizedBox(),
            items: items.map((e) {
              return DropdownMenuItem(
                value: e,
                child: Text(e),
              );
            }).toList(),
            onChanged: onChanged,
          ),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';

class FilterChips extends StatelessWidget {
  final List<String> options;
  final String selected;
  final ValueChanged<String> onSelected;
  const FilterChips({super.key, required this.options, required this.selected, required this.onSelected});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      children: options.map((o) {
        final sel = selected == o;
        return ChoiceChip(
          label: Text(o),
          selected: sel,
          onSelected: (_) => onSelected(o),
        );
      }).toList(),
    );
  }
}

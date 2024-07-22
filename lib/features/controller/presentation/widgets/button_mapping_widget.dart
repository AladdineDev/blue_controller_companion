import 'package:blue_controller_companion/enums/button_type.dart';
import 'package:blue_controller_companion/extensions/build_context_extension.dart';
import 'package:flutter/material.dart';

class ButtonMappingWidget extends StatefulWidget {
  const ButtonMappingWidget({
    super.key,
    required this.buttonMapping,
    required this.onMappingChanged,
  });

  final MapEntry<String, ButtonType> buttonMapping;
  final ValueChanged<MapEntry<String, ButtonType>> onMappingChanged;

  @override
  State<ButtonMappingWidget> createState() => _ButtonMappingWidgetState();
}

class _ButtonMappingWidgetState extends State<ButtonMappingWidget> {
  ButtonType? selectedButtonType;

  @override
  void initState() {
    selectedButtonType = widget.buttonMapping.value;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final buttonMapping = widget.buttonMapping;
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              buttonMapping.key,
              style: context.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            DropdownButton<ButtonType>(
              value: selectedButtonType,
              hint: const Text("Button"),
              items: ButtonType.values.map((value) {
                if (buttonMapping.value == value) {
                  return DropdownMenuItem(
                    value: value,
                    onTap: null,
                    enabled: false,
                    child: Text(value.name),
                  );
                }
                return DropdownMenuItem(
                  value: value,
                  child: Text(value.name),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedButtonType = value;
                });
                widget.onMappingChanged(MapEntry(buttonMapping.key, value!));
              },
            ),
          ],
        ),
      ),
    );
  }
}

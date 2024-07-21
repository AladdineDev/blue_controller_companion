import 'package:blue_controller_companion/enums/controller_button_enum.dart';
import 'package:blue_controller_companion/extensions/build_context_extension.dart';
import 'package:flutter/material.dart';

class ButtonMappingWidget extends StatefulWidget {
  final ButtonType button;

  const ButtonMappingWidget({super.key, required this.button});

  @override
  State<ButtonMappingWidget> createState() => _ButtonMappingWidgetState();
}

class _ButtonMappingWidgetState extends State<ButtonMappingWidget> {
  ButtonType? selectedButtonType;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              widget.button.name,
              style: context.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            DropdownButton<ButtonType>(
              value: selectedButtonType,
              hint: const Text("Map Action"),
              items: ButtonType.values.map((value) {
                if (widget.button == value) {
                  return DropdownMenuItem(
                    value: value,
                    onTap: null,
                    enabled: false,
                    child: Text(
                      value.name,
                      style: context.textTheme.bodyLarge?.copyWith(
                        color: context.theme.disabledColor,
                      ),
                    ),
                  );
                }
                return DropdownMenuItem(
                  value: value,
                  child: Text(
                    value.name,
                    style: context.textTheme.bodyLarge,
                  ),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedButtonType = value;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}

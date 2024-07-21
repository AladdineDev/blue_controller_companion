import 'package:blue_controller_companion/enums/controller_button_enum.dart';
import 'package:blue_controller_companion/features/controller/presentation/widgets/button_mapping_widget.dart';
import 'package:flutter/material.dart';

class ControllerScreen extends StatelessWidget {
  const ControllerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Controller Configuration"),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: () {},
          ),
        ],
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(8.0),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 8.0,
          crossAxisSpacing: 8.0,
        ),
        itemCount: ControllerButton.values.length,
        itemBuilder: (context, index) {
          return ButtonMappingWidget(
            button: ControllerButton.values[index],
          );
        },
      ),
    );
  }
}

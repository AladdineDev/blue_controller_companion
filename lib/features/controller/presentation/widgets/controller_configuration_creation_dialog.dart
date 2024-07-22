import 'package:blue_controller_companion/enums/button_type.dart';
import 'package:blue_controller_companion/features/controller/data/provider/controller_provider.dart';
import 'package:blue_controller_companion/features/controller/data/repository/controller_repository.dart';
import 'package:blue_controller_companion/features/controller/domain/game_config_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ControllerConfigurationCreationDialog extends HookConsumerWidget {
  const ControllerConfigurationCreationDialog({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final nameController = useTextEditingController();

    return AlertDialog(
      title: const Text("Create new controller configuration"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: nameController,
            decoration: const InputDecoration(
              labelText: "Name",
              hintText: "Enter a name",
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: context.pop,
          child: const Text("Cancel"),
        ),
        TextButton(
          onPressed: () async {
            await ref.read(controllerRepositoryProvider).createGameConfig(
                  GameConfig(
                    id: null,
                    buttonMapping: {
                      ButtonType.CROSS.name: ButtonType.CROSS,
                      ButtonType.TRIANGLE.name: ButtonType.TRIANGLE,
                      ButtonType.SQUARE.name: ButtonType.SQUARE,
                      ButtonType.CIRCLE.name: ButtonType.CIRCLE,
                      ButtonType.L1.name: ButtonType.L1,
                      ButtonType.R1.name: ButtonType.R1,
                      ButtonType.L2.name: ButtonType.L2,
                      ButtonType.R2.name: ButtonType.R2,
                      ButtonType.L3.name: ButtonType.L3,
                      ButtonType.R3.name: ButtonType.R3,
                      ButtonType.HAT_UP.name: ButtonType.HAT_UP,
                      ButtonType.HAT_DOWN.name: ButtonType.HAT_DOWN,
                      ButtonType.HAT_LEFT.name: ButtonType.HAT_LEFT,
                      ButtonType.HAT_RIGHT.name: ButtonType.HAT_RIGHT,
                      ButtonType.OPTIONS.name: ButtonType.OPTIONS,
                      ButtonType.SHARE.name: ButtonType.SHARE,
                    },
                    name: nameController.text,
                  ),
                );
            ref.invalidate(controllersProvider);
            if (context.mounted) context.pop();
          },
          child: const Text("Save"),
        ),
      ],
    );
  }
}

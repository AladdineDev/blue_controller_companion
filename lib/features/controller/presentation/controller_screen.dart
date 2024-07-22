import 'package:blue_controller_companion/enums/button_type.dart';
import 'package:blue_controller_companion/features/controller/data/provider/controller_provider.dart';
import 'package:blue_controller_companion/features/controller/data/repository/controller_repository.dart';
import 'package:blue_controller_companion/features/controller/domain/game_config_data_model.dart';
import 'package:blue_controller_companion/features/controller/presentation/widgets/button_mapping_widget.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ControllerConfigurationScreen extends ConsumerStatefulWidget {
  const ControllerConfigurationScreen({
    super.key,
    required this.controllerConfigurationId,
  });

  final String controllerConfigurationId;

  @override
  ConsumerState<ControllerConfigurationScreen> createState() =>
      _ControllerConfigurationScreenState();
}

class _ControllerConfigurationScreenState
    extends ConsumerState<ControllerConfigurationScreen> {
  ButtonMapping? buttonMapping;

  @override
  Widget build(BuildContext context) {
    return ref
        .watch(controllerProvider(id: widget.controllerConfigurationId))
        .when(
      data: (gameConfigData) {
        final gameConfig = gameConfigData.data;
        final gameConfigName = gameConfig?.name ?? "No name";
        buttonMapping ??= ButtonMapping.from(gameConfig?.buttonMapping ?? {});

        if (buttonMapping == null) {
          return const Center(
            child: Text("Error: No button mapping"),
          );
        }

        return Scaffold(
          appBar: AppBar(
            title: Text(gameConfigName),
            actions: [
              IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () async {
                  final confirm = await showDialog<bool>(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text('Confirm Deletion'),
                        content: const Text(
                          'Are you sure you want to delete this configuration?',
                        ),
                        actions: [
                          TextButton(
                            onPressed: () => context.pop(false),
                            child: const Text('Cancel'),
                          ),
                          TextButton(
                            onPressed: () => context.pop(true),
                            child: const Text('Delete'),
                          ),
                        ],
                      );
                    },
                  );
                  if (confirm == true) {
                    await ref
                        .read(controllerRepositoryProvider)
                        .deleteGameConfig(widget.controllerConfigurationId);
                    if (context.mounted) context.pop();
                    ref.invalidate(controllersProvider);
                  }
                },
              ),
              IconButton(
                icon: const Icon(Icons.save),
                onPressed: () async {
                  try {
                    final updatedGameConfig =
                        gameConfig!.copyWith(buttonMapping: buttonMapping);
                    await ref
                        .read(controllerRepositoryProvider)
                        .updateGameConfig(
                          widget.controllerConfigurationId,
                          updatedGameConfig,
                        );
                    if (context.mounted) {
                      context.pop();
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Configuration saved successfully'),
                        ),
                      );
                    }
                  } catch (error) {
                    if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Failed to save configuration: $error'),
                        ),
                      );
                    }
                  }
                },
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
            itemCount: ButtonType.values.length,
            itemBuilder: (context, index) {
              final entry = buttonMapping!.entries.elementAt(index);
              return ButtonMappingWidget(
                buttonMapping: entry,
                onMappingChanged: (newEntry) {
                  setState(() {
                    buttonMapping![newEntry.key] = newEntry.value;
                  });
                },
              );
            },
          ),
        );
      },
      error: (error, stackTrace) {
        return Scaffold(
          appBar: AppBar(
            title: const Text("Configuration not found"),
          ),
          body: Center(
            child: Text("Error: $error"),
          ),
        );
      },
      loading: () {
        return Scaffold(
          appBar: AppBar(
            title: const Text("Configuration not found"),
          ),
          body: const Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}

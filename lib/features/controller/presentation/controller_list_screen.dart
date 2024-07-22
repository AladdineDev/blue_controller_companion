import 'package:blue_controller_companion/common/widgets/spinner.dart';
import 'package:blue_controller_companion/features/controller/data/provider/controller_provider.dart';
import 'package:blue_controller_companion/features/controller/presentation/widgets/controller_configuration_creation_dialog.dart';
import 'package:blue_controller_companion/router/router.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ControllerConfigurationListScreen extends HookConsumerWidget {
  const ControllerConfigurationListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Controller Configurations"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return const ControllerConfigurationCreationDialog();
            },
          );
        },
        child: const Icon(Icons.add),
      ),
      body: ref.watch(controllersProvider).when(
        data: (data) {
          final gameConfigs = data.data;
          return ListView.builder(
            padding: const EdgeInsets.all(8),
            itemCount: gameConfigs.length,
            itemBuilder: (context, index) {
              final gameConfig = gameConfigs[index];
              final gameConfigName = gameConfig.name ?? "No name";
              return Card(
                child: ListTile(
                  title: Text(gameConfigName),
                  onTap: () {
                    final gameConfigId = gameConfig.id;
                    if (gameConfigId == null) return;
                    ControllerConfigurationScreenRoute(
                      controllerConfigurationId: gameConfigId,
                    ).push(context);
                  },
                ),
              );
            },
          );
        },
        error: (error, stackTrace) {
          return Center(
            child: Text("Error: $error"),
          );
        },
        loading: () {
          return const Spinner.medium();
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/view_models.dart/bike_device.dart';
import '../../provider/bike_connection_state_provider.dart';
import '../../provider/bike_list_provider.dart';
import '../../provider/bike_readings_provider.dart';
import '../../provider/model_info_provider.dart';
import '../../provider/selected_bike_provider.dart';

class DiscoveredBikes extends ConsumerWidget {
  const DiscoveredBikes({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textTheme = Theme.of(context).textTheme;
    final bikesListState = ref.watch(bikeListProvider);
    final selectedBike = ref.watch(selectedBikeProvider);

    return Column(
      children: [
        Padding(
          padding: EdgeInsets.all(16),
          child: Text(
            'Discovered Bikes',
            style: textTheme.headlineMedium,
          ),
        ),
        Expanded(
          child: SingleChildScrollView(
            child: bikesListState.when(
              data: (bikes) {
                if (bikes.isEmpty) {
                  return Center(
                      child: Text(
                    "No bikes found",
                    style: textTheme.bodyLarge,
                  ));
                }
                return DiscoveredBikesList(
                  bikes: bikes,
                  selectedBike: selectedBike,
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (e, _) => Center(child: Text("Error: $e")),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: selectedBike != null
                      ? () async {
                          if (!selectedBike.isConnected) {
                            /// Connect
                            ref
                                .read(bikeConnectionStateProvider.notifier)
                                .toggleBikeConnection(selectedBike);

                            ///Fetch bike details
                            ref
                                .read(bikeReadingsProvider.notifier)
                                .fetchReadings(selectedBike);
                            ref
                                .read(modelInfoProvider.notifier)
                                .fetchModelInfo();
                          } else {
                            /// Disconnect
                            ref
                                .read(bikeConnectionStateProvider.notifier)
                                .toggleBikeConnection(selectedBike);
                          }
                        }
                      : null,
                  child: Text(selectedBike?.isConnected ?? false
                      ? 'Disconnect'
                      : 'Connect'),
                ),
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () =>
                      ref.read(bikeListProvider.notifier).scanBikes(),
                  child: const Text('Scan'),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}

class DiscoveredBikesList extends ConsumerWidget {
  const DiscoveredBikesList({
    super.key,
    required this.bikes,
    required this.selectedBike,
  });

  final List<BikeDevice> bikes;

  final BikeDevice? selectedBike;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textTheme = Theme.of(context).textTheme;

    return ListView.builder(
      itemCount: bikes.length,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        final bike = bikes[index];

        return ListTile(
          selectedColor: const Color.fromARGB(255, 21, 158, 176),
          title: Text(bike.deviceName),
          subtitle: (bike.isConnected)
              ? Text("Connected",
                  style: textTheme.titleSmall!
                      .copyWith(color: const Color.fromARGB(255, 111, 187, 53)))
              : null,
          trailing: Text(bike.connectionType.displayName),
          selected: selectedBike?.deviceId == bike.deviceId,
          onTap: () => ref.read(selectedBikeProvider.notifier).state = bike,
        );
      },
    );
  }
}

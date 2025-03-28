import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../provider/bike_readings_provider.dart';
import '../../provider/selected_bike_provider.dart';

class BikeReadings extends ConsumerWidget {
  final bool expandable;
  const BikeReadings({super.key, required this.expandable});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textTheme = Theme.of(context).textTheme;
    final selectedBike = ref.watch(selectedBikeProvider);
    final bikeReadings = ref.watch(bikeReadingsProvider);

    Widget content = SizedBox.shrink();

    if (selectedBike == null) {
      content = Text('No bike selected.', style: textTheme.bodyLarge);
    } else if (!selectedBike.isConnected) {
      content = Text('Readings are not available.', style: textTheme.bodyLarge);
    } else {
      bikeReadings.when(
        data: (readings) {
          final reading = bikeReadings.value![selectedBike.deviceId];

          if (reading != null) {
            content = Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ReadingItem(label: 'Bike Id', value: reading.bikeId),
                ReadingItem(label: 'Battery', value: reading.batteryCharge),
                ReadingItem(label: 'ODO Meter', value: reading.odoMeter),
                ReadingItem(label: 'Last Error', value: reading.lastError),
                ReadingItem(
                    label: 'Last Theft Alert', value: reading.lastAntiTheft),
                ReadingItem(label: 'Motor RPM', value: reading.motorRPM),
                ReadingItem(
                    label: 'Total Airtime', value: reading.totalAirtime),
                ReadingItem(label: 'Gyroscope', value: reading.gyroscope),
              ],
            );
          } else {
            content =
                Text('Readings are not available.', style: textTheme.bodyLarge);
          }
        },
        error: (e, _) => content =
            Text('Readings are not available.', style: textTheme.bodyLarge),
        loading: () =>
            content = const Center(child: CircularProgressIndicator()),
      );
    }

    return expandable
        ? ExpansionTile(
            title: Text("Bike Readings", style: textTheme.headlineMedium),
            children: [
              Padding(padding: const EdgeInsets.all(16), child: content)
            ],
          )
        : Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Bike Readings", style: textTheme.headlineMedium),
                const SizedBox(height: 16),
                content,
              ],
            ),
          );
  }
}

class ReadingItem extends StatelessWidget {
  final String label;
  final String value;
  const ReadingItem({super.key, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(children: [
        Expanded(child: Text(label, style: textTheme.labelSmall)),
        Text(value, style: textTheme.bodySmall),
      ]),
    );
  }
}

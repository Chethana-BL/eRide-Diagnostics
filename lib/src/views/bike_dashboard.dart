import 'package:flutter/material.dart';

import 'widgets/bike_readings.dart';
import 'widgets/discovered_bikes.dart';
import 'widgets/model_overview.dart';

class BikeDashboard extends StatelessWidget {
  const BikeDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final isMobile = constraints.maxWidth < 600;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Center(
                    child: Text(
                      'Pedal Power Monitor',
                      style: textTheme.headlineLarge,
                    ),
                  ),
                ),
                Divider(thickness: 1),
                Expanded(
                  child: isMobile
                      ? SingleChildScrollView(
                          child: Column(
                            children: [
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.7,
                                child: const DiscoveredBikes(),
                              ),
                              const SizedBox(height: 8),
                              const BikeReadings(expandable: true),
                              const SizedBox(height: 8),
                              const ModelOverview(expandable: true),
                            ],
                          ),
                        )
                      : Row(
                          children: const [
                            Expanded(flex: 2, child: DiscoveredBikes()),
                            VerticalDivider(thickness: 1),
                            Expanded(
                                flex: 3,
                                child: BikeReadings(expandable: false)),
                            VerticalDivider(thickness: 1),
                            Expanded(
                                flex: 3,
                                child: ModelOverview(expandable: false)),
                          ],
                        ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

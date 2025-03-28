import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../provider/model_info_provider.dart';
import '../../provider/selected_bike_provider.dart';

class ModelOverview extends ConsumerWidget {
  final bool expandable;
  const ModelOverview({super.key, required this.expandable});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textTheme = Theme.of(context).textTheme;

    final selectedBike = ref.watch(selectedBikeProvider);
    final modelInfo = ref.watch(modelInfoProvider);

    Widget content = SizedBox.shrink();

    if (selectedBike == null) {
      content = Text(
        'No bike selected.',
        style: textTheme.bodyLarge,
      );
    } else if (!selectedBike.isConnected) {
      content = Text('Model info not available.', style: textTheme.bodyLarge);
    } else {
      modelInfo.when(
        data: (modelData) {
          final model = modelData[selectedBike.model];
          content = model != null
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(selectedBike.model.displayName,
                        style: textTheme.titleLarge),
                    const SizedBox(height: 8),
                    Text(model.description),
                    const SizedBox(height: 12),
                    Image.asset(model.image, fit: BoxFit.contain),
                  ],
                )
              : Text('Model info not available.', style: textTheme.bodyLarge);
        },
        error: (_, __) => content =
            Text('Model info not available.', style: textTheme.bodyLarge),
        loading: () =>
            content = const Center(child: CircularProgressIndicator()),
      );
    }

    return expandable
        ? ExpansionTile(
            title: Text("Model Overview", style: textTheme.headlineMedium),
            children: [
              Padding(padding: const EdgeInsets.all(16), child: content)
            ],
          )
        : Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Model Overview", style: textTheme.headlineMedium),
                const SizedBox(height: 16),
                content,
              ],
            ),
          );
  }
}

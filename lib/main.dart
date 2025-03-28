import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'src/app_builder.dart';

void main() {
  runApp(const ProviderScope(child: AppBuilder()));
}

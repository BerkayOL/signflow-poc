import 'package:flutter/material.dart';

import 'app/app.dart';
import 'app/di/injector.dart';

void main() {
  configureDependencies();
  runApp(const SignMessagingApp());
}

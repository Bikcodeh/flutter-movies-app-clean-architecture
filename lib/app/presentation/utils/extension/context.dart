import 'package:flutter/material.dart';

import '../../../../main.dart';

extension ContextExtension on BuildContext {
  Injector get injector {
    return Injector.of(this);
  }
}

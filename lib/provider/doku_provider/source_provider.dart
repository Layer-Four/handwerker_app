import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';

final projectSourceProvider = StateProvider((ref) => <(String, File)>[]);
final consumableSourceProvider = StateProvider((ref) => <(String, File)>[]);

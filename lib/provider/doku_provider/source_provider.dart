import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

final projectSourceProvider = StateProvider((ref) => <(String, XFile?)>[]);
final consumableSourceProvider = StateProvider((ref) => <(String, XFile?)>[]);

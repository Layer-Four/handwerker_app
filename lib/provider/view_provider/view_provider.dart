import 'package:flutter_riverpod/flutter_riverpod.dart';

final viewProvider = StateProvider<int>((ref) => 1);

enum DokuViews { zeiteintrag, doku, material }

final dokuViewProvider = StateProvider((ref) => DokuViews.zeiteintrag);

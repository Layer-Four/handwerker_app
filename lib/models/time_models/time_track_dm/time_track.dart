import 'package:freezed_annotation/freezed_annotation.dart';
part 'time_track.freezed.dart';
part 'time_track.g.dart';

@freezed
class TimeTrack with _$TimeTrack {
  const factory TimeTrack({
    required String userId,
    required int id,
    required DateTime date,
    String? description,
    int? duration,
    int? projectId,
    int? serviceId,
    String? serviceTitle,
    String? customerName,
  }) = _TimeTrack;
  const TimeTrack._();
  String getDurationInHours() {
    if (duration == null) return '';
    final hours = duration! ~/ 60;
    final minutes = duration! % 60;
    if (minutes < 10) return '$hours:0$minutes';
    return '$hours:$minutes';
  }

  factory TimeTrack.fromJson(Map<String, dynamic> json) => _$TimeTrackFromJson(json);
}

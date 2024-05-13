import 'package:freezed_annotation/freezed_annotation.dart';
part 'time_track.freezed.dart';
part 'time_track.g.dart';

@freezed
class TimeTrack with _$TimeTrack {
  const factory TimeTrack({
    String? userId,
    int? id,
    DateTime? date,
    String? description,
    int? duration,
    int? projectId,
    int? serviceId,
    String? serviceTitle,
    String? customerName,
  }) = _TimeTrack;

  factory TimeTrack.fromJson(Map<String, dynamic> json) => _$TimeTrackFromJson(json);
}

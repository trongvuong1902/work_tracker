import 'models/commute_estimate.dart';

/// Derives a short "Traffic is light/moderate/heavy" phrase by comparing the
/// traffic-aware ETA against the free-flow duration.
String trafficHeadline(CommuteEstimate estimate) {
  final ratio = estimate.durationInTrafficMinutes / estimate.durationMinutes;
  if (ratio >= 1.3) return 'Traffic is heavy';
  if (ratio >= 1.1) return 'Traffic is moderate';
  return 'Traffic is light';
}

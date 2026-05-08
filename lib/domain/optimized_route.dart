import 'stop.dart';

class OptimizedRoute {
  const OptimizedRoute({
    required this.stops,
    required this.totalTime,
    required this.totalDistance,
    required this.numberOfStops,
  });

  final List<Stop> stops;
  final String totalTime;
  final String totalDistance;
  final int numberOfStops;

  factory OptimizedRoute.fromJson(Map<String, dynamic> json) {
    final rawStops = json['stops'];
    if (rawStops is! List) {
      throw const FormatException('Resposta inválida do /optimize.');
    }

    return OptimizedRoute(
      stops: rawStops
          .whereType<Map>()
          .map((stop) => Stop.fromJson(Map<String, dynamic>.from(stop)))
          .where((stop) => stop.address.isNotEmpty)
          .toList(),
      totalTime: (json['totalTime'] as String?) ?? '',
      totalDistance: (json['totalDistance'] as String?) ?? '',
      numberOfStops: (json['numberOfStops'] as num?)?.toInt() ?? 0,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! OptimizedRoute) return false;
    if (stops.length != other.stops.length) return false;
    for (var i = 0; i < stops.length; i++) {
      if (stops[i] != other.stops[i]) return false;
    }
    return totalTime == other.totalTime &&
        totalDistance == other.totalDistance &&
        numberOfStops == other.numberOfStops;
  }

  @override
  int get hashCode => Object.hash(
        Object.hashAll(stops),
        totalTime,
        totalDistance,
        numberOfStops,
      );
}

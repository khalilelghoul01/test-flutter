import 'package:equatable/equatable.dart';
import 'package:test/model/hit_model.dart';

class PixabayResponse extends Equatable {
  final int total;
  final int totalHits;
  final List<Hit> hits;

  const PixabayResponse({
    required this.total,
    required this.totalHits,
    required this.hits,
  });

  @override
  List<Object?> get props => [total, totalHits, hits];

  factory PixabayResponse.fromJson(Map<String, dynamic> json) {
    return PixabayResponse(
      total: json['total'],
      totalHits: json['totalHits'],
      hits: List<Hit>.from(json['hits'].map((x) => Hit.fromJson(x))),
    );
  }
}

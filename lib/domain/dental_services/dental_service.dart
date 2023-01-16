import 'dart:convert';

import 'package:clinic_v2/utils/enums.dart';
import 'package:flutter/foundation.dart';

import '../../domain/dental_services/base_dental_service.dart';

class DentalService extends BaseDentalService {
  DentalService(
    String id,
    String name, {
    required DentalServiceType type,
    List<double> prices = const [],
  }) : super(
          id,
          name,
          type: type,
          prices: prices,
        );

  factory DentalService.fromJson(Map<String, dynamic> json) {
    return DentalService(
      json['id'],
      json['name'],
      prices: (jsonDecode(json['prices']) as List)
          .map((e) => double.parse(e.toString()))
          .toList(),
      type: DentalServiceType.values.byName(json['type']),
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'type': type.name,
      'prices': jsonEncode(prices),
    };
  }

  @override
  String toString() {
    return 'DentalService(id: $id, name: $name, type: $type, prices: $prices)';
  }

  DentalService copyWith({
    String? id,
    String? name,
    DentalServiceType? type,
    List<double>? prices,
  }) {
    return DentalService(
      id ?? this.id,
      name ?? this.name,
      type: type ?? this.type,
      prices: prices ?? this.prices,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is DentalService &&
        other.id == id &&
        other.name == name &&
        other.type == type &&
        listEquals(other.prices, prices);
  }

  @override
  int get hashCode {
    return id.hashCode ^ name.hashCode ^ type.hashCode ^ prices.hashCode;
  }
}

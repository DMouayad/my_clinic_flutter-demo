import 'package:clinic_v2/utils/enums.dart';

abstract class BaseDentalService {
  String id;
  String name;
  DentalServiceType type;
  List<double> prices;

  BaseDentalService(
    this.id,
    this.name, {
    required this.type,
    this.prices = const [],
  });
  Map<String, dynamic> toJson();
}

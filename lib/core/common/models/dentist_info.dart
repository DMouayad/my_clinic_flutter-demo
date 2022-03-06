import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

class DentistInfo extends ParseObject implements ParseCloneable {
  DentistInfo() : super('Dentist_Info');

  @override
  DentistInfo clone(Map<String, dynamic> map) => DentistInfo.fromJson(map);
  static const String keyEmailAddress = 'email_address';
  String? get emailAddress => get<String>(keyEmailAddress);
  set emailAddress(String? value) => set<String?>(keyEmailAddress, value);

  factory DentistInfo.fromJson(Map<String, dynamic> objectData) {
    return DentistInfo()..set(keyEmailAddress, objectData['email_address']);
  }
}

import 'package:clinic_v2/common/features/users/data/dentist_data.dart';
import 'package:flutter_test/flutter_test.dart';
import '../../../../../helpers/parse_tests_helpers.dart';
import '../../../../../test_data/parse_dentist_json_data.dart';

Future<void> main() async {
  setUp(() async => await initializeParseForTest());
  group('ParseDentist json encoding and decoding tests', () {
    test('should return a ParseDentist instance from a json map', () async {
      final result = ParseDentist.fromJson(parseDentistTestJson);
      expect(result, tDentistInstance);
    });
    test('should return a json map from a ParseDentist', () async {
      final result = tDentistInstance.toJson();
      expect(result, parseDentistTestJson);
    });
  });
}

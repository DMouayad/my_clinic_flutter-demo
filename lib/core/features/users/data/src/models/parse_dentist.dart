part of dentist_data;

class ParseDentist extends ParseObject
    with EquatableMixin
    implements ParseCloneable, BaseDentist {
  ParseDentist({
    required this.dentalServices,
    required this.medicationsList,
    required this.selectedLocale,
    required this.selectedThemeMode,
    required this.isLoggedIn,
    required this.userCalendar,
  }) : super('Dentist');

  factory ParseDentist.fromJson(Map<String, dynamic> json) {
    // assert json contains [ObjectId] since it's essential for storing and
    // updating [ParseDentist] objects in both remote and local databases.
    assert(json.containsKey(keyVarObjectId));

    final decodedParseDentist = ParseDentist(
      dentalServices: (jsonDecode(json['dental_services']) as List)
          .map((e) => DentalService.fromJson(e))
          .toList(),
      medicationsList: (jsonDecode(json['medications_list']) as List)
          .map((e) => e.toString())
          .toList(),
      isLoggedIn: json['is_logged_in'],
      selectedLocale:
          Locale.fromSubtags(languageCode: json['selected_locale'] ?? 'en'),
      selectedThemeMode:
          ThemeMode.values.elementAt(json['selected_theme'] ?? 0),
      userCalendar: DentistCalendar.fromJson(json['user_calendar']),
    );
    decodedParseDentist.objectId = json[keyVarObjectId];
    //
    if (json.containsKey(keyVarCreatedAt)) {
      decodedParseDentist.set(keyVarCreatedAt, json[keyVarObjectId]);
    }
    return decodedParseDentist;
  }

  @override
  List<BaseDentalService> dentalServices;

  @override
  bool isLoggedIn;

  @override
  List<String> medicationsList;

  @override
  Locale? selectedLocale;

  @override
  ThemeMode? selectedThemeMode;

  @override
  DentistCalendar userCalendar;

  @override
  ParseDentist clone(Map<String, dynamic> map) {
    return ParseDentist.fromJson(map);
  }

  @override

  /// same as [ParseObject.objectId]
  String get id => objectId!;

  @override
  List<Object?> get props {
    return [
      id,
      selectedLocale,
      selectedThemeMode,
      isLoggedIn,
      medicationsList,
      dentalServices,
      role,
      userCalendar,
    ];
  }

  @override
  UserRole get role => UserRole.dentist;

  @override
  Map<String, dynamic> toJson(
      {bool full = false,
      bool forApiRQ = false,
      bool allowCustomObjectId = false}) {
    final parseUserJson = super.toJson(
      full: full,
      forApiRQ: forApiRQ,
      allowCustomObjectId: allowCustomObjectId,
    );

    parseUserJson.addAll({
      'is_logged_in': isLoggedIn,
      'selected_locale': selectedLocale?.languageCode,
      'selected_theme': selectedThemeMode?.index,
      'dental_services':
          jsonEncode(dentalServices.map((e) => e.toJson()).toList()),
      'medications_list': jsonEncode(medicationsList),
      'user_calendar': userCalendar.toJson(),
    });
    return parseUserJson;
  }
}

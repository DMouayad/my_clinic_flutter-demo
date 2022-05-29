import 'package:clinic_v2/app/base/responsive/responsive.dart';
import 'package:clinic_v2/app/common/utils/constants.dart';
import 'package:clinic_v2/app/common/widgets//section_card.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/calendar_settings_bloc.dart';

class ClinicHolidaysCard extends StatelessWidget {
  const ClinicHolidaysCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SectionCard(
      title: 'Clinic holidays',
      titleFontSize: 18,
      children: [
        BlocBuilder<CalendarSettingsBloc, CalendarSettingsState>(
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Wrap(
                runSpacing: 14,
                runAlignment: WrapAlignment.spaceEvenly,
                spacing: 10,
                children: kDaysOfWeek.entries.map(
                  (entry) {
                    final selected = state.holidays.contains(entry.value);

                    return ConstrainedBox(
                      constraints: BoxConstraints.loose(Size(150, 70)),
                      child: RawChip(
                        checkmarkColor: context.colorScheme.onPrimary,
                        labelStyle: context.textTheme.bodyLarge?.copyWith(
                          color: selected
                              ? context.colorScheme.onPrimary
                              : context.colorScheme.onPrimaryContainer,
                          fontWeight: FontWeight.w600,
                        ),
                        backgroundColor: context.colorScheme.primaryContainer,
                        selectedColor: context.colorScheme.primary,
                        selected: selected,
                        label: Text(entry.key),
                        onSelected: (checked) {
                          // we have to use [List.from] to create a new variable
                          // in memory so [Bloc] would see [holidayList] as a new
                          // list and update the state accordingly.
                          final holidayList = List<int>.from(state.holidays);
                          if (checked) {
                            holidayList.add(entry.value);
                          } else {
                            holidayList.removeWhere(
                                (element) => element == entry.value);
                          }

                          context.read<CalendarSettingsBloc>().add(
                                CalendarSettingsEvent.holidaysChanged(
                                  newHolidaysList: holidayList,
                                ),
                              );
                        },
                      ),
                    );
                  },
                ).toList(),
              ),
            );
          },
        ),
      ],
    );
  }
}

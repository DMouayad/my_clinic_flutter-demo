library dentist_data;

import 'dart:convert';
//
import 'package:clinic_v2/common/common/entities/dentist_calendar.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
//
import 'package:equatable/equatable.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
//
import 'package:clinic_v2/common/common/utilities/enums.dart';
import 'package:clinic_v2/common/features/users/domain/dentist_contracts.dart';
import 'package:clinic_v2/common/common/entities/custom_response.dart';

part '../data/src/models/dental_service.dart';
part 'src/data_sources/dentist_parse_ds.dart';
part 'src/repositories/dentist_repository.dart';
part 'src/models/parse_dentist.dart';

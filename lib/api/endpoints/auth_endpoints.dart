library api_auth_endpoints;

import 'package:clinic_v2/api/endpoints_results/src/auth_endpoints_results.dart';

import 'package:clinic_v2/api/models/api_endpoint.dart';

import 'src/base_api_endpoint_with_empty_result.dart';

part 'src/auth/logout_endpoint.dart';
part 'src/auth/login_endpoint.dart';
part 'src/auth/refresh_access_token_endpoint.dart';
part 'src/auth/register_endpoint.dart';
part 'src/auth/request_email_verification_endpoint.dart';

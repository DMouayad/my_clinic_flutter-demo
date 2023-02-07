part of '../../../app/blocs/email_verification_cubit/email_verification_cubit.dart';

abstract class EmailVerificationState extends Equatable {
  const EmailVerificationState();
  @override
  List<Object> get props => [];
}

class EmailVerificationInitial extends EmailVerificationState {
  const EmailVerificationInitial();
}

class VerificationEmailWasSent extends EmailVerificationState {
  const VerificationEmailWasSent();
}

class RequestingVerificationEmail extends EmailVerificationState {
  const RequestingVerificationEmail();
}

class VerificationEmailRequestFailed extends EmailVerificationState {
  final AppError error;
  const VerificationEmailRequestFailed(this.error);
  @override
  List<Object> get props => [error];
}

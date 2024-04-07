abstract class LoginEvent {}

class NumberNotValidEvent extends LoginEvent {}

class GetOtpClickedEvent extends LoginEvent {
  final bool isGetOtpPage;

  GetOtpClickedEvent({required this.isGetOtpPage});
}

class GetOtpFailedEvent extends LoginEvent {}

class GetOtpSentEvent extends LoginEvent {}

class OtpTimerRunningEvent extends LoginEvent {
  final int timer;
  final bool isResend;

  OtpTimerRunningEvent({
    required this.timer,
    required this.isResend,
  });
}

class ResendOtpSentEvent extends LoginEvent {}

class OtpTimerFinishedEvent extends LoginEvent {}

class ResendOtpClickedEvent extends LoginEvent {}

class WrongOtpClickedEvent extends LoginEvent {}

class SubmitOtpClickedEvent extends LoginEvent {}

class SubmitOtpClickedSuccessEvent extends LoginEvent {}

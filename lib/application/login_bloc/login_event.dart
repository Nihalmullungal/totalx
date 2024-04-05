abstract class LoginEvent {}

class NumberNotValidEvent extends LoginEvent {}

class GetOtpClickedEvent extends LoginEvent {}

class GetOtpSentEvent extends LoginEvent {}

class OtpTimerRunningEvent extends LoginEvent {}

class OtpTimerFinishedEvent extends LoginEvent {}

class ResendOtpClickedEvent extends LoginEvent {}

class SubmitOtpClickedEvent extends LoginEvent {}

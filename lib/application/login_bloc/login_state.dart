abstract class LoginState {}

class InitialLoginState extends LoginState {}

class NumberNotValidState extends LoginState {}

class GetOtpClickedState extends LoginState {}

class GetOtpSentState extends LoginState {}

class GetOtpfailedState extends LoginState {}

class OtpRunningState extends LoginState {}

class OtpTimerFinishedState extends LoginState {}

class LoginLoadingState extends LoginState {}

class ResendOtpClickedState extends LoginState {}

class ResendOtpSentState extends LoginState {}

class WrongOtpClickedState extends LoginState {}

class SubmitOtpClickedState extends LoginState {}

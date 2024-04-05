abstract class LoginState {}

class InitialLoginState extends LoginState {}

class GetOtpClickedState extends LoginState {}

class OtpRunningState extends LoginState {}

class OtpTimerFinishedState extends LoginState {}

class LoginLoadingState extends LoginState {}

class ResendOtpClickedState extends LoginState {}

class SubmitOtpClickedState extends LoginState {}

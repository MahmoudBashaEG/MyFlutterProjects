abstract class EnterStates {}

class EnterInitialState extends EnterStates {}

class LogInShowPasswordState extends EnterStates {}

class LogInEmailLoadingState extends EnterStates {}

class LogInEmailSuccessState extends EnterStates {
  final message;
  LogInEmailSuccessState({this.message});
}

class LogInEmailErrorState extends EnterStates {
  final error;
  LogInEmailErrorState({this.error});
}

class LogInGoogleLoadingState extends EnterStates {}

class LogInGoogleSuccessState extends EnterStates {}

class LogInGoogleErrorState extends EnterStates {
  final error;
  LogInGoogleErrorState({this.error});
}

class SignUpEmailLoadingState extends EnterStates {}

class SignUpEmailSuccessState extends EnterStates {}

class SignUpEmailErrorState extends EnterStates {}

class SignUpPhoneLoadingState extends EnterStates {}

class SignUpPhoneSuccessState extends EnterStates {}

class SignUpPhoneErrorState extends EnterStates {}

class CreateUserLoadingState extends EnterStates {}

class CreateUserSuccessState extends EnterStates {
  final message;
  CreateUserSuccessState({this.message});
}

class CreateUserErrorState extends EnterStates {
  final error;
  CreateUserErrorState({this.error});
}

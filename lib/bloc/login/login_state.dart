import 'package:equatable/equatable.dart';

enum LoginStatus { initial, loading, success, failure }

class LoginState extends Equatable {
  const LoginState({
    this.status = LoginStatus.initial,
    this.errorMessage = '',
  });

  final LoginStatus status;
  final String errorMessage;

  LoginState copyWith({
    LoginStatus? status,
    String? errorMessage,
  }) {
    return LoginState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object> get props => [status, errorMessage];

  @override
  String toString() {
    return 'LoginState { status: $status, errorMessage: $errorMessage }';
  }
}

class LoginInitial extends LoginState {
  const LoginInitial() : super(status: LoginStatus.initial);
}

class SendOtpLoading extends LoginState {
  const SendOtpLoading() : super(status: LoginStatus.loading);
}

class SendOtpSuccess extends LoginState {
  const SendOtpSuccess() : super(status: LoginStatus.success);
}

class SendOtpFailure extends LoginState {
  const SendOtpFailure(String errorMessage)
      : super(status: LoginStatus.failure, errorMessage: errorMessage);
}

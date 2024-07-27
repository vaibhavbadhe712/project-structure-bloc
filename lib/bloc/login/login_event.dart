import 'package:equatable/equatable.dart';

abstract class LoginEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class PostFetched extends LoginEvent {}

class SendOtpEvent extends LoginEvent {
  final String phoneNumber;

  SendOtpEvent(this.phoneNumber);

  @override
  List<Object> get props => [phoneNumber];
}

class SendOtpToUser extends LoginEvent{}



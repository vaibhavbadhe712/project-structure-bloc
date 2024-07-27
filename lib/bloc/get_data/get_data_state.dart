import 'package:equatable/equatable.dart';
import 'package:startup_project/model/get_data_model/get_data_model.dart';

abstract class GetDataState extends Equatable {
  @override
  List<Object> get props => [];
}

class GetDataInitial extends GetDataState {}

class GetDataLoading extends GetDataState {}

class GetDataLoaded extends GetDataState {
  final List<Comment> comments;

  GetDataLoaded(this.comments);

  @override
  List<Object> get props => [comments];
}

class GetDataError extends GetDataState {
  final String message;

  GetDataError(this.message);

  @override
  List<Object> get props => [message];
}

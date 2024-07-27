import 'package:equatable/equatable.dart';

abstract class GetDataEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class FetchData extends GetDataEvent {}

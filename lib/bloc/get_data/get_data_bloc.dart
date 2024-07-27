import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:startup_project/bloc/get_data/get_data_event.dart';
import 'package:startup_project/bloc/get_data/get_data_state.dart';
import 'package:startup_project/model/get_data_model/get_data_model.dart';
import 'package:startup_project/utils/api/api_base.dart';

class GetDataBloc extends Bloc<GetDataEvent, GetDataState> {
  final ApiBase _apiBase = ApiBase();

  GetDataBloc() : super(GetDataInitial()) {
    on<FetchData>(_getAllData);
  }

  Future<void> _getAllData(
      FetchData event, Emitter<GetDataState> emit) async {
    emit(GetDataLoading());
    try {
      await _apiBase.get(
        "https://jsonplaceholder.typicode.com/comments?postId=1",
        (data) {
          final List<Comment> comments = commentFromJson(json.encode(data));
          emit(GetDataLoaded(comments));
        },
        (error) {
          emit(GetDataError(error.toString()));
        },
      );
    } catch (error) {
      emit(GetDataError(error.toString()));
    }
  }
}

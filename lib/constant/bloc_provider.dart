import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/single_child_widget.dart';
import 'package:startup_project/bloc/get_data/get_data_bloc.dart';
import 'package:startup_project/bloc/login/login_bloc.dart';
import 'package:startup_project/repo/login_repo.dart';



List<SingleChildWidget> blocProvider = [
  BlocProvider(create: (context) => LoginBloc(PostRepository())),
    BlocProvider(create: (context) => GetDataBloc()),
];
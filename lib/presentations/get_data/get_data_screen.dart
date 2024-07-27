import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:startup_project/bloc/get_data/get_data_bloc.dart';
import 'package:startup_project/bloc/get_data/get_data_event.dart';
import 'package:startup_project/bloc/get_data/get_data_state.dart';
import 'package:startup_project/widgets/text_widget.dart';

class GetDataScreen extends StatefulWidget {
  const GetDataScreen({super.key});

  @override
  State<GetDataScreen> createState() => _GetDataScreenState();
}

class _GetDataScreenState extends State<GetDataScreen> {



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => GetDataBloc()..add(FetchData()),
        child: Column(
          children: [
            _headerWidget(context),
            SizedBox(height: 20),
            _getAllDataWidget(),
          ],
        ),
      ),
    );
  }

  Widget _headerWidget(BuildContext context) {
    return Row(
      children: [TextWidget(context: context, text: "Show Data On UI")],
    );
  }

  Widget _getAllDataWidget() {
    return BlocBuilder<GetDataBloc, GetDataState>(
      builder: (context, state) {
        if (state is GetDataLoading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is GetDataError) {
          return Center(child: TextWidget(context: context, text: state.message));
        } else if (state is GetDataLoaded) {
          return Expanded(
            child: ListView.builder(
              itemCount: state.comments.length,
              itemBuilder: (BuildContext context, int index) {
                final comment = state.comments[index];
                return Padding(
                  padding: EdgeInsets.all(5),
                  child: ListTile(
                    leading: TextWidget(
                      context: context,
                      text: index.toString(),
                      fontSize: 16,
                    ),
                    title: TextWidget(
                      context: context,
                      text: comment.name ?? '',
                      fontSize: 18,
                    ),
                    subtitle: TextWidget(
                      context: context,
                      text: comment.body ?? '',
                      fontSize: 14,
                    ),
                  ),
                );
              },
            ),
          );
        }
        return Center(child: TextWidget(context: context, text: 'No data found'));
      },
    );
  }
}

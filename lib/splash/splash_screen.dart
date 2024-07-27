import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:startup_project/bloc/login/login_bloc.dart';
import 'package:startup_project/bloc/login/login_event.dart';
import 'package:startup_project/bloc/login/login_state.dart';
import 'package:startup_project/presentations/get_data/get_data_screen.dart';
import 'package:startup_project/repo/login_repo.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController _phoneNumberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: BlocProvider(
        create: (context) => LoginBloc(PostRepository()),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: BlocConsumer<LoginBloc, LoginState>(
            listener: (context, state) {
              if (state is SendOtpSuccess) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('OTP sent successfully')),
                );
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => GetDataScreen()));
              } else if (state is SendOtpFailure) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Error: ${state.errorMessage}')),
                );
              }
            },
            builder: (context, state) {
              if (state is SendOtpLoading) {
                return Center(child: CircularProgressIndicator());
              } else if (state is SendOtpSuccess) {
                return Center(child: Text('OTP sent successfully!'));
              } else if (state is SendOtpFailure) {
                return Center(
                    child: Text('Failed to send OTP: ${state.errorMessage}'));
              } else if (state is LoginInitial) {
                return Column(
                  children: [
                    TextField(
                      controller: _phoneNumberController,
                      decoration: InputDecoration(labelText: 'Phone Number'),
                      keyboardType: TextInputType.phone,
                    ),
                    SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        final phoneNumber = _phoneNumberController.text.trim();
                        if (phoneNumber.isNotEmpty) {
                          context
                              .read<LoginBloc>()
                              .add(SendOtpEvent(phoneNumber));
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                                content: Text('Please enter a phone number')),
                          );
                        }
                      },
                      child: Text('Send OTP'),
                    ),
                  ],
                );
              }
              return Container();
            },
          ),
        ),
      ),
    );
  }
}

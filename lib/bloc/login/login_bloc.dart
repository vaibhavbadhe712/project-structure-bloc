
import 'package:bloc/bloc.dart';
import 'package:startup_project/main.dart';
import 'package:startup_project/repo/login_repo.dart';
import 'package:startup_project/utils/api/api_base.dart';
import 'login_event.dart';
import 'login_state.dart';

// class LoginBloc extends Bloc<LoginEvent, LoginState> {
//   final PostRepository postRepository;

//   LoginBloc(this.postRepository) : super(const LoginState()) {
//     on<SendOtpEvent>(sendOtp);
//   }

//   Future<void> sendOtp(SendOtpEvent event, Emitter<LoginState> emit) async {
//     emit(const SendOtpLoading());
//     try {
//       await postRepository.sendOtp(event.phoneNumber);
//       emit(const SendOtpSuccess());
//     } catch (error) {
//       emit(SendOtpFailure(error.toString()));
//     }
//   }
// }

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final PostRepository postRepository;
  final ApiBase _apiBase = ApiBase();

  LoginBloc(this.postRepository) : super(const LoginInitial()) {
    on<SendOtpEvent>(sendOtp);
  }

  Future<void> sendOtp(SendOtpEvent event, Emitter<LoginState> emit) async {
    emit(const SendOtpLoading());
    try {
      var payload = {
        "phoneNumber": event.phoneNumber.toString(),
        "groupId": 1703228300417
      };
      await _apiBase.post(
        apiEndPoints.sendOTP,
        payload,
        (data) {
          emit(SendOtpSuccess());
        },
        (error) {
          emit(SendOtpFailure(error.toString()));
        },
      );
    } catch (error) {
      emit(SendOtpFailure(error.toString()));
    }
  }
}

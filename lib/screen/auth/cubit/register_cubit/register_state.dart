import '../../data/model/user_model.dart';

abstract class RegisterState {}

class RegisterInitialState extends RegisterState {}
class RegisterPasswordChangedVisibilityState extends RegisterState {}

class RegisterLoadingState extends RegisterState {}

class RegisterSuccessState extends RegisterState {
  final UserModel user;
  RegisterSuccessState(this.user);
}
class RegisterErrorState extends RegisterState {
  final String error;
  RegisterErrorState(this.error);
}
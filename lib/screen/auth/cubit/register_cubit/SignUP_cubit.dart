import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/model/user_model.dart';
import '../../data/repo/auth_repo.dart';
import 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState>{
  RegisterCubit() : super(RegisterInitialState());
  static RegisterCubit get(context) => BlocProvider.of(context);

  var email = TextEditingController();
  var password = TextEditingController();
  var confirmPassword = TextEditingController();
  var fullName = TextEditingController();
  var mobileNumber = TextEditingController();
  var formKey = GlobalKey<FormState>();

  void onRegisterPressed()async
  {
    if(formKey.currentState?.validate() == true){
      emit(RegisterLoadingState());
      AuthRepo repo = AuthRepo();
      var result= await repo.register(
        email: email.text,
        password: password.text, name: fullName.text, phone: mobileNumber.text

      );
      result.fold((String error)=> emit(RegisterErrorState(error)),
       (UserModel user)=> emit(RegisterSuccessState(user))
        );
    }
  }

  bool passwordSecure = true;
  void changePasswordSecure(){
    passwordSecure = !passwordSecure;
    emit(RegisterPasswordChangedVisibilityState());
  }

  bool confirmPasswordSecure = true;
  void changeConfirmPasswordSecure(){
    confirmPasswordSecure = !confirmPasswordSecure;
    emit(RegisterPasswordChangedVisibilityState());
  }
}
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fod_app/screen/Checkout/data/models/checkout_model.dart';
import '../../data/repo/checkout_repo.dart';
import '../CheckoutState/checkout_state.dart';

class CheckoutCubit extends Cubit<CheckoutState> {
  CheckoutCubit() : super(CheckoutInitialState());
  static CheckoutCubit get(context) => BlocProvider.of(context);

  List<ActiveModel> item = [];
  final CartRepo itemRepo = CartRepo();


  void fetchProducts() async {
    emit(CheckoutLoadingState());
    var response = await itemRepo.checkout();
    response.fold(
      (error) {
        emit(CheckoutErrorState(error: error));
      },
      (List<ActiveModel> data) {
        item = data;
        emit(CheckoutSuccessState());
      },
    );
  }
}

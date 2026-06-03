abstract class CheckoutState {}

class CheckoutInitialState extends CheckoutState{}
class CheckoutLoadingState extends CheckoutState{}
class CheckoutSuccessState extends CheckoutState{}

class CheckoutErrorState extends CheckoutState{
  String error;
  CheckoutErrorState({required this.error});
}
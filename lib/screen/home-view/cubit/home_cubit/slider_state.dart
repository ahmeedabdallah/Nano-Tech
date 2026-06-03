class SliderCubitState {}
class InitialSliderCubitState extends SliderCubitState{}
class LoadingSlider extends SliderCubitState {}
class LoadedSlider extends SliderCubitState{}
class ErrorSlider extends SliderCubitState{
  String msg;
  ErrorSlider({required this.msg});
}
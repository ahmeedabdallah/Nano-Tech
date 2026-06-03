import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fod_app/screen/home-view/cubit/home_cubit/slider_state.dart';
import '../../data/models/slider_model.dart';
import '../../data/repo/home_repo.dart';

class SliderCubit extends Cubit<SliderCubitState>{
  SliderCubit() : super(InitialSliderCubitState());
  static SliderCubit get(context) => BlocProvider.of(context);
  List<Sliders> sliders =[];
  final HomeRepo homeRepo = HomeRepo();


  void fetchSliders() async {
    emit(LoadingSlider());
    var response = await homeRepo.getSlider();
    response.fold(
          (error) {
        emit(ErrorSlider(msg: error));
      },
          (List<Sliders> data) {
        sliders = data;
        emit(LoadedSlider());
      },
    );
  }
}
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fod_app/screen/home-view/data/repo/home_repo.dart';
import '../../data/models/best_seller_model.dart';
import '../../data/models/product_model.dart';
import 'home_cubit_state.dart';

class HomeCubit extends Cubit<HomeCubitState> {
  HomeCubit() : super(InitialHomeCubitState());
  static HomeCubit get(context) => BlocProvider.of(context);
  int navIndex = 0;
  int currentIndex = 0;
  List<BestSellerProducts> bestSellerList = [];
  List<Products> products = [];
  final HomeRepo homeRepo = HomeRepo();

  void changeIndexSlider(int newIndex) {
    currentIndex = newIndex;
    emit(SliderUpChangeState());
  }

  void fetchBestSeller() async {
    emit(LoadingHome());
    var response = await homeRepo.getBestSeller();
    response.fold(
      (error) {
        emit(ErrorHome(msg: error));
      },
      (List<BestSellerProducts> data) {
        bestSellerList = data;
        emit(LoadedHome());
      },
    );
  }

  void fetchProducts() async {
    //ToDo have same State
    emit(LoadingHome());
    var response = await homeRepo.getProducts();
    response.fold(
      (error) {
        emit(ErrorHome(msg: error));
      },
      (List<Products> data) {
        products = data;
        emit(LoadedHome());
      },
    );
  }

  void changePageNav(int newNavIndex) {
    navIndex = newNavIndex;
    emit(BottomNavigationCubit(index: newNavIndex));
  }

  int countIndex = 0;
  void increaseIndex() {
    countIndex++;
    emit(CountIndex());
  }
}

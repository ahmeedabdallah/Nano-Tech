class HomeCubitState {}
class InitialHomeCubitState extends HomeCubitState{}
class SliderUpChangeState extends HomeCubitState{}
class LoadingHome extends HomeCubitState {}
class LoadedHome extends HomeCubitState{}
class ErrorHome extends HomeCubitState{
  String msg;
  ErrorHome({required this.msg});
}
class BottomNavigationCubit extends HomeCubitState{
  final int index;
  BottomNavigationCubit({required this.index});
}
class CountIndex extends HomeCubitState{}


//class LoadingRecommendedHome extends HomeCubitState {}
//class LoadedRecommendedHome extends HomeCubitState{}
/*class RecommendedErrorState extends HomeCubitState {
  final String msg;
  RecommendedErrorState({required this.msg});
}*/



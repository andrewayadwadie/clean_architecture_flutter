import 'dart:async';

import '../../../domain/models.dart';

import '../../base/baseviewmodel.dart';
import '../../resources/assets_manager.dart';
import '../../resources/strings_manager.dart';

class OnboardingViewModel extends BaseViewModel
    with OnBoardingViewModelInput, OnBoardingViewModelOutput {
  //! Stream Controller Outputs

  final StreamController _streamController =
      StreamController<SliderViewObject>();

  late final List<SliderObject> _list;
  int _currentIndex = 0;

  @override
  void dispose() {
    _streamController.close();
  }

  @override
  void start() {
    //* ViewModel Start Your Job
    _list = _getSliderData();
    _postDataToView();
  }

  @override
  int goNext() {
    int nextIndex = ++_currentIndex;
    if (nextIndex == _list.length) {
      nextIndex = 0;
    }
    return nextIndex;
  }

  @override
  int goPrevious() {
    int previousIndex = --_currentIndex;
    if (previousIndex == -1) {
      previousIndex = _list.length - 1;
    }
    return previousIndex;
  }

  @override
  void onPageChanged(int index) {
    _currentIndex = index;
    _postDataToView();
  }

  //! OnBoarding View Model Input
  @override
  Sink get inputSliderViewObject => _streamController.sink;

  //! OnBoarding View Model Output
  @override
  Stream<SliderViewObject> get outputSliderViewObject =>
      _streamController.stream.map((sliderViewObject) => sliderViewObject);

  //! OnBoarding Private Functions
  void _postDataToView() {
    inputSliderViewObject.add(
        SliderViewObject(_list[_currentIndex], _list.length, _currentIndex));
  }

  List<SliderObject> _getSliderData() => [
        SliderObject(AppStrings.onBoardingTitle1,
            AppStrings.onBoardingSubTitle1, ImageAssets.onboardingLogo1),
        SliderObject(AppStrings.onBoardingTitle2,
            AppStrings.onBoardingSubTitle2, ImageAssets.onboardingLogo2),
        SliderObject(AppStrings.onBoardingTitle3,
            AppStrings.onBoardingSubTitle3, ImageAssets.onboardingLogo3),
        SliderObject(AppStrings.onBoardingTitle4,
            AppStrings.onBoardingSubTitle4, ImageAssets.onboardingLogo4),
      ];
}

//! inputs mean that "orders " that our view model receive from view
abstract class OnBoardingViewModelInput {
  int goNext(); //! when user click on right or swipe left
  int goPrevious(); //! when user click on left or swipe right
  void onPageChanged(int index); //! when page current index will change

  //! Stream Controller Input
  Sink get inputSliderViewObject;
}

abstract class OnBoardingViewModelOutput {
  //! Stream Controller Output
  Stream<SliderViewObject> get outputSliderViewObject;
}

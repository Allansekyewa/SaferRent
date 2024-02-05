import 'package:saferent/views/components/animations/lottie_animations_view.dart';
import 'package:saferent/views/components/animations/models/lottie.dart';


class LoadingAnimation extends LottieAnimatioView {
  const LoadingAnimation({super.key})
      : super(animation: LottieAnimation.loading);
}

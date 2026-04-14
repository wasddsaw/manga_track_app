part of 'shared.dart';

class LoadingIndicator extends StatelessWidget {
  final Color color;

  const LoadingIndicator({
    super.key,
    this.color = AppColors.primary,
  });

  @override
  Widget build(BuildContext context) {
    return SpinKitThreeBounce(
      color: color,
      size: 18.0,
    );
  }
}

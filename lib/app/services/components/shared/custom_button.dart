part of 'shared.dart';

class CustomButton extends StatelessWidget {
  final String label;
  final bool isDisabled;
  final bool isLoading;
  final bool isIcon;
  final bool isRight;
  final void Function() onPressed;
  final Color buttonColor;
  final Color labelColor;
  final double labelSize;
  final double height;
  final EdgeInsets? padding;
  final Color? borderColor;
  final double borderRadius;
  final double elevation;

  const CustomButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.isDisabled = false,
    this.isLoading = false,
    this.isIcon = false,
    this.isRight = false,
    this.buttonColor = Colors.blue,
    this.labelColor = Colors.white,
    this.labelSize = 16,
    this.height = 50,
    this.padding,
    this.borderColor,
    this.borderRadius = 8,
    this.elevation = 0,
  });

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: isDisabled ? 0.6 : 1,
      child: ElevatedButton(
        style: ButtonStyle(
          // overlayColor: WidgetStateProperty.resolveWith(
          //   (states) {
          //     return states.contains(WidgetState.pressed) ? AppColors.hover : null;
          //   },
          // ),
          elevation: WidgetStateProperty.all(elevation),
          padding: WidgetStateProperty.all(padding),
          backgroundColor: WidgetStateProperty.resolveWith<Color>(
            (Set<WidgetState> states) {
              if (states.contains(WidgetState.disabled)) {
                return buttonColor.withValues(alpha: 0.2);
              }
              return buttonColor;
            },
          ),
          shape: WidgetStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius),
              side: BorderSide(color: borderColor ?? Colors.transparent),
            ),
          ),
        ),
        onPressed: isDisabled
            ? null
            : isLoading
                ? null
                : onPressed,
        child: SizedBox(
          width: double.infinity,
          height: height,
          child: Center(
            child: isLoading
                ? const LoadingIndicator(color: Colors.white)
                : Text(
                    label,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: labelColor,
                      fontSize: labelSize,
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}

part of 'shared.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  final Size preferredSize = const Size.fromHeight(kToolbarHeight);

  final String title;
  final double titleTextSize;
  final double elevation;
  final Widget? leading;
  final List<Widget>? trailing;
  final PreferredSizeWidget? bottom;
  final Color? color;
  final bool centerTitle;
  final Color? titleColor;
  final Widget? titleWidget;
  final Widget? flexibleSpace;

  const CustomAppBar(
    this.title, {
    super.key,
    this.titleTextSize = 1,
    this.leading,
    this.trailing,
    this.elevation = 0.0,
    this.bottom,
    this.color = AppColors.background,
    this.centerTitle = true,
    this.titleColor = AppColors.primary,
    this.titleWidget,
    this.flexibleSpace,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: title != ''
          ? Text(
              title,
              style: GoogleFonts.plusJakartaSans(
                fontSize: gFontSize * titleTextSize,
                fontWeight: FontWeight.w800,
                fontStyle: FontStyle.italic,
                color: titleColor,
              ),
            )
          : titleWidget,
      elevation: elevation,
      flexibleSpace: flexibleSpace,
      centerTitle: centerTitle,
      backgroundColor: color,
      foregroundColor: AppColors.textSecondary,
      leading: leading,
      actions: trailing,
      bottom: bottom,
    );
  }
}

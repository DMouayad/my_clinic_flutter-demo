part of components;

class _AppNameText extends Component {
  @override
  Widget mobile(context) {
    return Text(
      'CLINIC',
      style: context.textTheme.headline6?.copyWith(
        letterSpacing: 1.3,
        fontWeight: FontWeight.w500,
        color: AppColorScheme.onBackground(context),
      ),
    );
  }
}

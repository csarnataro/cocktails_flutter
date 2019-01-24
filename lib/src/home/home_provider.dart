import 'package:flutter/widgets.dart';
import './home_bloc.dart';

/// Provider for the BLoC.
/// See https://github.com/filiph/state_experiments/blob/master/shared/lib/src/bloc/cart_provider.dart
class HomeProvider extends InheritedWidget {
  final HomeBloc homeBloc;

  HomeProvider({
    Key key,
    HomeBloc bloc,
    Widget child,
  })  : homeBloc = bloc ?? HomeBloc(),
        super(key: key, child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;

  static HomeBloc of(BuildContext context) {
      return (context.inheritFromWidgetOfExactType(HomeProvider) as HomeProvider)
          .homeBloc;
  }
}
part of 'tab_cubit.dart';

abstract class TabState extends Equatable {
  const TabState();

  @override
  List<Object> get props => [];
}

/// initial tab when application lands
class TabInitial extends TabState {
  const TabInitial();
}

class TabLoading extends TabState {}

class TabSuccess extends TabState {
  /// reading all the successful gtm tab from as list
  final List<GtmTab> gtmTabList;
  const TabSuccess(this.gtmTabList);
  @override
  List<Object> get props => [gtmTabList];
}

class TabFailure extends TabState {
  final String failureMessage;

  const TabFailure(this.failureMessage);

  @override
  List<Object> get props => [failureMessage];
}

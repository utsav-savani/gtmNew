import 'package:equatable/equatable.dart';

class Schedule extends Equatable {
  final String viewName;

  const Schedule({
    required this.viewName,
  });

  @override
  List<Object?> get props => [
        viewName,
      ];
}

import 'package:equatable/equatable.dart';

abstract class ApiState extends Equatable {}

class ApiLoadingState extends ApiState {
  @override
  List<Object?> get props => [];
}

class ApiLoadedState extends ApiState {
  final dynamic data;
  ApiLoadedState({required this.data});
  @override
  List<Object?> get props => [data];
}

class ApiErrorState extends ApiState {
  final String error;
  ApiErrorState({required this.error});
  @override
  List<Object?> get props => [error];
}
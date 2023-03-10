import 'package:flutter_bloc/flutter_bloc.dart';

import '../network/api_service.dart';
import 'api_event.dart';
import 'api_state.dart';

class ApiBloc extends Bloc<ApiEvent, ApiState> {
  final ApiService apiService;

  ApiBloc({required this.apiService}) : super(ApiLoadingState()){

    on<ApiEvent>((event, emit) async {
    emit(ApiLoadingState());
    try {
    final users = await apiService.get("http://jsonplaceholder.typicode.com/todos");
    emit(ApiLoadedState(data:users));
    } catch (e) {
    emit(ApiErrorState(error: e.toString()));
    }
  });
  }
}

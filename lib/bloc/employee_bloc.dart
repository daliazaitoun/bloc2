import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:bloc_ex/model/employee.dart';
import 'package:bloc_ex/repository/employee_repository.dart';
import 'package:meta/meta.dart';

part 'employee_event.dart';
part 'employee_state.dart';

class EmployeeBloc extends Bloc<EmployeeEvent, EmployeeState> {
  final EmployeeRepository _employeeRepository;
  EmployeeBloc(this._employeeRepository) : super(EmployeeLoadingState()) {
    on<EmployeeAddedEvent>(loadEmployeeFN);
  }

  FutureOr<void> loadEmployeeFN(EmployeeAddedEvent event, Emitter<EmployeeState>  emit) async{
    emit(EmployeeLoadingState());
    await _employeeRepository.getEmployees().then((employees) {
      emit(EmployeeLoadedState( employees));
    }).catchError((error) {
      emit(EmployeeErrorState( error.toString()));
    });
  }
}

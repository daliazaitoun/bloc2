part of 'employee_bloc.dart';

@immutable
sealed class EmployeeState {}

final class EmployeeLoadingState extends EmployeeState {}

final class EmployeeLoadedState extends EmployeeState {
  final List<Employee> employee;

  EmployeeLoadedState(this.employee);
}
final class EmployeeErrorState extends EmployeeState {
  final String errorMessage;

  EmployeeErrorState(this.errorMessage);
}

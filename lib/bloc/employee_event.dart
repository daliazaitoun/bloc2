part of 'employee_bloc.dart';

@immutable
sealed class EmployeeEvent {}

class EmployeeAddedEvent extends EmployeeEvent {}

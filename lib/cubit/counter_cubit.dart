import 'package:bloc/bloc.dart';
import 'package:bloc_ex/cubit/counter_state.dart';
import 'package:meta/meta.dart';


class CounterCubit extends Cubit<CounterState> {
 CounterCubit() : super(CounterState(0));

  void increment() => emit(CounterState(state.count + 1));
  void decrement() => emit(CounterState(state.count - 1));

}

part of 'fonibo_bloc.dart';

abstract class FoniboEvent extends Equatable {
  const FoniboEvent();
}

class FetchFoniboData extends FoniboEvent {
  FetchFoniboData();
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

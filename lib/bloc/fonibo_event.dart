part of 'fonibo_bloc.dart';

abstract class FoniboEvent extends Equatable {
  const FoniboEvent();
}

class FetchFoniboData extends FoniboEvent {
  FetchFoniboData() : super();
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class RefresFoniboData extends FoniboEvent {
  RefresFoniboData() : super();
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

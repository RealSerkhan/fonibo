part of 'fonibo_bloc.dart';

abstract class FoniboState extends Equatable {
  const FoniboState();
}

class FoniboInitial extends FoniboState {
  @override
  List<Object> get props => [];
}

class FoniboLoadingState extends FoniboState {
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class FoniboLoadedState extends FoniboState {
  List<Fonibo> foniboList;
  FoniboLoadedState({@required this.foniboList});
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class FoniboErrorState extends FoniboState {
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

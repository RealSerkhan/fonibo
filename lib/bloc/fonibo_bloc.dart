import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:fonibo/back/fonibo_repository.dart';
import 'package:fonibo/get_it/locator.dart';
import 'package:fonibo/models/Fonibo.dart';

part 'fonibo_event.dart';
part 'fonibo_state.dart';

class FoniboBloc extends Bloc<FoniboEvent, FoniboState> {
  FoniboBloc() : super(FoniboInitial());
  FoniboRepository _repository = locator<FoniboRepository>();

  @override
  Stream<FoniboState> mapEventToState(
    FoniboEvent event,
  ) async* {
    if (event is FetchFoniboData) {
      yield FoniboLoadingState();
      try {
        yield FoniboLoadedState(foniboList: await _repository.getData());
      } catch (_) {}
    } else if (event is RefresFoniboData) {
      yield FoniboLoadingState();
      try {
        yield FoniboLoadedState(foniboList: await _repository.getData());
      } catch (_) {}
    }
    // TODO: implement mapEventToState
  }
}

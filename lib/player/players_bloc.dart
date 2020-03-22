import 'package:bloc/bloc.dart';
import 'package:flutter_buzz/player/models/models.dart';

//TODO just use Provider for this simple functionality?
class PlayersBloc extends Bloc<PlayerEvent, Players> {

  @override
  Players get initialState => Players.empty();

  @override
  Stream<Players> mapEventToState(PlayerEvent event) async* {
    if (event is AddPlayer) {
      yield state.add(event.name);
    }

  }
}

abstract class PlayerEvent { }

class AddPlayer extends PlayerEvent {
  final String name;

  AddPlayer(this.name);
}

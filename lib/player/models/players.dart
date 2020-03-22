import 'package:flutter/foundation.dart';

const int kMaxPlayers = 4;

@immutable
class Players {

  final bool pickingEnded;
  final List<String> _players;

  const Players.empty(): _players = const [], pickingEnded = false;

  Players._add(List<String> players, String name) :
        _players = List()..addAll(players)..add(name),
        pickingEnded = players.length+1 == kMaxPlayers;

  Players._end(List<String> players) :
        _players = players,
        pickingEnded = true;

  Players endPicking() => Players._end(_players);

  Players add(String name) {
    if (_players.any((p) => p == name)) {
      throw "Name already chosen!";
    }
    if (pickingEnded) {
      throw "The picking stage has ended!";
    }
    if (_players.length >= kMaxPlayers) {
      throw "Max nb of players reached";
    }
    return Players._add(_players, name);
  }

  List<String> get all => List.unmodifiable(_players);

  int get nb => _players.length;

  String get(int index) => _players[index];

}
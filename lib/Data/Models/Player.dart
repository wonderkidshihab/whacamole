import 'package:wakeamole/Data/Models/PlayerModel.dart';

class Player extends PlayerModel{
  final String? id;
  String? username;
  int? score;
  int? rank;
  int? life;
  Player({required this.id, this.username, this.score, this.rank, this.life}) : super(id: id, score: score, username: username, rank: rank);

}
import 'package:darak_project/module/bar_graph/individual_baragraph.dart';

class BarData{
  final double janAmount;
  final double febAmount;
  final double marchAmount;
  final double aprilAmount;
  final double mayAmount;
  final double junAmount;
  final double julyAmount;
  final double augAmount;
  final double sepAmount;
  final double octAmount;
  final double novAmount;
  final double decAmount;

  BarData({

    required this.janAmount,
    required this.febAmount,
    required this.marchAmount,
    required this.aprilAmount,
    required this.mayAmount,
    required this.junAmount,
    required this.julyAmount,
    required this.augAmount,
    required this.sepAmount,
    required this.octAmount,
    required this.novAmount,
    required this.decAmount,

});

  List<IndividualBar> barData = [];
  void initializedBarData(){
    barData=[
    IndividualBar(x: 1,y: janAmount),
    IndividualBar(x: 2,y: febAmount),
    IndividualBar(x: 3,y: marchAmount),
    IndividualBar(x: 4,y: aprilAmount),
    IndividualBar(x: 5,y: mayAmount),
    IndividualBar(x: 6,y: junAmount),
    IndividualBar(x: 7,y: julyAmount),
    IndividualBar(x: 8,y: augAmount),
    IndividualBar(x: 9,y: sepAmount),
    IndividualBar(x: 10,y: octAmount),
    IndividualBar(x: 11,y: novAmount),
    IndividualBar(x: 12,y: decAmount),];
  }
}
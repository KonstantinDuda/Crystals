import 'crystal.dart';

List<CrystalPart> crystalParts = [];
List<CrystalPart> weaponParts = [];

generateDatabase() {
for(int i = 0; i < 9; i++){
  var side = PartSide.left;
  var value = i + 1;
  if(i >= 3 && i < 6){
    side = PartSide.center;
    value = i - 2;
  } else if(i >= 6){
    side = PartSide.right;
    value = i - 5;
  }
  
  crystalParts.add(CrystalPart(
    id: i + 1,
    name: "Left ${i + 1} Money Part",
    description: "Add ${i + 1} money",
    price: (i + 1) * 2,
    type: PartType.money,
    side: side,
    value: value,
  ));
  weaponParts.add(CrystalPart(
    id: i + 1,
    name: "Left ${i + 1} Weapon Part",
    description: "Add ${i + 1} damage",
    price: (i + 1) + 1,
    type: PartType.weapon,
    side: side,
    value: value,
  ));
}
}
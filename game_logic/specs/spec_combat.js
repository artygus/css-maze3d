/*
  Combat
 */

describe("Combat system", function(){
  var actor1 = null,
      actor2 = null;

  var wd = dataTypes.WorldDirection;

  beforeEach(function(){
    actor1 = new gameLogic.actors.Dummy(cgame);
    actor2 = new gameLogic.actors.Dummy(cgame);
    cgame.world.placeActor(icell, actor1, wd.S);
    cgame.world.placeActor(icell2, actor2, wd.N);
  });

  describe("Attack", function(){
    it("If I attack empty cell it raises error", function(){
      expect(false).toEqual(true);
    });

    it("If I attack actor it gets damage", function(){
      var start = actor2.data.get("currentHealth");

      actor1.turnStart();
      actor1.actionAttack();
      expect(actor2.data.get("currentHealth")).not.toEqual(start);
    });

  });

  describe("Receive dmg", function(){
    it("If I receive damage my health is gets lower", function(){
      var start = actor1.data.get("currentHealth");

      actor1.receiveDmg(actor2, 1);
      expect(actor1.data.get("currentHealth")).not.toEqual(start);

    });
  });

});
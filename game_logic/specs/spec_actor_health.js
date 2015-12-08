/*
  Actor health system spec
 */

describe("Actor health system", function(){

    it("If health goes below one then actor is dead", function(){
      var actor = new gameLogic.actors.DummyActor()
      actor.data.set("health", 0);
      expect(actor.isDead()).toEqual(true);
    });

  }
);
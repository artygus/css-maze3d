/*
  Actor health system spec
 */

describe("Actor health system", function(){

    it("If health goes below one then actor is dead", function(){
      var actor = new gameLogic.actors.DummyActor();
      actor.data.set("currentHealth", 0);
      expect(actor.isDead()).toEqual(true);
    });

    it("Health can't be more than max health", function(){
      expect(false).toEqual(true);
    });

  }
);
/*
  Actors action spec
 */

describe("Actors actions", function(){
  var actor = new gameLogic.actors.AbstractActor();

  describe("In charge", function(){

    it("Throws an error if actor are not in charge to perform action", function(){
      expect(
        function(){ actor.actionNoop(); }
      ).toThrow(actor.s.E_ACTOR_NOT_IN_CHARGE)
    });

  });

  describe("Noop", function(){

    it("Sends event about that action is completed.", function(done){
      actor.turnStart();

      $(actor).on(actor.s.I_ACTION_COMPLETED, function(){
        expect(true).toEqual(true);
        done();
      });

      actor.actionNoop();
    });

  });

});
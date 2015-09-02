/*
  Time entity spec
 */

describe("Time entity", function(){

  describe("State machine", function(){

    it("Can't change state if not all actors made their moves", function(){
      var actor = new gameLogic.actors.AbstractActor()
      cgame.world.placeActor(icell, actor)
      cgame.time.data.set("state", cgame.time.data.s.ROUND_STATE_TURN);

      expect(
        function(){
          cgame.time.data.set("state", cgame.time.data.s.ROUND_STATE_END);
        }
      ).toThrow(cgame.time.data.s.E_NOT_ALL_ACTORS_PERFOMED_ACTION);

    });

  });

});
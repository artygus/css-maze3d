/*
  Actors action spec
 */

describe("Actors actions", function(){

  var actor = null;
  var wd = dataTypes.WorldDirection;

  beforeEach(function(){
    actor = new gameLogic.actors.AbstractActor(cgame);
    cgame.world.placeActor(icell, actor, wd.N);
  });

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

  describe("Moving", function(){

    beforeEach(function(){
      actor.turnStart();
    });

    it("Moves forward N", function(){
      actor.actionMoveForward();

      var nc = [icell[0], icell[1]+1];
      expect(actor.getActorPosition().cell.toString()).toEqual(nc.toString());
    });

    it("Moves forward S", function(){
      cgame.world.changeActorDirection(actor, wd.S);
      actor.actionMoveForward();

      var nc = [icell[0], icell[1]-1];
      expect(actor.getActorPosition().cell.toString()).toEqual(nc.toString());
    });

    it("Moves forward E", function(){
      cgame.world.changeActorDirection(actor, wd.E);
      actor.actionMoveForward();

      var nc = [icell[0]+1, icell[1]];
      expect(actor.getActorPosition().cell.toString()).toEqual(nc.toString());
    });

    it("Moves forward W", function(){
      cgame.world.changeActorDirection(actor, wd.W);
      actor.actionMoveForward();

      var nc = [icell[0]-1, icell[1]];
      expect(actor.getActorPosition().cell.toString()).toEqual(nc.toString());
    });

    it("Moves backwards N", function(){
      cgame.world.changeActorDirection(actor, wd.N);
      actor.actionMoveBackward();

      var nc = [icell[0], icell[1]-1];
      expect(actor.getActorPosition().cell.toString()).toEqual(nc.toString());
    });

    it("Moves backwards S", function(){
      cgame.world.changeActorDirection(actor, wd.S);
      actor.actionMoveBackward();

      var nc = [icell[0], icell[1]+1];
      expect(actor.getActorPosition().cell.toString()).toEqual(nc.toString());
    });

    it("Moves backwards E", function(){
      cgame.world.changeActorDirection(actor, wd.E);
      actor.actionMoveBackward();

      var nc = [icell[0]-1, icell[1]];
      expect(actor.getActorPosition().cell.toString()).toEqual(nc.toString());
    });

    it("Moves backwards W", function(){
      cgame.world.changeActorDirection(actor, wd.W);
      actor.actionMoveBackward();

      var nc = [icell[0]+1, icell[1]];
      expect(actor.getActorPosition().cell.toString()).toEqual(nc.toString());
    });

    it("Strafes left N S", function(){
      expect(false).toEqual(true);
    });

    it("Strafes left E W", function(){
      expect(false).toEqual(true);
    });

    it("Strafes right N S", function(){
      expect(false).toEqual(true);
    });

    it("Strafes right E W", function(){
      expect(false).toEqual(true);
    });

    it("Turns clockwise", function(){
      expect(false).toEqual(true);
    });

    it("Turns anticlockwise", function(){
      expect(false).toEqual(true);
    });

  });

  describe("Moving restrictions", function(){

  });

});
/*
  Entities positions test
 */

describe("Entities positions", function(){

  var actor1 = null,
    actor2 = null;

  beforeEach(function(){
    actor1 = new gameLogic.actors.Player();
    actor2 = new gameLogic.actors.Player();
  });

  describe("Placing entities", function(){

    it("If I place entity it should be at a given position", function(){
      cgame.world.placeActor(icell, actor1);
      expect(cgame.world.data.get("actors").getData(icell).actor).toEqual(actor1);
    });

    it("If I place entity at non empty cell it should give an error", function(){
      cgame.world.placeActor(icell, actor1);
      expect(
        function(){ cgame.world.placeActor(icell, actor1); }
      ).toThrow(gameLogic.entities.World.E_NON_EMPTY_CELL);
    });

    it("I can't place entity at non-level cell", function(){
      expect(
        function(){ cgame.world.placeActor([0,0], actor1); }
      ).toThrow(gameLogic.entities.World.E_NONEXISTENT_CELL);
    });

  });

  describe("Moving entities", function(){
    var mfrom = [219, 208];
    var mto = [219, 209];

    beforeEach(function(){
      cgame.world.placeActor(mfrom, actor1);
    });

    it("If I move entity from old cell to new cell it shouldn't be at the old cell", function(){
      cgame.world.moveActor(actor1, mto);

      expect(cgame.world.data.get("actors").getData(mfrom)).toEqual(undefined);
      expect(cgame.world.data.get("actors").getData(mto).actor).toEqual(actor1);
      expect(cgame.world.data.get("actors").getData(mto).cell.toString()).toEqual(mto.toString());
    });

    it("I can't move entity to non-level cell", function(){
      expect(
        function(){ cgame.world.moveActor(actor1, [217, 208]); }
      ).toThrow(gameLogic.entities.World.E_NONEXISTENT_CELL);
    });

    it("I can't move entity to non empty cell", function(){
      cgame.world.placeActor(mto, actor2);

      expect(
        function(){ cgame.world.moveActor(actor1, mto); }
      ).toThrow(gameLogic.entities.World.E_NON_EMPTY_CELL);
    });

  });

  describe("Removing entities", function(){

    it("If I removed entity it shouldn't belongs to level anymore", function(){
      cgame.world.placeActor(icell, actor1);
      cgame.world.removeActor(actor1);

      expect(cgame.world.data.get("actors").getData(icell)).toEqual(undefined);
    });

  });

  describe("Changing directions", function(){

    it("Changes direction if I changed it", function(){
      cgame.world.placeActor(icell, actor1);
      cgame.world.changeActorDirection(actor1, dataTypes.WorldDirection.E);

      expect(cgame.world.getActorPosition(actor1).dir).toEqual(dataTypes.WorldDirection.E);
    });

  });

});
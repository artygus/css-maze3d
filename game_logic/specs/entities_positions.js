/*
  Entities positions test
 */

describe("Entities positions", function(){

  var cgame = null,
    entity1 = null,
    entity2 = null,
    icell = null;

  beforeEach(function(){
    cgame = new gameLogic.App();
    cgame.world.load({"219x207":{"x":219,"y":207,"n":{"face":"black-wall","type":"wall"},"w":{"face":"black-wall","type":"wall"},"e":{"face":"black-wall","type":"wall"}},"219x208":{"x":219,"y":208},"219x209":{"x":219,"y":209,"s":{"face":"black-wall","type":"wall"},"w":{"face":"black-wall","type":"wall"},"e":{"face":"black-wall","type":"wall"}},"220x208":{"x":220,"y":208,"n":{"face":"black-wall","type":"wall"},"s":{"face":"black-wall","type":"wall"},"e":{"face":"black-wall","type":"wall"}},"218x208":{"x":218,"y":208,"n":{"face":"black-wall","type":"wall"},"s":{"face":"black-wall","type":"wall"},"w":{"face":"black-wall","type":"wall"}}});
    entity1 = new gameLogic.entities.Player();
    entity2 = new gameLogic.entities.Player();
    icell = cgame.world.data.get("level").getFlatCellCoords()[0];
  });

  describe("Placing entities", function(){

    it("If I place entity it should be at a given position", function(){
      cgame.world.placeEntity(icell, entity1);
      expect(cgame.world.data.get("entities").getData(icell)).toEqual(entity1);
    });

    it("If I place entity at non empty cell it should give an error", function(){
      cgame.world.placeEntity(icell, entity1);
      expect(
        function(){ cgame.world.placeEntity(icell, entity1); }
      ).toThrow(gameLogic.entities.World.E_NON_EMPTY_CELL);
    });

    it("I can't place entity at non-level cell", function(){
      expect(
        function(){ cgame.world.placeEntity([0,0], entity1); }
      ).toThrow(gameLogic.entities.World.E_NONEXISTENT_CELL);
    });

  });

  describe("Moving entities", function(){
    var mfrom = [219, 208];
    var mto = [219, 209];

    beforeEach(function(){
      cgame.world.placeEntity(mfrom, entity1);
    });

    it("If I move entity from old cell to new cell it shouldn't be at the old cell", function(){
      cgame.world.moveEntity(mfrom, mto, entity1);

      expect(cgame.world.data.get("entities").getData(mfrom)).toEqual(undefined);
      expect(cgame.world.data.get("entities").getData(mto)).toEqual(entity1);
    });

    it("I can't move entity to non-level cell", function(){
      expect(
        function(){ cgame.world.moveEntity(mfrom, [217, 208], entity1); }
      ).toThrow(gameLogic.entities.World.E_NONEXISTENT_CELL);
    });

    it("I can't move entity to non empty cell", function(){
      cgame.world.placeEntity(mto, entity2);

      expect(
        function(){ cgame.world.moveEntity(mfrom, mto, entity1); }
      ).toThrow(gameLogic.entities.World.E_NON_EMPTY_CELL);
    });

  });

  describe("Removing entities", function(){

    it("If I removed entity it shouldn't belongs to level anymore", function(){
      cgame.world.placeEntity(icell, entity1);
      cgame.world.removeEntity(icell, entity2);

      expect(cgame.world.data.get("entities").getData(icell)).toEqual(undefined);
    });

  });

});
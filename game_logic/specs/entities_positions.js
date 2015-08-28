/*
  Entities positions test
 */

describe("Entities positions", function(){

  var cgame = null,
    character1 = null,
    character2 = null,
    icell = null;

  beforeEach(function(){
    cgame = new gameLogic.App();
    cgame.world.load({"219x207":{"x":219,"y":207,"n":{"face":"black-wall","type":"wall"},"w":{"face":"black-wall","type":"wall"},"e":{"face":"black-wall","type":"wall"}},"219x208":{"x":219,"y":208},"219x209":{"x":219,"y":209,"s":{"face":"black-wall","type":"wall"},"w":{"face":"black-wall","type":"wall"},"e":{"face":"black-wall","type":"wall"}},"220x208":{"x":220,"y":208,"n":{"face":"black-wall","type":"wall"},"s":{"face":"black-wall","type":"wall"},"e":{"face":"black-wall","type":"wall"}},"218x208":{"x":218,"y":208,"n":{"face":"black-wall","type":"wall"},"s":{"face":"black-wall","type":"wall"},"w":{"face":"black-wall","type":"wall"}}});
    character1 = new gameLogic.characters.Player();
    character2 = new gameLogic.characters.Player();
    icell = cgame.world.data.get("level").getFlatCellCoords()[0];
  });

  describe("Placing entities", function(){

    it("If I place entity it should be at a given position", function(){
      cgame.world.placeCharacter(icell, character1);
      expect(cgame.world.data.get("characters").getData(icell).character).toEqual(character1);
    });

    it("If I place entity at non empty cell it should give an error", function(){
      cgame.world.placeCharacter(icell, character1);
      expect(
        function(){ cgame.world.placeCharacter(icell, character1); }
      ).toThrow(gameLogic.entities.World.E_NON_EMPTY_CELL);
    });

    it("I can't place entity at non-level cell", function(){
      expect(
        function(){ cgame.world.placeCharacter([0,0], character1); }
      ).toThrow(gameLogic.entities.World.E_NONEXISTENT_CELL);
    });

  });

  describe("Moving entities", function(){
    var mfrom = [219, 208];
    var mto = [219, 209];

    beforeEach(function(){
      cgame.world.placeCharacter(mfrom, character1);
    });

    it("If I move entity from old cell to new cell it shouldn't be at the old cell", function(){
      cgame.world.moveCharacter(mfrom, mto, character1);

      expect(cgame.world.data.get("characters").getData(mfrom)).toEqual(undefined);
      expect(cgame.world.data.get("characters").getData(mto).character).toEqual(character1);
    });

    it("I can't move entity to non-level cell", function(){
      expect(
        function(){ cgame.world.moveCharacter(mfrom, [217, 208], character1); }
      ).toThrow(gameLogic.entities.World.E_NONEXISTENT_CELL);
    });

    it("I can't move entity to non empty cell", function(){
      cgame.world.placeCharacter(mto, character2);

      expect(
        function(){ cgame.world.moveCharacter(mfrom, mto, character1); }
      ).toThrow(gameLogic.entities.World.E_NON_EMPTY_CELL);
    });

  });

  describe("Removing entities", function(){

    it("If I removed entity it shouldn't belongs to level anymore", function(){
      cgame.world.placeCharacter(icell, character1);
      cgame.world.removeCharacter(icell, character2);

      expect(cgame.world.data.get("characters").getData(icell)).toEqual(undefined);
    });

  });

  describe("Changing directions", function(){

    it("Changes direction if I changed it", function(){
      cgame.world.placeCharacter(icell, character1);
      cgame.world.changeCharacterDirection(character1, dataTypes.WorldDirection.E);

      expect(cgame.world.getCharacterPosition(character1).dir).toEqual(dataTypes.WorldDirection.E);
    });

  });

});
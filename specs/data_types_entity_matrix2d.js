/*
  Entity matrix 2d spec
 */

describe("Entity matrix 2d data type", function(){
  var data = new dataTypes.EntityMatrix2d();
  var entity = {id: 1};
  var cell = [0, 1];

  beforeEach(function(){
    data.putData(cell, entity);
  });

  describe("Tracking entities", function(){

    it("When I set entity it should track it in the search tree", function(){
      expect(data.getData(cell)).toEqual(entity);
      expect(data.get("entityToCoords")[entity.id]).toEqual(entity);
    });

    it("When I remove entity it should remove track info about it", function(){
      data.removeData(cell);
      expect(data.get("entityToCoords")[entity.id]).toEqual(undefined);
    });

  });

});
/*
  Shared spec data
 */

var testWorld = {"219x207":{"x":219,"y":207,"n":{"face":"black-wall","type":"wall"},"w":{"face":"black-wall","type":"wall"},"e":{"face":"black-wall","type":"wall"}},"219x208":{"x":219,"y":208},"219x209":{"x":219,"y":209,"s":{"face":"black-wall","type":"wall"},"w":{"face":"black-wall","type":"wall"},"e":{"face":"black-wall","type":"wall"}},"220x208":{"x":220,"y":208,"n":{"face":"black-wall","type":"wall"},"s":{"face":"black-wall","type":"wall"},"e":{"face":"black-wall","type":"wall"}},"218x208":{"x":218,"y":208,"n":{"face":"black-wall","type":"wall"},"s":{"face":"black-wall","type":"wall"},"w":{"face":"black-wall","type":"wall"}}};
var cgame = null;
var icell = [219, 208];

beforeEach(function(){
  cgame = new gameLogic.App();
  cgame.world.load(testWorld);
});
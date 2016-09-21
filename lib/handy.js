window.Handy = {

  // @return {String}
  jqRemoveClassByPart: function(el, part){
    return el
      .attr("class")
      .split(" ")
      .filter(function(v){ return v.indexOf(part) < 0 })
      .join(" ")
  }

}



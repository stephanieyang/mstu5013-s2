<drag-space>
  <div class="container" id="dragSpace">
    <h2>Draggable Container</h2>
      <div class="row">
        <div class="col-md-8">
          <div class="container" id="stagingCanvas">
            <h3>Staging Canvas</h3>
              <div id="directions">
                <p>Left-click on images you like to move them from the picture bank to the stage or from the stage to the final zone.</p>
                <p>Right-click on images to move them from the final zone to the stage or from the stage to the picture bank.</p>
                <p>When you have <strong>exactly three</strong> images representing your biggest interests in the final zone, click "Get Results" to see what fields you might be interested in!</p>
              </div>
              <h4>Stage</h4>
              <div id="stage">
                <pic class='image' each={ image in this.stageItems } onclick={ handleImageClick } oncontextmenu={ handleRightClick }></pic>
              </div>
              <h4>Final Zone</h4>
              <div id="target">
                <pic class='image' each={ image in this.targetItems } onclick={ handleImageClick } oncontextmenu={ handleRightClick }></pic>
              </div>
          </div>
        </div>
        <div class="col-md-4">
          <div class="container" id="picBank">
            <pic class='image' each={ image in this.bankItems } onclick={ handleImageClick } oncontextmenu={ handleRightClick }></pic>
          </div>
        </div>
      </div>
      <button type="button" onclick={ getResults }>Get Results</button> 
  </div>
  <style scoped>
  #dragSpace {
  background-color: blue;
  }
  #picBank {
    background-color: yellow;
  }
  #stagingCanvas {
  background-color: yellow;
  }

  #stagingCanvas div {
    margin: 10px;
  }

  #stage {
    height:200px;
    background-color: white;
  }

  #target {
    height:200px;
    background-color: #B6F9B6;
  }
  #directions p {
    font-size: 1em;
  }
  </style>
  <script>
  var MAX_ITEMS = 3;
  var itemDetails = {}
  var itemDirectory = {}; // dictionary of items/locations
  var BANK_ID = '#picBank';
  var STAGE_ID = '#stage';
  var TARGET_ID = '#target';
  this.bankItems = [];
  this.stageItems = [];
  this.targetItems = [];

  this.divideItems = function() {
    this.bankItems = [];
    this.stageItems = [];
    this.targetItems = [];
    var items = Object.keys(itemDirectory);
    console.log(items);
    for(var i = 0; i < items.length; i++) {
      var imgId = items[i];
      var imgDetails = itemDetails[imgId];
      var imgLocation = getImageLocation(imgId);
      switch(imgLocation) {
        case BANK_ID:
          this.bankItems.push(imgDetails);
          break;
        case STAGE_ID:
          this.stageItems.push(imgDetails);
          break;
        case TARGET_ID: 
          this.targetItems.push(imgDetails);
          break;
      }
    }
    printContents();
  }

  function printContents() {
    console.log("bank",this.bankItems);
    console.log("stage",this.stageItems);
    console.log("target",this.targetItems);
    console.log("imageList",imageList);
  }

  console.log('this',this);

  this.on('update', function() {
    console.log('update logged');
    console.log(this);
    this.divideItems();
    this.handleTargetZone();
  });


  /*
   * Returns true iff the number of items in the target zone is the maximum allowed.
   */
this.atMaxCapacity = function() {
    return (this.targetItems.length === MAX_ITEMS);
  }

  this.loadItemsAtInit = function() {
    console.log('loadItemsAtInit');
    console.log("imageList",imageList);
    for(var i = 0; i < imageList.length; i++) {
      var imageId = imageList[i].imageId;
      setImageLocation(imageId, BANK_ID);
      itemDetails[imageId] = imageList[i];
      //itemDirectory['#' + imageId] = BANK_ID;
    }
    /*
    for(var i = 0; i < imageIdList.length; i++) {
      var imageId = imageIdList[i];
      setImageLocation(imageId, BANK_ID);
      //itemDirectory['#' + imageId] = BANK_ID;
    }
    console.log(itemDirectory);
    */
    console.log("item details",itemDetails);
  }

  console.log('init');
  this.bankItems = [];
  this.stageItems = [];
  this.targetItems = [];
  this.loadItemsAtInit();
  //this.divideItems();

  function getImageLocation(imageId) {
    console.log('getImageLocation');
    return itemDirectory[imageId];
  }

  function setImageLocation(imageId, loc) {
    console.log('setImageLocation');
    itemDirectory[imageId] = loc;
    console.log("itemDirectory",itemDirectory);
  }

this.handleRightClick = function(event) {
  console.log('handleRightClick');
  this.handleImageClick(event,true);
}

  this.handleImageClick = function(event, isRightClick) {
    console.log('handleImageClick');
    var isForward = !(isRightClick || false);
    //console.log(event);
    //console.log(event.item.image.imageId);
    //var imageId = event.currentTarget.id;
    var imageId = event.item.image.imageId;
    var currentLoc = getImageLocation(imageId);
    var dest = determineDestination(currentLoc, isForward);
    console.log('current',currentLoc);
    console.log('dest',dest);
    if(currentLoc === dest) {
      console.log('invalid/same destination:',dest);
      // do nothing
    } else if(dest === TARGET_ID && this.atMaxCapacity()) {
      alert('Only 3 items max in the final zone!');
    } else {
      moveItem(imageId, currentLoc, dest);
    }
  };

  function determineDestination(currentLoc, isForwardClick) {
    console.log('determineDestination');
    switch(currentLoc) {
      case BANK_ID:
        return (isForwardClick ? STAGE_ID : BANK_ID);
        break;
      case STAGE_ID:
        return (isForwardClick ? TARGET_ID : BANK_ID);
        break;
      case TARGET_ID:
        return (isForwardClick ? TARGET_ID : STAGE_ID);
        break;
      default:
        console.log("invalid source location");
        break;
    }
  }

  function moveItem(id, src, dest) {
    console.log('moveItem');
    console.log(id,src,dest);
    var item = $("#" + id);
    //$(src).detach(item);
    //item.detach();
    //$(dest).append(item);
    setImageLocation(id, dest);
  }

  /*
   * Handles the logic of whether the target drop zone ought to accept/reject new images.
   * Also changes the color of the target zone to reflect this.
   */
  this.handleTargetZone = function() {
    console.log('handleTargetZone');
    if(this.atMaxCapacity()) {
      $(TARGET_ID).css('background-color','#C0C0C0');
      //dropZoneDisabledAtDragStart = false;
    } else {
      $(TARGET_ID).css('background-color','#B6F9B6');
      //dropZoneDisabledAtDragStart = true;
    }
  }

  

  /*
   * The target drop zone is more discerning than the sandbox.
   * Until MAX_ITEMS items are inside, it will take any image.
   * At MAX_ITEMS items, it will reject any images until one is taken out.
   * Therefore we want to track how many items are inside the drop zone and which items they are.
   */

  // when the button is clicked, log which items are in the target drop zone
  this.getResults = function() {
    console.log('number of selected items:', this.targetItems.length);
    console.log('items selected:', this.targetItems);
    if(this.targetItems.length === 3) {
      console.log('correct number selected');
      // do other stuff
    }
  };
  </script>
</drag-space>
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
  var BANK_ID = '#picBank';
  var STAGE_ID = '#stage';
  var TARGET_ID = '#target';
  this.bankItems = []; // list of items/images in the picture bank
  this.stageItems = []; // list of items in the stage area
  this.targetItems = []; // list of items in the target/final area
  this.itemDetails = {}; // stores information about each item: filename, id, category, location on screen



  this.on('update', function() {
    // continuously change the color of the target area according to how many items are inside
    this.handleTargetZone();
  });

  this.on('before-mount', function() {
    this.loadItemsAtInit();
  });

  /* Loads the image details at the start. */
  this.loadItemsAtInit = function() {
    for(var i = 0; i < imageList.length; i++) {
      var imageDetails = imageList[i];
      imageDetails['location'] = BANK_ID;
      var imageId = imageDetails.imageId;
      this.bankItems.push(imageDetails);
      this.itemDetails[imageId] = imageDetails;
    }
  };

  /* Returns true iff the number of items in the target zone is the maximum allowed. */
  this.atMaxCapacity = function() {
    return (this.targetItems.length === MAX_ITEMS);
  }

  /* Returns whether an image is currently in the picture bank, the stage area, or the target area. */
  this.getImageLocation = function(imageId) {
    return this.itemDetails[imageId]['location'];
  };

  this.setImageLocation = function(imageId, loc) {
    this.itemDetails[imageId]['location'] = loc;

  }

  /* Handles the right-click event. Mostly a wrapper for the generic handleImageClick. */
  this.handleRightClick = function(event) {
    this.handleImageClick(event,true);
  };

  /* Handles click events for images. */
  this.handleImageClick = function(event, isRightClick) {
    var isForward = !(isRightClick || false);
    //console.log(event);
    //console.log(event.item.image.imageId);
    //var imageId = event.currentTarget.id;
    var imageId = event.item.image.imageId;
    var currentLoc = this.getImageLocation(imageId);
    var dest = determineDestination(currentLoc, isForward);
    console.log('current',currentLoc,'dest',dest);
    if(currentLoc === dest) {
      console.log('invalid/same destination:',dest);
      // do nothing
    } else if(dest === TARGET_ID && this.atMaxCapacity()) {
      alert('Only 3 items max in the final zone!');
    } else {
      this.moveItem(imageId, currentLoc, dest);
    }
  };

  /* Given a current image location and a direction indicated by left/right click (forward/back),
   * returns where the image should go next. */
  function determineDestination(currentLoc, isForwardClick) {
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

  /* Gets the index of the item object corresponding to a given ID in a given list. */
  function getIndexOfItem(itemList, itemId) {
    for(var i = 0; i < itemList.length; i++) {
      if(itemList[i]['imageId'] === itemId) {
        return i;
      }
    }
    // if here, something has gone wrong - didn't find the item in the list
    console.log('ERROR: item not found',itemId,itemList);
  }

  /* Handles the swapping of items between lists for different area locations. */
  this.moveItem = function(id, src, dest) {
    console.log('moveItem',id,src,dest);
    var item;
    // remove item from its current list
    switch(src) {
      case BANK_ID:
        var index = getIndexOfItem(this.bankItems, id);
        // splice should return a list of length 1 here, so get the contents via the 0th index
        item = this.bankItems.splice(index,1)[0];
        break;
      case STAGE_ID:
        var index = getIndexOfItem(this.stageItems, id);
        item = this.stageItems.splice(index,1)[0];
        break;
      case TARGET_ID:
        var index = getIndexOfItem(this.targetItems, id);
        item = this.targetItems.splice(index,1)[0];
        break;
      default:
        console.log("invalid source location");
        break;
    }
    // add item to new (destination) list
    switch(dest) {
      case BANK_ID:
        this.bankItems.push(item);
        break;
      case STAGE_ID:
        this.stageItems.push(item);
        break;
      case TARGET_ID:
        this.targetItems.push(item);
        break;
      default:
        console.log("invalid source location");
        break;
    }
    // log the change in location
    this.setImageLocation(id,dest);
    console.log(this.itemDetails);
  }

  /* Handles the logic of whether the target zone ought to accept/reject new images.
   * Also changes the color of the target zone to reflect this. */
  this.handleTargetZone = function() {
    if(this.atMaxCapacity()) {
      $(TARGET_ID).css('background-color','#C0C0C0');
      //dropZoneDisabledAtDragStart = false;
    } else {
      $(TARGET_ID).css('background-color','#B6F9B6');
      //dropZoneDisabledAtDragStart = true;
    }
  };

  // when the button is clicked, log which items are in the target drop zone
  this.getResults = function() {
    console.log('number of selected items:', this.targetItems.length);
    console.log('items selected:', this.targetItems); // array of image information objects (storing filename, image ID, associated category) - see imageBank.js
    if(this.targetItems.length === 3) {
      console.log('at correct capacity');
      var itemIds = [];
      for(var i = 0; i < this.targetItems.length; i++) {
        itemIds.push(this.targetItems[i].imageId);
      }
      console.log(itemIds); // array of item IDs - e.g., ['fossil','plant','dropper']
      // do stuff
    }
  };
  </script>
</drag-space>
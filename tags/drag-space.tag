<drag-space>
  <div class="container" id="drag-space">
    <h2>STEM APP</h2>
      <div class="row">
        <div class="col-md-8">
          <div class="container" id="staging-canvas">
  <h3>Instructions</h3>
              <div id="directions">
                  <img id="direction-graphic" src="img/mouse.png" class="pull-left" alt="Directions">
                  <div id="direction-text">
                    <p><strong>Left-click</strong> on images you like to move them from the picture bank to the stage or from the stage to the final zone.</p>
                    <p><strong>Right-click</strong> on images to move them from the final zone to the stage or from the stage to the picture bank.</p>
                    <p>When you have <strong>exactly three</strong> images representing your biggest interests in the final zone, click "Get Results" to see what fields you might be interested in!</p>
                  </div>
              </div>
              <h3>Stage</h3>
              <div id="stage">
  <p>
                <pic class='image' each={ image in this.stageItems } onclick={ handleImageClick } oncontextmenu={ handleRightClick }></pic>
  </p>
              </div>
              <h3>Final Zone</h3>
              <div id="target">
  <p>
                <pic class='image' each={ image in this.targetItems } onclick={ handleImageClick } oncontextmenu={ handleRightClick }></pic>
  </p>
              </div>
          </div>
        </div>
        <div class="col-md-4">
          <div class="container" id="pic-bank">

          <h3>Picture Bank</h3>
  <p>
            <pic class='image' each={ image in this.bankItems } onclick={ handleImageClick } oncontextmenu={ handleRightClick }></pic>
  </p>
  </p>
          </div>
        </div>
      </div>
      <div class="row">
        <div class="col-md-8">
  <div class="container" id="button">
  <button type="button" class="btn-info btn-block btn-lg" onclick={ getResults }>Get Results</button>
        </div>
      </div>

  </div>
  <style scoped>

  #direction-graphic {
  margin-left: auto;
  margin-right: 25px;
  margin-top: 15px;
  margin-bottom: 25px;
  };

  #directions {
  margin:0px 10px 0px 10px;
  }

  #direction-text {
    padding:10px 10px 0px 10px;
    vertical-align: middle;
  }

  h3:not(:first-child){
  margin-top: 40px;
  }


  button {
    margin-top:25px;
    margin-bottom:25px;
  }
  #drag-space {
  border-style: solid;
  border-width: 10px;
  border-color: #160D3A;
  background-color: white;
  }
  #pic-bank {  border-style: solid;
  border-width: 10px;
  border-color: #160D3A;
  background-color: white;
  }
  #staging-canvas {
  border-style: solid;
  border-width: 10px;
  border-color: #160D3A;
  background-color: white;
  }

  #staging-canvas div {
    margin: 10px;
  }

  #stage {
  border-style: solid;
  border-width: 10px;
  border-color: #160D3A;
  padding: 50px 10px 50px 10px;
  margin-bottom: 100px;
  }


  #target {
    background-color: #BCED4D;
  border-color: #160D3A;
  border-style: solid;
  border-width: 10px;
  padding: 50px 55px 75px 55px;
  position: relative
  }

  #target p{
  position: absolute;
  top: 50%;
  left: 50%;
  margin-right: -50%;
  transform: translate(-50%, -50%)
    }
  #directions p {
    font-size: 1em;
  }

  </style>
  <script>
  var MAX_ITEMS = 3;
  var BANK_ID = '#pic-bank';
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
      $(TARGET_ID).css('background-color','#5E45D3');
      //dropZoneDisabledAtDragStart = false;
    } else {
      $(TARGET_ID).css('background-color','#BCED4D');
      //dropZoneDisabledAtDragStart = true;
    }
  };

  // when the button is clicked, log which items are in the target drop zone
  this.getResults = function() {
    $("#loading").html('<p>Loading...</p>');
    console.log('number of selected items:', this.targetItems.length);
    console.log('items selected:', this.targetItems); // array of image information objects (storing filename, image ID, associated category) - see imageBank.js
    if(this.targetItems.length === 3) {
      console.log('at correct capacity');
      //var itemIds = [];
      var selectedCategories = [];
      for(var i = 0; i < this.targetItems.length; i++) {
        selectedCategories.push(this.targetItems[i].category);
      }
      //alphabetically sorted each category in targetItems
      selectedCategories.sort();
      console.log(selectedCategories); // array of item categories - e.g., ['math','biology','chemistry']

      // do stuff

      var choice1 = selectedCategories[0];
      var choice2 = selectedCategories[1];
      var choice3 = selectedCategories[2];

      var promises = [];

      var fieldList;
      var fieldQuery = new Parse.Query('Field');
      console.log("making field query");
      fieldQuery.containedIn("categories", [choice1,choice2,choice3]);
      promises.push(fieldQuery.find().then(function(results) {
        console.log(results);
        fieldList = results; // list of Field objects
      }));

      var mentorList;
      var mentorQuery = new Parse.Query('Mentor');
      console.log("making mentor query");
      //var fieldArray = [choice1,choice2,choice3];
      $.unique(selectedCategories);
      mentorQuery.containedIn("categories", selectedCategories);
      //mentorQuery.include("fields");
      promises.push(mentorQuery.find().then(function(results) {
        console.log(results);
        mentorList = results; // list of Mentor objects
      }));

      Parse.Promise.when(promises).then(function() {
        console.log("done with promises");

        console.log("mounting");

        // mount the results container, pass in the results
        riot.mount('results-container', {
          'selectedCategories' : selectedCategories,
          'fieldList' : fieldList,
          'mentorList' : mentorList,
        });
        $("#results").html('');
      });



      /*
      var query = new Parse.Query("Comments");
      query.equalTo("post", 123);

      query.find().then(function(results) {
        // Collect one promise for each delete into an array.
        var promises = [];
        _.each(results, function(result) {
          // Start this delete immediately and add its promise to the list.
          promises.push(result.destroy());
        });
        // Return a new promise that is resolved when all of the deletes are finished.
        return Parse.Promise.when(promises);

      }).then(function() {
        // Every comment was deleted.
      });
      */




      /*
      var combo1 = categoryBank[choice1][choice2];
      var combo2 = categoryBank[choice1][choice3];
      var combo3 = categoryBank[choice2][choice3];
      console.log(combo1, combo2, combo3);
      */

    }
  };
  </script>

</drag-space>

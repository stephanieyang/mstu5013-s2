<drag-space>
	<div class="container" id="drag-space">
		<h2>Play Space</h2>
		<div class="row">
			<div class="col-md-8">
				<div class="container" id="staging-canvas">
						<h3>Instructions</h3>
						<div id="directions">
							<img id="direction-graphic" src="img/mouse.png" class="pull-left" alt="Directions">
							<div id="direction-text">
								<p><strong>Left-click</strong> on images you like to move them from the picture bank to the stage or from the stage to the final zone.</p>
								<p><strong>Right-click</strong> on images to move them from the final zone to the stage or from the stage to the picture bank.</p>
								<p>When you have <strong>exactly three</strong> images representing your biggest interests in the final zone, click "Get Results" to see what fields you might be interested in and which savvy STEMinist you might be!</p>
							</div>
					</div>
					<h3>Stage</h3>
					<div id="stage">
						<pic class='image' each={ image in this.stageItems } onclick={ handleImageClick } oncontextmenu={ handleRightClick }></pic>
					</div>
					<h3>Final Zone</h3>
					<div id="target">
						<pic class='image' each={ image in this.targetItems } onclick={ handleImageClick } oncontextmenu={ handleRightClick }></pic>
					</div>
					<div id="button">
					<button type="button" class="btn-info btn-block btn-lg" onclick={getResults}>Get Results</button>
					</div>
				</div>
			</div>
			<div class="col-md-4">
				<div class="container" id="pic-bank">
				<h3>Picture Bank</h3>
					<pic class='image' each={ image in this.bankItems } onclick={ handleImageClick } oncontextmenu={ handleRightClick }></pic>
				</div>
			</div>
		</div>
		<div class="row">
			<div class="col-md-8"></div>
		</div>
	</div>
	<style scoped>
		#direction-graphic {
			margin-left: auto;
			margin-right: 25px;
			margin-top: 15px;
			margin-bottom: 25px;
		}

		#directions {
			margin:0 10px 0 10px;
		}

		#direction-text {
			padding:10px 10px 0 10px;
			vertical-align: middle;
		}

		h3:not(:first-child){
			margin-top: 40px;
		}

		button {
			margin-top:40px;
		}

		#drag-space {
			border-style: solid;
			border-width: 10px;
			border-color: #160D3A;
			background-color: white;
		}

		#pic-bank {
			margin-bottom:25px;
			border-style: solid;
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
			padding: 65px 10px 65px 10px;
			margin-bottom: 100px;
		}

		#target {
			background-color: #BCED4D;
			border-color: #160D3A;
			border-style: solid;
			border-width: 10px;
			padding: 65px 55px 65px 55px;
			height: 10em;
			display: flex;
			align-items: center;
			justify-content: center;
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
			var imageId = event.item.image.imageId;
			var currentLoc = this.getImageLocation(imageId);
			var dest = determineDestination(currentLoc, isForward);
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
		}

		/* Handles the logic of whether the target zone ought to accept/reject new images.
		 * Also changes the color of the target zone to reflect this. */
		this.handleTargetZone = function() {
			if(this.atMaxCapacity()) {
				$(TARGET_ID).css('background-color','#5E45D3');
			} else {
				$(TARGET_ID).css('background-color','#BCED4D');
			}
		};

		

		/* Takes each combination of two elements in an array and operates on the pair.
		 * Very slightly tweaked from:
		 * http://stackoverflow.com/questions/22566379/how-to-get-all-pairs-of-array-javascript
		 */
		Array.prototype.pairs = function (func) {
			if(this.length <= 1) {
				console.log("Error: length <= 1");
				return;
			}
			var pairs = [];
			for (var i = 0; i < this.length - 1; i++) {
					for (var j = i; j < this.length - 1; j++) {
							func([this[i], this[j+1]]);
					}
			}
		}

		// when the button is clicked, log which items are in the target drop zone
		this.getResults = function() {
			$("#loading").html('<p>Loading...</p>');
			if(this.targetItems.length === 3) {
				var selectedCategories = [];
				for(var i = 0; i < this.targetItems.length; i++) {
					selectedCategories.push(this.targetItems[i].category);
				}
				//alphabetically sorted each category in targetItems
				selectedCategories.sort();

				var promises = [];

				this.fieldList = [];
				this.mentorList = [];
				this.fieldNameList = [];
				var that = this;
				var fieldQuery = new Parse.Query('Field');
				var mentorQuery = new Parse.Query('Mentor');

				// eliminate duplicate categories, so we're operating on unique category names
				$.unique(selectedCategories);
				// when only one category is selected (all images have the same category), output all mentors/fields related to that one category
				if(selectedCategories.length == 1) { // pairwise not possible
					// field query
					fieldQuery.containedIn("categories", [selectedCategories[0]]);
					fieldQuery.ascending("name");
					promises.push(fieldQuery.find().then(function(results) {
						for(var i = 0; i < results.length; i++) {
							that.fieldList.push(results[i]);
						}
					}));
					// mentor query
					mentorQuery.containedIn("categories", [selectedCategories[0]]);
					promises.push(mentorQuery.find().then(function(results) {
						for(var i = 0; i < results.length; i++) {
							that.mentorList.push(results[i]);
						}
					}));

				} else { // pairwise possible
					/* When multiple categories are selected, output mentors/fields associated with the categories' pairwise intersections.
					 * To avoid duplicates (e.g., for each pair we look at "Art" twice) we construct one giant query for fields and mentors each,
					 * each giant query framed as an OR of many smaller queries.
					 * Part 1: create a list of smaller queries.
					 * Part 2: create a larger query via OR operations on the list of smaller queries.
					 */
					var fieldQueryList = [];
					var mentorQueryList = [];

					/* Part 1: smaller queries
					 * Take the categories pairwise and form queries based on each pair.
					 */
					selectedCategories.pairs(function(pair){
						// field queries
						firstCategoryQuery = new Parse.Query('Field');
						secondCategoryQuery = new Parse.Query('Field');
						intersectionQuery = new Parse.Query('Field');
						firstCategoryQuery.equalTo("name", pair[0]);
						secondCategoryQuery.equalTo("name", pair[1]);
						intersectionQuery.containsAll("categories", pair);
						fieldQueryList.push(firstCategoryQuery);
						fieldQueryList.push(secondCategoryQuery);
						fieldQueryList.push(intersectionQuery);

						// mentor queries
						/* We shouldn't run into the same duplicate issue if we stick to two categories per mentor, but just for scalability we do the same. */
						var currentMentorQuery = new Parse.Query('Mentor');
						currentMentorQuery.containsAll("categories", pair);
						mentorQueryList.push(currentMentorQuery);

					});

					/* Part 2: larger OR queries */
					// field query
					fieldQuery = Parse.Query.or(fieldQueryList[0], fieldQueryList[1]);
					for(var i = 2; i < fieldQueryList.length; i++) { // leave out first two
						var tempQuery = fieldQuery;
						var currentQuery = fieldQueryList[i];
						fieldQuery = Parse.Query.or(tempQuery, currentQuery);
					}
					fieldQuery.ascending("name");
					promises.push(fieldQuery.find().then(function(results) {
						for(var i = 0; i < results.length; i++) {
							that.fieldList.push(results[i]);
						}
					}));


					console.log("selectedCategories",selectedCategories);
					console.log("mentorQueryList", mentorQueryList);

					// mentor query
					if(mentorQueryList.length > 1) {
						mentorQuery = Parse.Query.or(mentorQueryList[0], mentorQueryList[1]);
						mentorQuery.include('fields');
						for(var i = 2; i < mentorQueryList.length; i++) { // leave out first two
							var tempQuery = mentorQuery;
							var currentQuery = mentorQueryList[i];
							mentorQuery = Parse.Query.or(tempQuery, currentQuery);
						}
					} else {	// account for XXY cases, where there's only one combo => no need to OR
						mentorQuery = mentorQueryList[0];
					}
					promises.push(mentorQuery.find().then(function(results) {
						for(var i = 0; i < results.length; i++) {
							that.mentorList.push(results[i]);
						}
					}));
				}

				// use Parse Promises to sort fields when everything's done, then mount.
				Parse.Promise.when(promises).then(
					function() { // success case
					// use a comparator function to sort fields according to name
					that.fieldList.sort(function(field1,field2) {
						var firstFieldName = String(field1.attributes.name);
						var secondFieldName = String(field2.attributes.name);
						return firstFieldName.localeCompare(secondFieldName);
					});
					console.log(that.fieldList);
					console.log("mounting");
					// mount the results container, pass in the results
					riot.mount('results-container', {
						'selectedCategories' : selectedCategories,
						'fieldList' : that.fieldList,
						'mentorList' : that.mentorList,
					});
					$("#results").html('');
				},
				function(error) { // error case
					$("#results").html('<p class="error">There was an error retrieving results. Please try again.</p>');
				});

			}
		};
	</script>
</drag-space>

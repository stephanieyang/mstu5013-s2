<results-container>
 <div class="container" id="resultsContainer">
  <h2>Results</h2>
    <div class="row">
      <div class="col-md-12">
        <p>{ selections }</p>
        <!-- <h3>RESULTS TEST DISPLAY: <small show={visual}>no_results_yet</small></h3> -->
        <h3 show={ showResults }>You have selected interests in these fields:</h3>
        <ul>
          <li each={field in opts.fieldList }><a href="{field.attributes.links}">{field.attributes.name}</a></li>
        </ul>
        <h3 show={ showResults }>You may be interested in the following people:</h3>
        <ul>
          <li each={mentor in opts.mentorList }><a href="{mentor.attributes.links}">{mentor.attributes.name}</a></li> <! -- Buggy: links don't show (may need to change field) -->
        </ul>
        <!-- <h3>Some potential professions may include: {newProfessions}!</h3> -->
        <!-- ADD THIS IN -->

      </div>
    </div>
  </div>
  <style scoped>
  #resultsContainer {
    border-style: solid;
    border-width: 10px;
    border-color: #160D3A;
    background-color: white;
  }
  </style>
  <script>
  this.visual = true;
  this.showResults = false;

  this.newResults = this.opts.selectedCategories;
  this.newProfessions = this.opts.selectedCategories;

  this.on('update', function() {
    if(this.selections) {
      this.showResults = true;
    } else {
      this.showResults = false;
    }
  });


  //this.results = function() {}
  console.log(this);
  function formatSelection(selection) {
    if(!selection) return "";
    var resultText = "Your results are: ";
    var len = selection.length;
    for(var i = 0; i < len; i++) {
      resultText += selection[i];
      if(i < (len - 1)) {
        resultText += ", "
      }
    }
    resultText += "!";
    return resultText;
  }

  this.selections = formatSelection(this.opts.selectedCategories);



    // console.log('number of selected items:', this.targetItems.length);
    // console.log('items selected:', this.targetItems); // array of image information objects (storing filename, image ID, associated category) - see imageBank.js
    // if(this.targetItems.length === 3) {
    //   console.log('at correct capacity');
    //   //var itemIds = [];
    //   var selectedCategories = [];
    //   for(var i = 0; i < this.targetItems.length; i++) {
    //     selectedCategories.push(this.targetItems[i].category);
    //   }
    //   //alphabetically sorted each category in targetItems
    //   selectedCategories.sort();
    //   console.log(selectedCategories); // array of item categories - e.g., ['math','biology','chemistry']
    //
    //   // do stuff
    //
    //   var choice1 = selectedCategories[0];
    //   var choice2 = selectedCategories[1];
    //   var choice3 = selectedCategories[2];
    //
    //   console.log("PRE-sort: You may be interested in: ");
    //   console.log(choice1);
    //   console.log(choice2);
    //   console.log(choice3);
    //
    //   var combo1 = categoryBank[choice1][choice2];
    //   var combo2 = categoryBank[choice1][choice3];
    //   var combo3 = categoryBank[choice2][choice3];
    //   console.log(combo1, combo2, combo3);

    //return combo1;

      /*console.log(choice1);
      console.log(choice2);
      console.log(choice3);*/
  </script>
</results-container>

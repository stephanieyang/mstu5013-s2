<results-container>
 <div class="container" id="resultsContainer">
  <h2>Results</h2>
    <div class="row">
      <div class="col-md-12">
        <h3>You might like these professions:</h3>
        <button type="button" onclick={ testResults }>Test Results</button>
        <p>Testing!  Your results are: {results} !</p>
        <p>Testing#2!  Your results are: {opts.selectedCategories} !</p>
        <h3>RESULTS TEST DISPLAY: <small show={visual}>no_results_yet</small></h3>
        <h3>You have selected interests in these fields:</h3>
        <ul>
          <li each={field in opts.fieldList }><a href="{field.attributes.links}">{field.attributes.name}</a></li>
        </ul>
        <h3>You may be interested in the following people:</h3>
        <ul>
          <li each={mentor in opts.mentorList }><a href="{field.attributes.links[0]}">{mentor.attributes.name}</a></li> <! -- Buggy: links don't show (may need to change field) -->
        </ul>
        <h3>Some potential professions may include: {newProfessions}!</h3>
           <!--  <results-test-display></results-test-display>

            <div class="row">
              <div class="col-md-8">
        <h3>Career Options List</h3>
              </div>
              <div class="col-md-4">
        <h3>Mentor Profile</h3>
              </div>
            </div>
            <div class="row">
              <div class="col-md-12">
                <h3>Additional Info here</h3>
              </div>
            </div> -->
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

  this.newResults = this.opts.selectedCategories;
  this.newProfessions = this.opts.selectedCategories;

  this.results = "You like STEM!";
  // this.results2 = this.opts.selectedCategories[0];

  //this.results = function() {}

  this.testResults = function(){
    //need to hide the text UNTIL the "Get Results" button is pushed
    //may need to do this inside of
    alert("I was pushed!");
    console.log("should have printed combo1");
    console.log(this.opts.selectedCategories[0]);
    //I cannot access the variables from drag-sapce.tag.
    //Perhaps we need to declare these items at a higher level, or somehow
    //include this functionality in the same file without getting too messy
    //**The solution may be to use Mixin for Riot.js

    var testDisplayWord = "DisplayWord";
    //return testDisplayWord;




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

  }
      /*console.log(choice1);
      console.log(choice2);
      console.log(choice3);*/
  </script>
</results-container>

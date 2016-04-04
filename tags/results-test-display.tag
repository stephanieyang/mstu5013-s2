<results-test-display>
  <button type="button" onclick={ testResults }>Test Results</button>
  <p>Testing!  Your results are: {results} !</p>



<script>
  this.results = "You like STEM!";

  //this.results = function() {}

  this.testResults = function(){
    alert("I was pushed!");
    console.log("should have printed combo1");
    console.log(this.opts.selectedCategories[0]);
    //I cannot access the variables from drag-sapce.tag.
    //Perhaps we need to declare these items at a higher level, or somehow
    //include this functionality in the same file without getting too messy
    //**The solution may be to use Mixin for Riot.js




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

    var testDisplayWord = "DisplayWord";
    //return testDisplayWord;

  }



</script>

</results-test-display>

<results-container>
 <div class="container" id="resultsContainer">
  <h2>Results</h2>
    <div id="loading"></div>
    <div class="row">
      <div class="col-sm-12 col-md-12 col-lg-12">
        <!-- 
        <p>{ selections }</p>
        <h3>RESULTS TEST DISPLAY: <small show={visual}>no_results_yet</small></h3> 
        <h3 show={ showResults }>You have selected interests in these fields:</h3>
        -->
        <!--
        <div class="col-md-6 col-lg-4 col-sm-12 mentor-profile">
          <div class="mentor-pic">
            <img src="http://placehold.it/300x300" alt="mentor name goes here">
          </div>
          <div class="bio">
            <h3>Mentor Name</h3>
            <p><strong>Fields:</strong> <a href="#">foo</a>, <a href="#">bar</a></p>
            <p class="foo">Lorem ipsum dolor sit amet, consectetur adipisicing elit. Nesciunt, praesentium assumenda id mollitia. A cumque consequuntur molestiae cupiditate vitae praesentium quasi consequatur ea recusandae voluptatum doloribus molestias, temporibus eaque, nam possimus. Quo ratione sapiente officia in, pariatur reprehenderit eveniet et aliquam incidunt perferendis nobis dolorem illum itaque modi, ullam praesentium!</p>
            <strong><a href="#">More Information</a></strong>
          </div>
        </div>
        <div class="col-md-6 col-lg-4 col-sm-12 mentor-profile">
          <div class="mentor-pic">
            <img src="http://placehold.it/300x300" alt="mentor name goes here">
          </div>
          <div class="bio">
            <h3>Mentor Name</h3>
            <p><strong>Fields:</strong> <a href="#">foo</a>, <a href="#">bar</a></p>
            <p class="foo">Lorem ipsum dolor sit amet, consectetur adipisicing elit. Nesciunt, praesentium assumenda id mollitia. A cumque consequuntur molestiae cupiditate vitae praesentium quasi consequatur ea recusandae voluptatum doloribus molestias, temporibus eaque, nam possimus. Quo ratione sapiente officia in, pariatur reprehenderit eveniet et aliquam incidunt perferendis nobis dolorem illum itaque modi, ullam praesentium!</p>
            <strong><a href="#">More Information</a></strong>
          </div>
        </div>
        <div class="col-md-6 col-lg-4 col-sm-12 mentor-profile">
          <div class="mentor-pic">
            <img src="http://placehold.it/300x300" alt="mentor name goes here">
          </div>
          <div class="bio">
            <h3>Mentor Name</h3>
            <p><strong>Fields:</strong> <a href="#">foo</a>, <a href="#">bar</a></p>
            <p class="foo">Lorem ipsum dolor sit amet, consectetur adipisicing elit. Nesciunt, praesentium assumenda id mollitia. A cumque consequuntur molestiae cupiditate vitae praesentium quasi consequatur ea recusandae voluptatum doloribus molestias, temporibus eaque, nam possimus. Quo ratione sapiente officia in, pariatur reprehenderit eveniet et aliquam incidunt perferendis nobis dolorem illum itaque modi, ullam praesentium!</p>
            <strong><a href="#">More Information</a></strong>
          </div>
        </div>
        -->
        <!-- -->

        <div class="col-sm-12 col-md-6 col-lg-4 mentor-profile" each={mentor in opts.mentorList }>
          <div class="mentor-pic">
            <img src="{ mentor.attributes.img }" alt="{ mentor.attributes.name }">
          </div>
          <div class="bio">
            <h3>{ mentor.attributes.name }</h3>
            <p><strong>Fields:</strong> <span></span> { mentor.attributes.fields }
            <p>{ mentor.attributes.bio }</p>
            <strong><a href="{ mentor.attributes.link }" target="_blank">More Information</a></strong>
          </div>
        </div>
        <div class="col-sm-12 col-md-12 col-lg-12 mentor-profile" id="other-fields" show={ showResults }>
          <p>You may also be interested in:</p>
          <ul>
            <li each={ field in this.miscFields }>{ field }</li>
          </ul>
        </div>
        <!--
        <ul>
          <li each={field in opts.fieldList }><a href="{field.attributes.links}">{field.attributes.name}</a></li>
        </ul>
        <h3 show={ showResults }>You may be interested in the following people:</h3>
        <ul>
          <li each={mentor in opts.mentorList }><a href="{mentor.attributes.links}">{mentor.attributes.name}</a></li>
        </ul>
          -->
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

  .mentor-profile {
    margin-bottom: 60px;
    /*
    max-width: 500px;
    overflow: auto;
    */
  }

  .mentor-profile p {
    font-size:1em;
    word-wrap: break-word;

  }

  .mentor-profile h3 {
    text-align: center;
  }

  .mentor-profile img {
    display: block;
    margin:auto;
    width:300px;
  }
  </style>
  <script>
  this.visual = true;
  this.showResults = false;

  this.newResults = this.opts.selectedCategories;
  this.newProfessions = this.opts.selectedCategories;

  this.miscFields = [];
  this.handledMiscFields = false;

  this.on('update', function() {
    console.log('update');
    if(this.selections) {
      this.showResults = true;
      if(!this.handledMiscFields) {
        this.findMiscFields();
        this.handledMiscFields = true;
      }
    } else {
      this.showResults = false;
    }

  });
  this.findMiscFields = function() {
    var foundFields = [];
    var allFields = [];
    var miscFields = [];
    var fieldList = this.opts.fieldList;
    var mentorList = this.opts.mentorList;

    console.log("findMiscFields", fieldList);
    for(var i = 0; i < fieldList.length; i++) {
      var field = fieldList[i];
      allFields.push(field.attributes.name);
    }
    console.log(allFields);

    for(var i = 0; i < mentorList.length; i++) {
      var mentorFieldList = mentorList[i].attributes.fields;
      for(var j = 0; j < mentorFieldList.length; j++) {
        foundFields.push(mentorFieldList[j]);
      }
    }
    console.log(foundFields);

    for(var i = 0; i < allFields.length; i++) {
      var currentField = allFields[i];
      if(foundFields.indexOf(currentField) == -1) { // current field not among mentor fields
        miscFields.push(currentField);
      }
    }
    this.miscFields = miscFields;

    console.log("mentorList",this.opts.mentorList);
  }


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
  </script>
</results-container>

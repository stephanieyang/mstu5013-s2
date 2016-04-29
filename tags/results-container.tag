<results-container>
 <div class="container" id="resultsContainer">
  <h2>Results</h2>
    <div id="loading"></div>
    <div class="row">
      <div class="col-sm-12 col-md-12 col-lg-12">

        <mentor each={mentor in opts.mentorList }></mentor>
        <div class="col-sm-12 col-md-12 col-lg-12" id="other-fields" show={ showResults }>
          <h3>You may also be interested in:</h3>
            <field each={ field in opts.fieldList }></field>
        </div>

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
    float: left;
    overflow: hidden;
    height: 650px;
  }

  .mentor-profile p, .field-profile p {
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
  this.showResults = false;


  this.on('update', function() {
    console.log('update');
    if(this.selections) {
      this.showResults = true;
    } else {
      this.showResults = false;
    }
    console.log("fieldList",this.opts.fieldList);
  });

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
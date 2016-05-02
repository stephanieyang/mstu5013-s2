<mentor>
    <div class="col-sm-12 col-md-6 col-lg-4 mentor-profile">
      <div class="mentor-pic">
        <img src="{ mentor.attributes.img }" alt="{ mentor.attributes.name }">
      </div>
      <div class="bio">
        <h3>{ mentor.attributes.name }</h3>
        <p><strong>Fields:</strong> <span each={ field in mentor.attributes.fieldList }>{ field } </span><br />
        <a href="#other-fields">See more about these fields...</a></p>
        <p>{ mentor.attributes.bio }</p>
        <strong><a href="{ mentor.attributes.link }" target="_blank">More information about this STEMinist</a></strong>
      </div>
    </div>
  <style scoped>
  .mentor-profile {
    margin-bottom: 60px;
    float: left;
    overflow: hidden;
    height: 650px;
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
  </script>
</mentor>
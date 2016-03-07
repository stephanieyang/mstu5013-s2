<pic-bank>
  <div class="container" id="picBank">
    <pic each={ image in imageList }></pic>
  </div>
  <script>
    console.log(imageList);
  </script>
  <style scoped>
  #picBank {
  background-color: green;
  }
  </style>
</pic-bank>
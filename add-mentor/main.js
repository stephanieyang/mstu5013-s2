Parse.initialize("ht7qoh6W5yWn40vtsfgg4MEwUlJIjT5FE3DXv4kS", "HkVOhigdEMOOFxbyCw3oqF7RqGYJdop0baPN5FbG");

$(document).ready(function() {
	$('#add-mentor').click(function() {
		$("#results").html('<p>Waiting...</p>');
		//console.log('click');
		var name = $('#mentor-name').val();
		var bio = $('#mentor-bio').val();
		var categories = $('#mentor-categories').val().split(','); // array of strings
		var fields = $('#mentor-fields').val().split(','); // array of strings
		var img = $('#mentor-img').val();
		var link = $('#mentor-link').val();
		//console.log(name,bio,fields,img,links);

		var Mentor = Parse.Object.extend('Mentor');
		var newMentor = new Mentor();
		
		newMentor.set('name',name);
		newMentor.set('bio',bio);
		newMentor.set('categories',categories);
		newMentor.set('fieldList',fields);
		newMentor.set('link',link);
		newMentor.set('img',img);

   		newMentor.save({
			success: function(result) {
				$("#results").html('<p class="success">The result was saved.</p>');

			}, error: function(error){
				$("#results").html('<p class="error">Error: ' + error.message + '.</p>');
			}

		});




	});
});
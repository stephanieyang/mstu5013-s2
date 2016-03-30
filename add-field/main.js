Parse.initialize("ht7qoh6W5yWn40vtsfgg4MEwUlJIjT5FE3DXv4kS", "HkVOhigdEMOOFxbyCw3oqF7RqGYJdop0baPN5FbG");

$(document).ready(function() {
	$('#add-field').click(function() {
		//console.log('click');
		var name = $('#field-name').val();
		var desc = $('#field-desc').val();
		var alts = $('#field-alts').val().split(','); // array of strings
		var categories = $('#field-categories').val().split(',');
		var links = $('#field-links').val();
		//console.log(name,desc,alts,categories,links);
		
		var Field = Parse.Object.extend('Field');
		var newField = new Field();
		newField.set('name',name);
		newField.set('desc',desc);
		newField.set('alts',alts);
		newField.set('links',links);
		newField.set('categories',categories);

   		newField.save({
			success: function(result) {
				console.log("SAVED!");

			}, error: function(error){
				alert("Error " + error.message);
			}

		});
	});
});
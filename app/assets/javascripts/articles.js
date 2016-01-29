// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

/* PURPOSE:
 *
 * To handle the Modal rendering for all ArticleQuestions & ArticleRevisions
 *
*/

$(document).ready(function() {
	// Handle Success Whenever a Link of this Class is Clicked
	$('a.remote-to-modal').on("ajax:success", function(e, data, status, xhr) {
		$("#article-modal").show();
		$('#article-modal-content').html(data);
	});


	// Close the Window
	$('#article-modal .close').on('click', function() {
		$("#article-modal").hide();
	});
});

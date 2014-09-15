// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require jquery-ui
//= require bootstrap.min
//= require jquery.bxslider
//= require jquery.fitvids
//= require jquery.sequence-min
//= require modernizr.min
//= require stripe_v2
//= require script
//= require orders
//= require dropit
//= require turbolinks
//= require_tree .

function check_login (total_url, host) {
	var last_url = total_url.replace(host, "").replace("http://", "");

	// alert(total_url.replace(host, "").replace("http://", ""));

	$.ajax({
		    type: "GET",
		    url: '/home/login_last_url',
		    dataType: "JSON",
		    data: {"last_url": last_url}
		  });
}


function assign_dropit () {
  $('.menu').dropit();
}

// $(function() {
//     var availableTags = <%=raw @pro %>;
//     $( "#search_data" ).autocomplete({
//     source: availableTags
//     });
// });
function autocomplete_data (data) {
	var availableTags = data;
    $( "#search_data" ).autocomplete({
    source: availableTags
    });
}
// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//

//= require jquery_ujs
//= require jquery.qtip.js
//= require slick
//= require private_pub
//= require turbolinks
//= require cocoon
//= require categories
//= require messages.js
//= require notifications.js
//= require admin/js/plugins/toastr/toastr.min.js
//= require_self


$(document).ready(function() {
 toastr.options = {
   "closeButton": false,
   "debug": false,
   "newestOnTop": false,
   "progressBar": false,
   "positionClass": "toast-top-right",
   "preventDuplicates": false,
   "onclick": null,
   "showDuration": "300",
   "hideDuration": "1000",
   "timeOut": "5000",
   "extendedTimeOut": "1000",
   "showEasing": "swing",
   "hideEasing": "linear",
   "showMethod": "fadeIn",
   "hideMethod": "fadeOut"
              }
});


window.PA = (function(PA) {
  PA.Calendars = {
    init: function(add_url, update_url, events_data, options = {}){
      var extra_hash = {};
      var hours_hash = ((options["business_hours"] != undefined) ?
        {businessHours: options["business_hours"],selectConstraint: 'businessHours'} :
        {});
        var event_render_hash = ((options["append_close"] != undefined) ?
          {eventRender: function(event, element, view) {
                element.find(".fc-time")
                    .append("<a class='float-right' data-confirm='Are you sure?' data-remote='true' data-method='delete' href='/partner/companies/destroy_hours/"+event.title+"'><i class='fa fa-remove'></i></a>:");
          }} :
          {});
        if (options["business_hours"]!= undefined) {
          extra_hash = hours_hash;
        }else if(options["append_close"]!= undefined){
          extra_hash = event_render_hash;
        }
      $('#calendar').fullCalendar($.extend({
        header: {
            left: options["is_staff"] == true ? 'today prev,next' : '',
            center: '',
            right: '',
        },
        firstDay: 0,
        editable: true,
        selectable: true,
        defaultView: 'agendaWeek',
        eventConstraint: 'businessHours',
        eventOverlap: false,
        // columnFormat: 'dddd',
        events: events_data,
        viewRender: function(currentView){
      		var minDate = moment(),
      		maxDate = moment().add(27,'weeks');
      		// Past
      		if (minDate >= currentView.start && minDate <= currentView.end) {
      			$(".fc-prev-button").prop('disabled', true);
      			$(".fc-prev-button").addClass('fc-state-disabled');
      		}
      		else {
      			$(".fc-prev-button").removeClass('fc-state-disabled');
      			$(".fc-prev-button").prop('disabled', false);
      		}
      		// Future
      		if (maxDate >= currentView.start && maxDate <= currentView.end) {
      			$(".fc-next-button").prop('disabled', true);
      			$(".fc-next-button").addClass('fc-state-disabled');
      		} else {
      			$(".fc-next-button").removeClass('fc-state-disabled');
      			$(".fc-next-button").prop('disabled', false);
      		}
      	},
        eventRender: function(event, element, view) {
          console.log("mmm",event.staff_count)
          if (event.staff_count != undefined){
            element.find('.fc-title').append("<br/>Staff Count: " + event.staff_count);
          }
        },
        eventClick:  function(event, jsEvent, view) {
          if (event.staff_count == undefined){
            $('#fullCalModal #st').val(event.start._i);
            $('#fullCalModal #et').val(event.end._i);
            $('#fullCalModal').modal();
            // alert(event.start_time);
            console.log(event.end._i);
            console.log(event.start._i);
          }
        },
        select: function(start, end, allDay) {
          var formatStart = start.format('HH:mm:ss'); //Date.parse(start) / 1000;
          var formatEnd = end.format('HH:mm:ss'); //Date.parse(end) / 1000;
          var day = start.format('dddd');
          if (options["is_staff"] == true){
            var working_date = start.format("YYYY/MM/DD");
            $.ajax({url: add_url, type: "POST", data: {start: formatStart, end: formatEnd, week_day: day, working_date: working_date}});
          }else{
            $.ajax({url: add_url, type: "POST", data: {start: formatStart, end: formatEnd, week_day: day}});
          }
        },
        eventResize: function(event, delta, revertFunc) {
          $.ajax({url: update_url, type: "patch", data: {id: event.title,end: event.end.format('HH:mm:ss')}});
        },
        eventDrop: function( event, delta, revertFunc, jsEvent, ui, view ) {
          $.ajax({url: update_url, type: "patch", data: {id: event.title, week_day: event.start.format('dddd'), start: event.start.format('HH:mm:ss') ,end: event.end.format('HH:mm:ss')}});
        }
      },extra_hash));
    }
  };
  return PA;
})(window.PA || {});

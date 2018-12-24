$("#tour-list").replaceWith("<%= escape_javascript(render(:partial => 'passengers/tour_lists', locals: {tour: @tour})) %>");
$("#passenger-form").replaceWith("<%= escape_javascript(render(:partial => 'passengers/form', locals: {passenger: Passenger.new, tour: @tour})) %>");

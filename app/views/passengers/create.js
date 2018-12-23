$("#tour-list").replaceWith("<%= escape_javascript(render(:partial => 'passengers/tour_lists', locals: {tour: @tour})) %>");

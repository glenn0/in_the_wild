$ ->
  $('#project_scopes a').click = (e) ->
    e.preventDefault() 
    $(this).tab('show')
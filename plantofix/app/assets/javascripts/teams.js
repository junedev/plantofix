$( function(){
  $(".add_team_button").on("click", function(){
    $(this).hide();
    $(this).siblings('.add_team_form').show();
  });
});

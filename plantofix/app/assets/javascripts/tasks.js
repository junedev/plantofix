$( function(){
  $(".task_edit").on("click", function(){
    $(this).hide()
    $(this).siblings(".task_item").hide()
    $(this).siblings("form").css("display","")
  });


});
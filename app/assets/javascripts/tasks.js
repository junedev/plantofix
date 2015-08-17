$( function(){

  $(".task_edit").on("click", function(){
    $(this).parent().siblings(".task_edit_box").show();
    $(this).closest('.task_item').hide();
  });

  $(".sortable").sortable({
    connectWith: ".sortable",
    // helper: "clone",
    stop: function(event, ui){
      var class_names = ui.item.parent().attr("class").split(/\s+/);
      ui.item.find(".list_id_input").val(find_list_id(class_names));
      var new_pos = new_position(ui.item);
      ui.item.find(".task_position_input").val(new_pos);
      ui.item.find(".submit_edit").click();
    }
  });

  $('.task_description_modal').on('shown.bs.modal', function () {
  });

  // var pop_content = "<button class='btn color-btn first-color'></button>"
  // var pop_content_1 = "<button class='btn color-btn' style='background-color: "
  // var pop_content_2 = "'></button>";
  // var task_colors = ['#A59E72', '#F7D488', '#FF9B71', '#E26D5A']
  // for(var i=0; i<task_colors.length; i++){
  //   pop_content += pop_content_1 + task_colors[i] + pop_content_2;
  // };
  
  // $('[data-toggle="popover"]').popover({
  //   html: true,
  //   content: pop_content,
  //   container: "body"
  // });

  // $("body").on("click",".color-btn",function(){
  //   var color = $(this).css("backgroundColor");
  // });

  $('.colorp').colorpicker({color: "#ffffff"}).on('changeColor', function(ev) {
    $(this).siblings(".task_item").css("background-color", ev.color.toHex())
  });

  $('.colorp').colorpicker().on('hidePicker', function(ev) {
    $(this).siblings(".task_edit_box").find(".new_color").val(ev.color.toHex())
    $(this).siblings(".task_edit_box").find(".submit_edit").click();
  });

});

function find_list_id(array){
  for(var i=0; i<array.length; i++){
    if(array[i].substring(0,5)==="_list"){
      return array[i].substring(5,array[i].length);
    };
  };
}

function new_position($item){
  var pos1 = 0;
  var pos2 = 0;
  if($item.prev().length > 0){
    pos1=parseFloat($item.prev().find(".task_position_input").val());
  }
  if($item.next().length > 0){
    pos2=parseFloat($item.next().find(".task_position_input").val());
  }

  var current_pos = parseFloat($item.find(".task_position_input").val());

  if(pos1+pos2 === 0){
    return current_pos;
  } else if(pos1 === 0){
    return pos2/2;
  } else if(pos2 === 0) {
    return (pos1 + 1.0);
  } else {
    return (parseFloat(pos1) + parseFloat(pos2))/2;
  }
}


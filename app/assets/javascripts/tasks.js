$( function(){

  $("body").on("click",".task_edit", function(){
    $(this).parent().siblings(".task_edit_box").show();
    $(this).closest('.task_item').hide();
  });

  $(".sortable").sortable({
    connectWith: ".sortable",
    stop: function(event, ui){
      var updateData = {
        task: {
          list_id: ui.item.parent().data().id,
          position: new_position(ui.item)
        }
      }
      $.ajax({
        url:'/tasks/'+ui.item.data().id,
        type:'put',
        dataType: 'json',
        contentType: 'application/json',
        data: JSON.stringify(updateData)
      })
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
    $(this).siblings(".task_edit_box").find(".new_color").val(ev.color.toHex());
    var updateData = { task: { color: ev.color.toHex() }};
    $.ajax({
      url:'http://localhost:3000/tasks/'+$(this).closest("li").data().id,
      type:'put',
      dataType: 'json',
      contentType: 'application/json',
      data: JSON.stringify(updateData)
    })
  });

  $("body").on("click",".task_delete", function(){
    var that = this;
    event.preventDefault();
    $.ajax({
      url:'/tasks/'+$(this).data().id,
      type:'delete'
    }).done(function(){
      $(that).closest("li").remove();   
    });
  });

  $("body").on("submit", "form.new_task_item",function(){
    var that = this;
    event.preventDefault();
    $.ajax({
      url: "/tasks",
      type: "post",
      dataType: 'html',
      data: $(this).serialize()
    }).done(function(result){
      console.log("done reached");
      $(that).siblings("ul").append(result);
      $(that).find("input[name='task[name]']").val(null);
    });
  });

  $("body").on("submit","form.task_edit_box",function(){
    var that = this;
    event.preventDefault();
    $.ajax({
      url: $(this).attr("action"),
      type: $(this).attr("method"),
      dataType: 'json',
      data: $(this).serialize()
    }).done(function(result){
    $(that).hide();
    $(that).siblings('.task_item').children("p").html(result.name);
    $(that).siblings('.task_item').show();
    });
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
    pos1=parseFloat($item.prev().data().state);
  }
  if($item.next().length > 0){
    pos2=parseFloat($item.next().data().state);
  }

  var current_pos = parseFloat($item.data().state);

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



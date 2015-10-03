$( function(){

  var domain = location.protocol+"//"+window.location.host;

  $("body").on("click",".task_edit", function(){
    $(this).parent().siblings(".task_edit_box").show();
    $(this).closest('.task_item').hide();
  });

  $(".sortable").sortable({
    connectWith: ".sortable",
    stop: updatePosition
  });

  function updatePosition(event, ui){
    var updateData = { 
      task: {
        list_id: ui.item.parent().data().id,
        position: new_position(ui.item)
      }
    }

    $.ajax({
      url: domain+'/tasks/'+ui.item.data().id,
      type:'put',
      dataType: 'json',
      contentType: 'application/json',
      data: JSON.stringify(updateData)
    })
  }

  $('.task_description_modal').on('shown.bs.modal', function () {
  });

  var pop_content = "<button class='btn color-btn first-color'></button><br>"
  var pop_content_1 = "<button class='btn color-btn' style='background-color: "
  var pop_content_2 = "'></button><br>";
  var task_colors = ['#72B587', '#FCE170', '#FFBC64', '#C66363']
  for(var i=0; i<task_colors.length; i++){
    pop_content += pop_content_1 + task_colors[i] + pop_content_2;
  };
  
 $("body").popover({
    selector: "[data-toggle='popover']",
    html: true,
    content: pop_content,
    container: "body",
    trigger: "focus"
  });

  $("body").on("show.bs.popover", "[data-toggle='popover']", function(){
    var currentBox = $(this).siblings(".task_item");
    var task_id = $(this).closest("li").data().id;
    $("body").on("click",".color-btn",function(){
      var color = $(this).css("backgroundColor");
      currentBox.css("backgroundColor", color);
      currentBox.siblings().children(".task_item").css("backgroundColor", color);
      $.ajax({
        url: domain + '/tasks/' + task_id,
        type:'put',
        dataType: 'json',
        contentType: 'application/json',
        data: JSON.stringify({task: { color: color}})
      })
      $("body").off("click",".color-btn");
    });
  });


$("body").on("click",".task_delete", function(){
  var self = this;
  event.preventDefault();
  $.ajax({
    url: domain +'/tasks/'+$(this).data().id,
    type:'delete'
  }).done(function(){
    $(self).closest("li").remove();   
  });
});

$("body").on("submit", ".new_task_item",function(){
  var self = this;
  if($(this).siblings("ul").children("li").length){
    var pre = parseInt($(this).siblings("ul").children("li").last().data().position);
    $(this).find("input[name='task[position]']").val(pre+1);
  }
  event.preventDefault();
  $.ajax({
    url: domain + "/tasks",
    type:"post",
    dataType: 'html',
    data: $(this).serialize()
  }).done(function(result){
    $(self).siblings("ul").append(result);
    $(self).find("input[name='task[name]']").val(null);
  });
});

$("body").on("submit","form.task_edit_box",function(){
  var self = this;
  event.preventDefault();
  $.ajax({
    url: domain + $(this).attr("action"),
    type: $(this).attr("method"),
    dataType: 'json',
    data: $(this).serialize()
  }).done(function(result){
    $(self).hide();
    $(self).siblings('.task_item').children("p").html(result.name);
    $(self).siblings('.task_item').show();
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
  var pre = 0;
  var succ = 0;
  var current_pos = parseFloat($item.data().position);

  if($item.prev().length){
    pre=parseFloat($item.prev().data().position);
  }
  if($item.next().length){
    succ=parseFloat($item.next().data().position);
  }

  if(pre+succ === 0) return current_pos;
  if(pre === 0) return succ/2;
  if(succ === 0) return (pre + 1.0);
  return (parseFloat(pre) + parseFloat(succ))/2;
}


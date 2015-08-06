$( function(){

  $(".task_edit").on("click", function(){
    $(this).parent().siblings(".task_edit_box").show();
    $(this).closest('.task_item').hide();
  });

  $(".sortable").sortable({
    connectWith: ".sortable",
    receive: function(event, ui){
      //only triggered when list has changed
      var class_names = this.className.split(/\s+/);
      ui.item.find(".list_id_input").val(find_list_id(class_names));
    },
    update: function(event, ui){
        var new_pos = new_position(ui.item.next()[0],ui.item.prev()[0])
        ui.item.find(".task_position_input").val(new_pos);
        ui.item.find(".submit_edit").click();
     }
   });
});

function find_list_id(array){
  for(var i=0; i<array.length; i++){
    if(array[i].substring(0,5)==="_list"){
      var h = array[i].substring(5,array[i].length);
      return h;
    };
  };
}

function new_position(node1, node2){
  console.log(node1);
  console.log(node2);
  var pos1 = $(node1).find(".task_position_input").val()
  var pos2 = $(node2).find(".task_position_input").val()
  console.log(pos1);
  console.log(pos2);
  return (parseFloat(pos1) + parseFloat(pos2))/2
}

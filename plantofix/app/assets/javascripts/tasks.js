$( function(){

  $(".task_edit").on("click", function(){
    event.stopPropagation();
    $(this).closest('.task_item_box').siblings('.task_edit_box').show();
    $(this).closest('.task_item_box').hide();
  });

  $(".sortable").sortable({
    connectWith: ".sortable",
    receive: function(event, ui){
      //only triggered when list has changed
      var class_names = this.className.split(/\s+/);
      ui.item.find(".list_id_input").val(find_list_id(class_names));
      
    },
    update: function(event, ui){
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

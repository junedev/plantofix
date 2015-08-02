$( function(){

  $(".task_edit").on("click", function(){
    event.stopPropagation();
    $(this).closest('.task_item_box').siblings('.task_edit_box').show();
    $(this).closest('.task_item_box').hide();
  });
  $(".sortable").sortable({connectWith: ".sortable"});
});

// function allowDrop(ev) {
//   ev.preventDefault();
// }

// function drag(ev) {
//   ev.dataTransfer.setData("text", ev.target.id);
// }

// function drop(ev) {
//   ev.preventDefault();
//   var data = ev.dataTransfer.getData("text");
//   ev.target.appendChild(document.getElementById(data));
// }
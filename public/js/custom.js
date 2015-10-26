function buttonHover(elem) {
  var that = $(elem);

  $(that).toggleClass("btn-primary");
  $(that).toggleClass("btn-danger");

  var textToSet = that.data("textToggle");
  that.data("textToggle", that.text());
  that.text(textToSet);
}

$("#follow_unfollow")
  .data("textToggle", "Unfollow")
  .hover(function() {
    buttonHover(this);
  }, function() {
    buttonHover(this);
  });

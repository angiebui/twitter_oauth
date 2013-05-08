function checkStatus(jobId){
  $.ajax({
    url: ('/status/' + jobId),
    data: jobId
  }).done(function(status){
    if(status === "Posted!")
      $(".container").append(status + " " + ((new Date()).getTime() / 1000) + " seconds since 1970");
    else
      setTimeout(checkStatus(jobId),4000);
  }).fail(function(){
      $(".container").append("can't post your tweet for whatever reason");
  });
}

$(document).ready(function() {

  $('.tweettext').on('submit', function(e) {
    e.preventDefault();
    $.ajax({
      url: "/tweet",
      data: $(this).serialize(),
      type: "post"
    }).done(function(jobId){
      checkStatus(jobId);
    });
  });
});


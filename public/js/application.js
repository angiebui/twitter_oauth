function checkStatus(jobId){
  $.ajax({
    url: ('/status/' + jobId),
    data: jobId
  }).done(function(status){
    if(status === "Posted!")
      $(.container).append(status);
    else
      setTimeout(checkStatus(jobId),4000);
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


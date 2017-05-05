
var  permission ='';


$(document).ready(function() {
 // executes when HTML-Document is loaded and DOM is ready
    var cookieValue = $.cookie("username");

    console.log(cookieValue);
});


function login_post(val) {
    if(val == 'sign_in') {
        var inputUname = document.getElementById('inputUname').value;
        var inputPassword = document.getElementById('inputPassword').value;
        var objectData = JSON.stringify({
            'inputUsername': inputUname,
            'inputPassword': inputPassword
        });

        console.log(objectData);
        $.ajax({
            type: 'POST',
            url: '/api_login/',
            data: objectData,
            contentType: "application/json charset=utf-8",
            traditional: true,
            dataType: "json",
            success: function (data) {
                console.log(data);
                $.cookie("username", data.username);

                window.location.href = "http://127.0.0.1:5000/dashboard";
            },
            error: function (error) {
                console.log(error);
                 $('#errormsg').html('Invalid Credentials!');
              }
        });
    }
}

function fx(o) {
  var $o = $(o);

  $o.html($o.text().replace(/([\S])/g, "<span>$1</span>"));
  $o.css("position", "relative");
  $("span", $o).each(function(i) {
    var newTop = Math.floor(Math.random()*500)*((i%2)?1:-1);
    var newLeft = Math.floor(Math.random()*500)*((i%2)?1:-1);

    $(this).css({position: "relative",
      opacity: 1,
      fontSize: 30,
      top: 0,
      left: 0
    }).animate({
      opacity: 0,
      fontSize: 200,
      top: newTop,
      left:newLeft
    },1000);
  });
}





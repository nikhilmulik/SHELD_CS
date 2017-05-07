
var  permission ='';

function createCookie(name,value,days) {
	if (days) {
		var date = new Date();
		date.setTime(date.getTime()+(days*24*60*60*1000));
		var expires = "; expires="+date.toGMTString();
	}
	else var expires = "";
	document.cookie = name+"="+value+expires+"; path=/ ; domain=;" ;
}

function readCookie(name) {
	var nameEQ = name + "=";
	var ca = document.cookie.split(';');
	for(var i=0;i < ca.length;i++) {
		var c = ca[i];
		while (c.charAt(0)==' ') c = c.substring(1,c.length);
		if (c.indexOf(nameEQ) == 0) return c.substring(nameEQ.length,c.length);
	}
	return null;
}


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
                //create cookie
                createCookie('username',data.username,10);

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





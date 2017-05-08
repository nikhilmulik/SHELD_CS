
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
function signup()
{
    window.location.href = "http://localhost:5000/sign";
}
function signup_post(val){
    if(val == 'sign_up') {
        var inputUname = document.getElementById('inputUname').value;
        var inputEmail = document.getElementById('inputEmail').value;
        console.log(inputEmail);
        var inputPassword = document.getElementById('inputPassword').value;
        var objectData = JSON.stringify({
            'inputUsername': inputUname,
            'inputEmail': inputEmail,
            'inputPassword': inputPassword
        });

        console.log(objectData);
        $.ajax({
            type: 'POST',
            url: '/api_signup/',
            data: objectData,
            contentType: "application/json charset=utf-8",
            traditional: true,
            dataType: "json",
            success: function (data) {
                console.log(data);
                window.location.href = "http://localhost:5000/login";
            },
            error: function (error) {
                console.log("HERE ERROR: " + error);
                 $('#errormsg').html('Username already exist!');
              }
        });
    }

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
                createCookie('u_id',data.u_id,10);
                window.location.href = "http://localhost:5000/dashboard";
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





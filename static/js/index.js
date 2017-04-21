
var  permission ='';

function login_post(val) {
    if(val == 'sign_in') {
        var inputUname = document.getElementById('inputUname').value;
        var inputPassword = document.getElementById('inputPassword').value;
        var objectData = JSON.stringify(
            {'inputUsername': inputUname, 'inputPassword': inputPassword})
            ;
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
            },
            error: function (error) {
                console.log(error);
            }
        });
    }
}




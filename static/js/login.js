

var  permission ='';

function login_post(val) {
    if(val == 'sign_in') {
        inputEmail = document.getElementById('inputEmail').value;
        inputPassword = document.getElementById('inputPassword').value;
        console.log(inputEmail, inputPassword);
        $.ajax({
            type: 'GET',
            url: '/login_check/',
            data: {'inputEmail': inputEmail, 'inputPassword': inputPassword},
            dataType: "json",
            success: function (data) {
                // console.log(data);
                window.location.href = "http://127.0.0.1:5000/";
                sessionStorage.setItem('permission', data['permission']);
                sessionStorage.setItem('user_name', data['db_result'][0] + ' ' + data['db_result'][1]);
            },
            error: function (error) {
                console.log(error);
            }
        });
    }else if (val == 'continue'){
        sessionStorage.clear();
        window.location.href = "http://127.0.0.1:5000/";
        sessionStorage.setItem('permission', 'view');
    }
}






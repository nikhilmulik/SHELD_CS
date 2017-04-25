function getProfile() {

        $.ajax({
            type: 'GET',
            url: '/get_profile/',
            data: objectData,
            contentType: "application/json charset=utf-8",
            traditional: true,
            dataType: "json",
            success: function (data) {
                alert(data);
               // window.location.href = "http://127.0.0.1:5000/dashboard";
            },
            error: function (error) {
                console.log(error);
//                 $('#errormsg').html('Invalid Credentials!');
              }
        });

}

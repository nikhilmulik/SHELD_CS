
// $(function(){
// 	$('div[onload]').trigger('onload');
// });
function showDiv(){

}

function millisToMinutesAndSeconds(millis) {
  var minutes = Math.floor(millis / 60000);
  var seconds = ((millis % 60000) / 1000).toFixed(0);
  return minutes + ":" + (seconds < 10 ? '0' : '') + seconds;
}



function searchAlbums() {

    // $('#submit').click(function() {
        searchMusic = document.getElementById('searchMusic').value;

        $.ajax({
            type: "GET",
            url: '/api_search',
            // data: $('form').serialize(),

            data : {'table':'album','searchName': searchMusic},

            dataType: "json",
            success: function (data) {
                // console.log('AJAX POST REQUEST.......!', data)
// <span id="albumResult">Album: </span>

                if (data.artist) {
                    // document.getElementById('artistResult').innerHTML = data.artist[1]
                    document.getElementById('artistResult').innerHTML = (
                        '<a href="../artist/'+data.artist[1]+'">Artist: <span>'+data.artist[1]+'</span></a>')
                }

                if (data.album){
                    document.getElementById('albumResult').innerHTML = ('<h3>Albums:</h3>')
                for (var i = 0; i < data.album.length; i++) {
                    document.getElementById('albumResult').innerHTML += (
                    '<p ' +
                    '<span >'+ data.album[i][1] +'</span>' +
                    '</p>')
                    console.log(data.album[i][1])
                    }
                    document.getElementById('albumResult').innerHTML += ('<hr>')
                }


                document.getElementById('trackList').innerHTML = (
                        '<li class="list-group-item active">' +
                        '<span class="col-md-4">Tracks</span>' +
                        '<span class="col-md-2">Time</span>' +
                        '<span class="col-md-3">Composer</span>' +
                        '<span class="col-md-1">Price</span>' +
                        '<span class="col-md-2">Add to Cart</span>' +
                        '</li>')
// should display null values with 'Null'
                for (var i = 0; i < data.track.length; i++) {
                    // console.log('>>>>>> ', data.track[i])
                    document.getElementById('trackList').innerHTML += (
                    '<li class="list-group-item">' +
                    '<span class="col-md-4 overme" title="'+data.track[i][1]+'">'+ data.track[i][1] +'</span>' +
                    '<span class="col-md-2">'+ millisToMinutesAndSeconds(data.track[i][6]) +'</span>' +
                    '<span class="col-md-3 overme" data-toggle="tooltip" title="'+data.track[i][5]+'">'+ data.track[i][5] +'</span>' +
                    '<span class="col-md-1">'+ data.track[i][8] +'</span>' +
                    '<span class="col-md-2"><button id="submit" class="btn btn-primary page-scroll" type="button" onclick="addCart(\''+data.track[i][1]+'\')" style="margin: -6px 0px 0px 25px;">   +   </button></span>' +
                    '</li>')
                }
            },
            error: function(error) {
                console.log(error);
            }
        });
}

function addCart(track_name) {
    localStorage.setItem(track_name, '0.99');
}

function addCart_fromUI(track_name) {
    localStorage.setItem(track_name, '0.99');
}


function displatCart() {
    console.log('>>>>>>>>>>> display cart')

    document.getElementById('cartList').innerHTML = (
    '<li class="list-group-item active">' +
    '<span class="col-md-4 overme" >Track</span>' +
    '<span class="col-md-2">Cost</span>' +
    '</li>')
    for (i in localStorage) {
    document.getElementById('cartList').innerHTML += (
    '<li class="list-group-item">' +
    '<span class="col-md-4 overme" title="'+i+'">'+ i +'</span>' +
    '<span class="col-md-2">'+ localStorage[i] +'</span>' +
    '</li>')
    }


    document.getElementById('cartList').innerHTML += ('<li style="margin: 25px 0px 0px 30%;font-size: 20px;">Total: $'+(localStorage.length*0.99).toFixed(2)+'</li>')
    document.getElementById('cartList').innerHTML += ('<li style="margin: 25px 0px 0px 75%;"><button id="submit" class="btn btn-primary btn-xl page-scroll" type="button" > Checkout</button></li>')
}



function clearCart() {
    localStorage.clear()
}

function createEmployee() {
    f_name = document.getElementById('f_name').value;
    l_name = document.getElementById('l_name').value;
    job_title = document.getElementById('job_title').value;
    report_to = document.getElementById('report_to').value;
    dob = document.getElementById('dob').value;
    Hire_date = document.getElementById('Hire_date').value;
    address = document.getElementById('address').value;
    city = document.getElementById('city').value;
    state = document.getElementById('state').value;
    country = document.getElementById('country').value;
    post_code = document.getElementById('post_code').value;
    phone_number = document.getElementById('phone_number').value;
    email = document.getElementById('email').value;

    console.log(f_name);

    
    $.ajax({
        type: "GET",
        url: '/api_add_emp/',

        data: {'EmployeeId': 9, 'LastName': l_name, 'FirstName':f_name, 'Title':job_title , 'ReportsTo': report_to, 'BirthDate':dob, 'HireDate':Hire_date, 'Address':address, 'City':city, 'State':state, 'Country':country, 'PostalCode':post_code, 'Phone':phone_number, 'Email':email},
        // data: {'EmployeeId': 9, 'LastName': 'testL', 'FirstName':'test'},

        dataType: "json",
        success: function (data) {


        },
        error: function (error) {
            console.log(error);
        }
    });

}



function load_val() {
    if (sessionStorage.permission == 'admin') {
        document.getElementById('main_access').innerHTML =
            ('<a class="page-scroll" href="/emp_list/">Employee Details</a>');
        document.getElementById('user_access').innerHTML =
            ('<a class="page-scroll" href="/cust_list/">Customer Details</a>');
        document.getElementById('disp_name').innerHTML =
            ('<p style="font-size:18px;color:rgba(255,255,255,.7);' +
            'margin:13px 0px 0px 0px;">Welcome ' + sessionStorage.user_name + '</p>');
    } else if (sessionStorage.permission == 'view') {
        document.getElementById('disp_name').innerHTML =
            ('<p style="font-size:18px;color:rgba(255,255,255,.7);' +
            'margin:13px 0px 0px 0px;">Welcome </p>');
    } else if (sessionStorage.permission == 'user') {
        document.getElementById('user_access').innerHTML =
            ('<a class="page-scroll" href="/cust_list/">Customer Details</a>');
        document.getElementById('disp_name').innerHTML =
            ('<p style="font-size:18px;color:rgba(255,255,255,.7);' +
            'margin:13px 0px 0px 0px;">Welcome ' + sessionStorage.user_name + '</p>');
    }
}

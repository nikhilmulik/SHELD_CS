
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




 $(function () {

 <!-- $('.msg_container_base').css('display','block');-->



 });
      $(document).on('click', '.panel-heading span.icon_minim', function (e) {

      var $this = $(this);
<!--$("#msg_container_base").show();-->


    if (!$this.hasClass('panel-collapsed')) {

        $this.parents('.panel').find('.panel-body').slideDown();
        $this.addClass('panel-collapsed');
        $this.removeClass('glyphicon-triangle-bottom').addClass('glyphicon-triangle-left');
    }
    else
    {

        $this.parents('.panel').find('.panel-body').slideUp();
        $this.removeClass('panel-collapsed');
        $this.removeClass('glyphicon-triangle-left').addClass('glyphicon-triangle-bottom');


    }

});
$(document).on('focus', '.panel-footer input.chat_input', function (e) {
    var $this = $(this);
    if ($('#minim_chat_window').hasClass('panel-collapsed')) {
        $this.parents('.panel').find('.panel-body').slideDown();
        $('#minim_chat_window').removeClass('panel-collapsed');
        $('#minim_chat_window').removeClass('glyphicon-triangle-left').addClass('glyphicon-triangle-bottom');
    }
});

$(document).on('click', '#new_chat', function (e) {
    var size = $( ".chat-window:last-child" ).css("margin-left");
     size_total = parseInt(size) + 400;
    alert(size_total);
    var clone = $( "#chat_window_1" ).clone().appendTo( ".container" );
    clone.css("margin-left", size_total);
});


   //    var socket = io.connect( 'http://localhost:5000/' )
   //    // broadcast a message
   // /* var io = require("socket.io.min");
   //
   //  socket.join('myyyyyyyyyyyyyroom'); // Do this for both users you want to chat with each other
   //  socket.broadcast.to('myyyyyyyyyyyyyroom').emit('message', 'blah');*/
   //
   //    socket.on( 'connect', function() {
   //
   //     /* socket.emit( 'my event', {
   //        data: 'User Connected'
   //      } )*/
   //      //for enter button
   //      $(document).on("keypress", "#btn-input", function(e) {
   //      if (e.which == 13) {
   //       //do some stuff
   //       e.preventDefault()
   //        let user_input  = $( 'input.form-control' ).val()
   //        let user_name = readCookie('username')
   //        socket.emit( 'my event', {
   //          user_name : user_name,
   //          message : user_input
   //        } )
   //        // empty the input field
   //        $( 'input.form-control' ).val( '' ).focus()
   //      }
   //      });
   //       $(document).on('click', '#btn-chat', function (e){
   //
   //        e.preventDefault()
   //        let user_input  = $( 'input.form-control' ).val()
   //        let user_name = readCookie('username')
   //        socket.emit( 'my event', {
   //          user_name : user_name,
   //          message : user_input
   //        } )
   //        // empty the input field
   //        $( 'input.form-control' ).val( '' ).focus()
   //      } )
   //    } )
   //    // capture message
   //    socket.on( 'my response', function( msg ) {
   //      console.log(readCookie('username') )
   //      if( typeof msg.user_name !== 'undefined' )
   //       {
   //          var d = new Date();
   //        $( 'div.col-md-10' ).append( '<div class="messages msg_sent"><b style="color: #000">'+msg.user_name+'</b> '+msg.message+'<br><time style="font-size:80%">'+  d.toString().substring(0,d.toString().indexOf("GMT"))+'</time></div><br>' )
   //      }
   //    } )

        $(document).ready(function() {
         if(!readCookie('username')){
               return;
         }
         setDashName();
        });
      function setDashName(){
         $("#uname").text(readCookie('username'));
        }

function load_user_data(){
    if (document.getElementById('user_data').innerHTML != "") {
        var user_data = document.getElementById('user_data').innerHTML;
        var user_data = document.getElementById('user_data').innerHTML;
        var username = user_data.split(',')[0];
        var useremail = user_data.split(',')[1];
        var user_id = user_data.split(',')[2];
        createCookie('username', username, 10);
        createCookie('useremail', useremail, 10);
        createCookie('u_id', user_id, 10);
    };
}

    function guidGenerator() {
        var S4 = function() {
            return (((1+Math.random())*0x10000)|0).toString(16).substring(1);
        };
        return (S4()+S4()+"-"+S4()+"-"+S4()+"-"+S4()+"-"+S4()+S4()+S4());
    }


      function loadKeylogData(){
           console.log('get Key log');
           $.ajax({
            type: 'GET',
            url: '/getKeylogData/'+readCookie('u_id'),
//            data: objectData,
            contentType: "application/json charset=utf-8",
            traditional: true,
            dataType: "json",
            success: function (data) {
//                alert(data);
               // window.location.href = "http://127.0.0.1:5000/dashboard";
               for (var i = data.length -1; i >=0 ; i--) {
                        var divId = guidGenerator();
                        $("#keylogtb").append("<tr><td>" +   data[i][1] + "</td><td>" + "<a href='#'>" + data[i][2] + "</a>" + "</td>"+"<td>" +  "<div  data-toggle='collapse' data-target='#"+ divId+"'>" + "Click" +"</div>"+"<div id='"+divId+"'"+" class='collapse'>"+data[i][3]+"</div>"+"</td>"+"</tr>");

               }
            },
            error: function (error) {
                console.log(error);
//                 $('#errormsg').html('Invalid Credentials!');
              }
        });
      }



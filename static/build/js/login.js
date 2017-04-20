function signUp(){
    alert("BRO");
     var url = '';
     var formAction = $("#signup").attr('action');
     var formMethod = $("#signup").attr('method');
     $.ajax({
            url     : formAction,
            type    : formMethod,
            data    : $("#signup").serialize(),
            success : function( response ) {
                        alert( response );
                      }
        });
}
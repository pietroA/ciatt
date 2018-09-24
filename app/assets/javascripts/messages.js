function SendMessage(e, element){
    e.preventDefault();
    var chat_id = element.dataset.chat;
    var user_id = element.dataset.user;
    var textarea = document.getElementById('message-body-'+user_id+'-'+chat_id);
    var message_body = textarea.value;
    $.ajax({
        url: '/api/messages/',
        type: 'POST',
        data: {
            message : {
               chat_id: chat_id,
               body: message_body 
            }
        },
        success: (message) => {
            //createMessageElement(message);
            textarea.value = "";
        },
        error: (xhr, status, error) => { console.log(xhr, status, error); }
    });
}

//function createMessageElement(message){
//    console.log(message);
//    var me = document.createElement("blockquote");
//    me.id = "message-"+message.id;
//    me.classList.add("message");
//    if (message.user.name == receiver) {
//        me.classList.add("self");
//    }
//    me.innerHTML = message.body;
//    var small = document.createElement("small");
//    small.innerHTML = message.user.name + " - "+ message.time_ago;
//    me.append(small);
//    mb = document.getElementById("messages-box-"+message.chat_id);
//    mb.append(me);
//    mb.scrollTo(0, mb.scrollHeight);
//}

function checkMessage(e) {
    var space = /\s/g;
    var textarea = e.target;
    var lines = textarea.value.split(/\r*\n/);
    var rows = lines.length;
    
    lines.forEach((line) => {
        var length = line.length;
        var spaces = line.match(space);

        if (spaces) {
            length -= (spaces.length / 6);
        }
        rows += (length / 24 );
    });
//    rows  += (textarea.value.length / 24 ) + 1;
    textarea.rows = rows;
}
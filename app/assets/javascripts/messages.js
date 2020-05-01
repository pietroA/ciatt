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
            chat_id: chat_id,
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

function checkMessage(e) {
    var space = /\s/g;
    var textarea = e.target;
    var lines = textarea.value.split(/\r*\n/);
    var rows = lines.length;

    if (event.keyCode === 13) {
        event.preventDefault();
        if(textarea.value != '' && textarea.value != "\r" && textarea.value != "\n") {
            document.getElementById("send-message-button").click();
        } else {
            textarea.value = '';
        }
    } else {
        lines.forEach((line) => {
            var length = line.length;
            var spaces = line.match(space);
    
            if (spaces) {
                length -= (spaces.length / 6);
            }
            rows += (length / 50 );
        });
    //    rows  += (textarea.value.length / 24 ) + 1;
        textarea.rows = rows;
    }
}

function GetMessages(chat_id) {
    $.ajax({
        url: "/api/messages",
        type: 'GET',
        data: {
            chat_id: chat_id
        },
        success: (new_messages) => { 
            if(new_messages.length > messages.length){
                messages = new_messages;
            }
         },
        error: (xhr, status, error) => { console.log(xhr, status, error); }
    })
}

function ReloadMessages(chat_id) {
    $.ajax({
        url: "/api/messages",
        type: 'GET',
        data: {
            chat_id: chat_id
        },
        success: (new_messages) => { 
            new_messages.forEach((message) => {
                UpdateTimeMessage(message);
            });

            // if(new_messages.length > messages.length){
            //     SetNewMessagesBtn(chat_id);
            // }
         },
        error: (xhr, status, error) => { console.log(xhr, status, error); }
    })
}


function renderMessage(message) {
    mb = document.getElementById("messages-box-"+message.chat_id);
    if(mb) {
        var md = document.createElement("div");
        md.classList.add("message-div");
        var me = document.createElement("blockquote");
        me.id = "message-"+message.id;
        me.classList.add("message");
        if (message.user.name == receiver) {
            me.classList.add("self");
        }
        me.innerHTML = message.body;
        var small = document.createElement("small");
        small.id = 'time-ago-'+message.id;
        small.innerHTML = message.user.name + " - "+ message.time_ago;
        me.append(small);
        md.append(me);
        mb.append(md);
    } else {
        clearInterval(messagesReloading);
    }

}

function SetNewMessagesBtn(chat_id) {
    var new_messages_btn = document.getElementById('new-messages-btn');
    if(new_messages_btn) {
        return;
    }

    var span = document.createElement('span');
    span.classList.add('fa');
    span.classList.add('fa-comments-o');
    var a = document.createElement("a");
    a.classList.add("new-messages-btn");
    a.id = 'new-messages-btn';
    a.append(span);
    a.href = '';
    mp = document.getElementById("messages-panel-"+chat_id);
    mp.append(a);
    
    a.addEventListener('click', function (event) {
        event.preventDefault();
        var new_messages_btn = document.getElementById('new-messages-btn');
        new_messages_btn.remove();
        LoadMessagesOnPage(chat_id);
    });
}

function LoadMessagesOnPage(chat_id) {
    var mb = document.getElementById("messages-box-"+chat_id);
//    mb.innerHTML = '';
    messages.forEach((message) => {
        if(!messages.includes(message)){
            renderMessage(message);
            messages.push(message);
        }
    });
    mb.scrollTo(0, mb.scrollHeight);

}
function UpdateTimeMessage(message) {
    var small = document.getElementById('time-ago-'+message.id);
    if(small) {
        small.innerHTML = message.user.name + " - "+ message.time_ago;
    } else {
        renderMessage(message);
    }
}
function ClearInterval() {
    if(messagesReloading){
        clearInterval(messagesReloading);
    }
    if(setUserOnlineStatus){
        clearInterval(setUserOnlineStatus);
    }
}
function StartChat(e){
    e.preventDefault();
    var user_id = e.target.dataset.user;
    console.log(user_id);
    $.ajax({
        url: '/api/chats/',
        type: 'POST',
        data: {
            user_id: user_id
        },
        success: (chat) => { window.location.href = '/chats/'+chat.id; },
        error: (xhr, status, error) => { console.log(xhr, status, error); }
    });
}

function SetUserOnlineStatus(user_id) {
    $.ajax({
        url: '/api/users/'+user_id,
        type: 'GET',
        success: (user) => {
            var element = document.getElementById('logon-'+sender);
            if(user.online_status.online) {
                if (element && !element.classList.contains('online')) {
                    element.classList.add('online');
                }
            } else {
                if (element && element.classList.contains('online')) {
                    element.classList.remove('online');
                }
            }
        },
        error: (xhr, status, error) => { console.log(xhr, status, error); }
    });
}
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
App.messages = App.cable.subscriptions.create('MessagesChannel', {  
  received: function(data) {
    this.renderNewMessage(data.message);
    return true;
  },

  renderNewMessage: function(message){
    renderMessage(message);
    var textarea = document.getElementById('message-body-'+message.user.id+'-'+message.chat_id);
    if (textarea) {
      textarea.value = "";
      textarea.rows = 1;
    }
    if(messages){
      messages.push(message);
    }
    mb = document.getElementById("messages-box-"+message.chat_id);
    mb.scrollTo(0, mb.scrollHeight);
    return true;
  }

});


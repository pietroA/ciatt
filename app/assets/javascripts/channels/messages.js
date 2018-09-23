App.messages = App.cable.subscriptions.create('MessagesChannel', {  
  received: function(data) {
    this.renderMessage(data.message);
    return true;
  },

  renderMessage: function(message){
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
      small.innerHTML = message.user.name + " - "+ message.time_ago;
      me.append(small);
      md.append(me);
      mb = document.getElementById("messages-box-"+message.chat_id);
      mb.append(md);
      mb.scrollTo(0, mb.scrollHeight);
      return true;
  }

});


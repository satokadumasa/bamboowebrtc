import consumer from "./consumer"
const chatChannel =consumer.subscriptions.create("RoomChannel", {
  connected() {
    // Called when the subscription is ready for use on the server
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
  },

  received(data) {
    // Called when there's incoming data on the websocket for this channel
    // return alert(data['message']);
    return $('#messages').append(data['message']);
  },

  speak: function(data) {
    // return this.perform('speak');
    // let messages = JSON.perse(message);
    let insert_html = '';
    insert_html += '<div class="message">';
    insert_html += '  <p>' + data + '</p>';
    insert_html += '</div>';

    return $('#messages').append(insert_html);
  }
});


$(document).on('keypress', '[data-behavior~=room_speaker]', function(event) {
  if (event.keyCode === 13) {
    chatChannel.speak(event.target.value);
    event.target.value = '';
    return event.preventDefault();
  }
});
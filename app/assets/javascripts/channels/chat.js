  //remark_post
$(function() {
  if( $('#room_name').is('*')) {
    var room_name = $('#room_name').text();
    var username = $('#user_name').text();
    var user_id = $('#user_id').text();

    App.chat = App.cable.subscriptions.create({channel: "ChatChannel", room: room_name, username: username, user_id: user_id})
    
    App.chat.connected = function() {
        // Called when the subscription is ready for use on the server
      var authenticity_token = $('input[name="authenticity_token"]').val();
      var data = {
        'room': room_name,
        'lounge_id': $('#remark_lounge_id').val(),
        'user_id': $('#remark_user_id').val(),
        'content': 'attend',
        'last_posted_at': $('#last_posted_at').val(),
        'authenticity_token': authenticity_token
      };
      $('#last_posted_at').val(last_posted_at())
      $('#remark_content').val('');
      App.chat.remark(data);
    };

    App.chat.disconnected = function(){
      var authenticity_token = $('input[name="authenticity_token"]').val();
      var data = {
        'room': room_name,
        'lounge_id': $('#remark_lounge_id').val(),
        'user_id': $('#remark_user_id').val(),
        'content': 'secession',
        'last_posted_at': $('#last_posted_at').val(),
        'authenticity_token': authenticity_token
      };
      $('#last_posted_at').val(last_posted_at())
      App.chat.remark(data);
      location.href = base_url + 'lounges/'
      return this.perform('unsubscribed');
    }

    App.chat.received = function(data) {
        // Called when there's incoming data on the websocket for this channel
        var remarks = data['remarks'];
        var secession = data['secession'];
        var attends = data['attends'];
        for (var i = 0 ; i < remarks.length; i++) {
          var colum = "";
          colum = '<div class="col-4">';
          colum = colum + '<div style="float: left;"><img src="' + remarks[i]['image_url'] + '" width="30" height="30"></div>';
          colum = colum + '<div style="float: left;">' + remarks[i]['user_name'] + '</div>' ;
          colum = colum + '</div>';
          colum = colum + '<div class="col-8">';
          colum = colum + remarks[i]['created_at'];
          colum = colum + '</div>';
          colum = colum + '<div class="col-12">';
          colum = colum + remarks[i]['content'];
          colum = colum + '<hr>';
          colum = colum + '</div>';
          
          $('#last_posted_at').val(remarks[i]['created_at']);
          if($('#remarks').is('*')) {
            $('#remarks').prepend(colum);
          }
        }

        if(attends.length > 0) {
          $('#attender_list').empty();
          for (var i = 0; i < attends.length; i++) {
            var attend = attends[i]
            var str = '';
            str = str + '<li id="user_' + attend['user_id'] + '"  user_name="' + attend['user_name'] + '" class="view_user_info list-inline-item" onclick="view_user_info(this)">';
            str = str + '<img src="' + attend['image_path'] + '" width="30" height="30">';
            str = str + '</li>';
            $('#attender_list').append(str);
          }
        }

        if(secession) {
          var str = '';
          $('#user_' + secession['user_id']).remove();
        }
    }

    App.chat.remark = function(data) {
      return this.perform('remark', data);
    }

    $('#remark_btn').on('click', function(){
      var authenticity_token = $('input[name="authenticity_token"]').val();
      var data = {
        'room': room_name,
        'lounge_id': $('#remark_lounge_id').val(),
        'user_id': $('#remark_user_id').val(),
        'content': $('#remark_content').val(),
        'last_posted_at': $('#last_posted_at').val(),
        'authenticity_token': authenticity_token
      };
      $('#last_posted_at').val(last_posted_at())
      $('#remark_content').val('');
      App.chat.remark(data);
      return;    
    });
    if( $('#leave_btn').is('*')) {
      $('#leave_btn').on('click', function(){
        App.chat.disconnected();
      });
    }
  }
});

function view_user_info(obj) {
  var user_name = $(obj).attr('user_name');
  var username = $(obj).text();
  var url = base_url + '-/' + user_name + '.json';
  $.ajax({
    url: url,
    type: 'get',
    data:{
    }
  })
  .done( (data) => {
    alert('view_user_info');
    var str = '';
    str = str + '<div class="user_info_modal" id="' + data['user_id'] + '" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">';
    str = str + '  <div>';
    str = str + '    <img src="' + data['image_path'] + '" width="100" height="100">';
    str = str + '  <div>';
    str = str + '  <div>';
    str = str + '    ' + data['user_name'];
    str = str + '  </div>';
    str = str + '  <div class="btn" onclick="close_user_info(' + data['user_id'] + ')">';
    str = str + '    CLOSE'
    str = str + '  </div>';
    str = str + '</div>';
    $('#user_info').append(str);
    // $('#'+ data['user_id']).show();
  })
  .fail( (data) => {
    alert('view_user_info fail')
  })
  .always( (data) => {
  });
}

function close_user_info(id) {
  $('#' + id).remove(); 
}

function last_posted_at() {
  var weeks = new Array('日','月','火','水','木','金','土');
  var now = new Date();

  var year = now.getYear(); // 年
  var month = now.getMonth() + 1; // 月
  var day = now.getDate(); // 日
  var week = weeks[ now.getDay() ]; // 曜日
  var hour = now.getHours(); // 時
  var min = now.getMinutes(); // 分
  var sec = now.getSeconds(); // 秒

  if(year < 2000) { year += 1900; }

  // 数値が1桁の場合、頭に0を付けて2桁で表示する指定
  if(month < 10) { month = "0" + month; }
  if(day < 10) { day = "0" + day; }
  if(hour < 10) { hour = "0" + hour; }
  if(min < 10) { min = "0" + min; }
  if(sec < 10) { sec = "0" + sec; }

  // 表示開始
  return year + '-' + month + '-' + day + ' ' + hour + ':' + min + ':' + sec;
}

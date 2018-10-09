$(function () {
  $('.ajax').click(
    function () {
      $.ajax({
        url: 'http://localhost:8008/ajax',
        type: "get",
        dataType: 'text',
        success: function (data) {
          $('.text').html(data);
        },
        error: function (data) {
          alert('error');
        }
      });
    }
  );
});
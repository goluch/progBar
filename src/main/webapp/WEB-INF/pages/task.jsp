<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>

<html xmlns="http://www.w3.org/1999/xhtml" lang="en"> 

    <head>
    	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1"/>
    	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css"/>
 		<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
		<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>

        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>

        <script>
          $(document).ready(function () {
        	  
        	$("#btnStop").prop("disabled",true);
            $.getJSON(window.location.href.concat('/status'), function(data) {
              if (data === "created") {

              } else {
                // task is already being executed
                refreshProgress();
              }
            });
          });

          var width = 0;

          function getProgress() {
            $.getJSON(window.location.href.concat('/progress'), function(percentage) {
              $('#progressBar').css('width', percentage+'%');
              document.getElementById("label").innerHTML = percentage * 1 + '%';
              width = percentage;
            });
          }

          function start() {
            $.ajax({
              type: "post",
              url: window.location.href.concat('/form'),
              data: $('#task').serialize(),
              success: function(data) {
                $('#progressBar').css('width', 100+'%');
                document.getElementById("label").innerHTML = 100 * 1 + '%';

                // do sth with the data after finished task
              }
            });

            width = 0;
            $("#btnStart").prop("disabled",true);
            $("#btnStop").prop("disabled",false);
            $('#progressBar').css('width', 0+'%');
            document.getElementById("label").innerHTML = 0 * 1 + '%';

            refreshProgress();
          }

          function refreshProgress() {
            var id = setInterval(frame, 1000);
            function frame() {
                if (width >= 100) {
                    clearInterval(id);
                    $("#btnStart").prop("disabled",false);
                    $("#btnStop").prop("disabled",true);
                } else {
                    getProgress();
                }
            }
          }

        </script>

    </head>
    <body>

      <div class="container">

        <h2 class="text-center">Progress Bar Example</h2>      
        
        <div class="progress">
          <div id="progressBar" class="progress-bar" role="progressbar" aria-valuenow="70" aria-valuemin="0" aria-valuemax="100" style="width:0%">
            <div id="label">0%</div>
          </div>
        </div>

        <form:form method="POST" commandName="task" cssClass="form-horizontal">
        <fieldset>

        <div class="form-group">
          <label class="col-md-4 control-label" for="btnStart">Actions</label>
          <div class="col-md-8">
            <button id="btnStart" name="btnStart" class="btn btn-success">Start</button>
            <button id="btnStop" name="btnStop" class="btn btn-danger">Stop</button>
          </div>
        </div>

        </fieldset>
        </form:form>

      </div>

      <script>
        $('#task').submit(function () {
         start();
         return false;
        });
      </script>

    </body>
</html>
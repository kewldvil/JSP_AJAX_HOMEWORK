<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
    <!DOCTYPE html>
    <html>

    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
        <title>Nem Sopheak</title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css">
        <style type="text/css">
        body {
            background-color: #F2F1EF;
        }
        .col-md-6{
        	padding-left: 0px;
        }
        .form-horizontal .control-label {
        	text-align: left;
        	padding-left: 65px;
        }
        table,
        td {
            border-collapse: collapse;
            border: 1px solid gray;
            text-align:center;
        }
        
        th {
            border-collapse: collapse;
            border: 1px solid #ffffff;
            background-color: #4183D7;
            color: #fff;
            text-align: center !important;
        }
        
        tbody {
            background-color: #ffffff;
        }
        </style>
    </head>

    <body>
        <div class="container">
            <div class="col-md-10 col-md-offset-1">
                <div class="page-header text-center">
                    <h2>Staff and Student Management</h2>
                    <div class="form-horizontal">
                    <div class="row" style="margin-bottom:5px">
                    	<div class="col-md-6">
							  	<div class="form-group">
								    <label class="col-md-6 control-label">Search By Name:</label>
								    <div class="col-md-6">
								      <input type="text" class="form-control" id="name" name="name">
								    </div>
							  	</div>
                    	</div>
                    	<div class="col-md-3">
                    		<select name="class" id="class" class="form-control">
                    			<option value="">All Class</option>
                    			<option value="BTB">BTB</option>
                    			<option value="KPS">KPS</option>
                    			<option value="SR">SR</option>
                    			<option value="PP">PP</option>
                    		</select>
                    	</div>
                    	<div class="col-md-3">
                    		<select name="status" id="status" class="form-control">
                    			<option value="" selected="selected">All Status</option>
                    			<option value="true">Active</option>
                    			<option value="false">Drop</option>
                    		</select>
                    	</div>
                    	</div>
                    </div>
                    <div class="table-responsive">
							<!-- load from jQuery -->
                    </div>
                </div>
            </div>
        </div>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>
        <script>

        $(document).ready(function() {
			firstLoad();
            function firstLoad(){
	            $.post('index.pheak', function(listStudent) {
	                loadStudentList(listStudent);
	                $('a').click(function(){
	                	var id=$(this).attr("id");
	                	updateStudent(id);
	                });
	            });
            }
      
            function loadStudentList(JSONData) {
            	var tableHead="";
            		tableHead+='<table class="table">';
	            		tableHead+='<thead>';
		            		tableHead+='<th>Id</th>';
		            		tableHead+='<th>Name</th>';
		            		tableHead+='<th>Gender</th>';
		            		tableHead+='<th>University</th>';
		            		tableHead+='<th>Class</th>';
		            		tableHead+='<th>Status</th>';
	            		tableHead+='</thead>';
	            		tableHead+='<tbody>';
	            		tableHead+='</tbody>';
            		tableHead+='</table>';

            		$('.table-responsive').html(tableHead);
                $.each(JSONData, function(i, student) {
                    var gender = student.gender == 1 ? "Male" : "Female";
                    var imageUrl = student.status == 1 ? "active.png" : "inActive.png";
                    var content = '<tr>';
                    content += '<td>' + student.id + '</td>';
                    content += '<td>' + student.name + '</td>';
                    content += '<td>' + gender + '</td>';
                    content += '<td>' + student.university + '</td>';
                    content += '<td>' + student.classes + '</td>';
                    content += '<td><a href="#" id="'+student.id+'"><img src="img/' + imageUrl + '" width="25px" height="25px"/></a></td>';
                    content += '</tr>';
                    $('tbody').append(content);   
                });
					
            };
            function updateStudent(id){
            	$.post('updateStudent.pheak', {id : id}, function(listStudent) {
            		$('.table-responsive').empty();
            		 firstLoad(); 
            		
            	});
            }
            $('#name').keyup(function (e) {
            	var name = $(this).val();
            	var classes = $('#class').val();
            	var status = $('#status').val();
            	$.post('index.pheak', {name:name,classes:classes,status:status}, function(listStudent) {
            		loadStudentList(listStudent);
            			                $('a').click(function(){
	                	var id=$(this).attr("id");
	                	updateStudent(id);
	                });
            	});
            	e.preventDefault();
            });
            $('#class').on('change',function(e){
            	var classes = $(this).val();
            	var status = $('#status').val();
            	var name = $('#name').val();
            	 $.post('index.pheak', {name:name,classes:classes,status:status}, function(listStudent) {
            	 	loadStudentList(listStudent);
            	 		                $('a').click(function(){
	                	var id=$(this).attr("id");
	                	updateStudent(id);
	                });
            	 });
            
            	e.preventDefault();
            });
            $('#status').on('change',function(){
            	/* $("#name").val(""); */
            	var name = $('#name').val();
            	var status = $(this).val();
            	var classes = $('#class').val();
            	 $.post('index.pheak', {name:name,classes:classes,status:status}, function(listStudent) {
            	 	loadStudentList(listStudent);
            	 		                $('a').click(function(){
	                	var id=$(this).attr("id");
	                	updateStudent(id);
	                });
            	 });
            
            	e.preventDefault();
            });
        });
        </script>
    </body>

    </html>

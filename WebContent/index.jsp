<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
    <!DOCTYPE html>
    <html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
        <title>Nem Sopheak</title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css">
		<link rel="stylesheet" href="mystyle.css">
    </head>
    <body>
        <div class="container">
            <div class="col-md-10 col-md-offset-1">
                <div class="page-header text-center">
                    <h2>Staff and Student Management</h2>
                    <div class="form-horizontal">
                        <div class="row">
                            <div class="col-md-5">
                                <div class="form-group">
                                    <label class="col-md-5 control-label">Search By Name:</label>
                                    <div class="col-md-7">
                                        <input type="text" class="form-control" id="name" name="name">
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-2">

                                <select name="class" id="class" class="form-control">
                                		 <option value="">All Class</option>
                                         <option value="PP">PP</option>
						      			<option value="KPS">KPS</option>
						      			<option value="SR">SR</option>
						      			<option value="BTB">BTB</option>
                                </select>
                            </div>
                            <div class="col-md-2">
                                <select name="status" id="status" class="form-control">
                                    <option value="" selected="selected">All Status</option>
                                    <option value="true">Active</option>
                                    <option value="false">Drop</option>
                                </select>
                            </div>
                            <div class="col-md-3">
                            	<button class="btn btn-success btn-block" data-toggle="modal" data-target="#myModal" id="myAddBtn">New Student</button>
                            </div>
                        </div>
                    </div>
                    <div class="alert alert-success">Inserted Success !</div>
                    <div class="table-responsive">
                        <!-- load from jQuery -->
                    </div>
                </div>
            </div>

            <!-- new and edit student modal -->
            <div class="modal fade" id="myModal">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header modalHeaderColor">
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close" ><span aria-hidden="true">&times;</span></button>
                            <h4 class="modal-title ">New Student Form</h4>
                        </div>
                        <div class="modal-body">
                            <div class="form-horizontal">
								<div class="form-group">
							    	<label class="col-sm-3 control-label">ID</label>
							    	<div class="col-sm-9">
							      		<input type="text" class="form-control" name="id" id="id">
                                        <span class="glyphicon form-control-feedback" id="span1"></span>
                                        <span class="errorMessage" id="idModal"></span>
							    	</div>
							  	</div>
							  	<div class="form-group">
							    	<label class="col-sm-3 control-label">Name</label>
							    	<div class="col-sm-9">
							      		<input type="text" class="form-control" name="nameModal" id="nameModal">
                                        <span class="glyphicon form-control-feedback" id="span2"></span>
                                        <span class="errorMessage" id="nameSpan"></span>
							    	</div>
							  	</div>
							  	<div class="form-group">
							    	<label class="col-sm-3 control-label">Gender</label>
							    	<div class="col-sm-9">
							      		<select class="form-control" name="gender" id="gender">
							      			<option value="1">Male</option>
							      			<option value="0">Female</option>
							      		</select>
							    	</div>
							  	</div>
							  	<div class="form-group">
							    	<label class="col-sm-3 control-label">University</label>
							    	<div class="col-sm-9">
							      		<select class="form-control" name="university" id="university">
											<option value="SETEC">SETEC</option>
											<option value="RUPP">RUPP</option>
											<option value="PPIU">PPIU</option>
											<option value="BBU">BBU</option>
											<option value="NU">NU</option>
							      		</select>
							    	</div>
							  	</div>
							
						  	<div class="form-group">
						    	<label class="col-sm-3 control-label">Class</label>
						    	<div class="col-sm-9">
						      		<select class="form-control" name="classes" id="classes">
						      			<option value="PP">PP</option>
						      			<option value="KPS">KPS</option>
						      			<option value="SR">SR</option>
						      			<option value="BTB">BTB</option>
						      		</select>
						    	</div>
						  	</div>							
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                            <button type="button" class="btn btn-primary" id="myBtnSubmit">Add</button>
                        </div>
                        </div>
                    </div>
                    <!-- /.modal-content -->
                </div>
                <!-- /.modal-dialog -->
            </div>
            <!-- /.modal -->
        </div>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>
        <script src="myscript.js"></script>
    </body>

    </html>

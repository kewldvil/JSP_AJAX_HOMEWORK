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
        
        .col-md-6 {
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
            text-align: center;
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
                                    <!-- Load from jQuery -->
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
            getStudentList();
            getClassName();

            function setTableData(JSONData) {
                var tableHead = "";
                tableHead += '<table class="table">';
                tableHead += '<thead>';
                tableHead += '<th>Id</th>';
                tableHead += '<th>Name</th>';
                tableHead += '<th>Gender</th>';
                tableHead += '<th>University</th>';
                tableHead += '<th>Class</th>';
                tableHead += '<th>Status</th>';
                tableHead += '</thead>';
                tableHead += '<tbody>';
                tableHead += '</tbody>';
                tableHead += '</table>';

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
                    content += '<td><a href="#" id="' + student.id + '"><img src="img/' + imageUrl + '" width="25px" height="25px"/></a></td>';
                    content += '</tr>';
                    $('tbody').append(content);
                });
            }

            function getClassName() {
                $.post('className.pheak', function(data) {
                    setSelectOption(data);
                });
            }

            function setSelectOption(JSONClassname) {
                $('#class').html($("<option></option>").attr("value", "").text("All Class"));
                $.each(JSONClassname, function(i, item) {
                    $('#class').append($("<option></option>").attr("value", item).text(item));
                });
            }

            function getStudentList() {
                var name = $('#name').val();
                var status = $('#status').val();
                var classes = $('#class').val();
                $.post('index.pheak', {
                    name: name,
                    classes: classes,
                    status: status
                }, function(JSONData) {
                    setTableData(JSONData);
                    $('a').click(function(e) {
                        updateStatus($(this));
                    });
                });
            }

            function updateStatus(selector) {
                var id = selector.attr("id");
                var img = selector.children().attr("src");
                $.post('updateStudent.pheak', {
                    id: id
                }, function() {
                    selector.children().attr("src") == "img/active.png" ? selector.children().attr("src", "img/inActive.png") : selector.children().attr("src", "img/active.png");
                });
            }

            $('#name').keyup(function(e) {
                getStudentList();
                e.preventDefault();
            });
            $('#class').on('change', function(e) {
                getStudentList();
                e.preventDefault();
            });
            $('#status').on('change', function() {
                getStudentList();
                e.preventDefault();
            });
        });
        </script>
    </body>

    </html>

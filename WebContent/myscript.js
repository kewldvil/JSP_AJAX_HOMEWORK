        $(document).ready(
            function() {
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
                    tableHead += '<th>Function</th>';
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
                        content += '<td><a href="#" id="' + student.id + '" class="statusLink"><img src="img/' + imageUrl + '" width="25px" height="25px" /></a></td>';
                        content += '<td><a href="#" id="' + student.id + '"><img src="img/edit.png" width="25px" height="25px" title="Edit"/></a>&nbsp;&nbsp;&nbsp;<a href="#" id="' + student.id + '" class="delete"><img src="img/delete.png" width="25px" height="25px" title="Delete"/></a></td>';
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
                    $('#class').html(
                        $("<option></option>")
                        .attr("value", "").text(
                            "All Class"));
                    $.each(JSONClassname, function(i, item) {
                        $('#class').append(
                            $("<option></option>").attr(
                                "value", item).text(item));
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
                        $('.statusLink').click(function(e) {
                            updateStatus($(this));
                        });
                        $('.delete').click(function(e) {
                            deleteStudent($(this));
                        });
                    });
                }

                function updateStatus(selector) {
                    var id = selector.attr("id");
                    var img = selector.children().attr("src");
                    $.post('updateStudent.pheak', {
                            id: id
                        },
                        function() {
                            selector.children().attr("src") == "img/active.png" ? selector.children().attr("src", "img/inActive.png") : selector.children().attr("src", "img/active.png");
                        });
                }

                function deleteStudent(selector) {
                    var id = selector.attr("id");
                    $.ajax({
                        url: 'deleteStudent.pheak',
                        method: 'POST',
                        data: {
                            id: id
                        },
                        success: function(e) {
                            deleteRow(selector);
                        }
                    });

                }

                function deleteRow(selector) {
                    selector.parentsUntil("tbody").remove();
                }

                function addStudent() {
                    var id = $('#id').val();
                    var name = $('#nameModal').val();
                    var gender = $('#gender').val();
                    var university = $('#university').val();
                    var classes = $('#classes').val();
                    $.post('insertStudent.pheak', {
                        id: id,
                        name: name,
                        gender: gender,
                        university: university,
                        classes: classes
                    }, function() {
                        getStudentList();
                    });
                }
                $('#addStudentBtn').click(function(e) {
                    if ($('#id').val() != "" && $('#nameModal').val() != "") {
                        var id = $('#id').val();
                        valideStudentId(id);
                    }
                });

                function valideStudentId(id) {
                    $.post('validateStudentId.pheak', {
                        id: id
                    }, function(data) {
                        if(data=="true"){
                            addStudent();
                            $('#myModal').modal('hide');
                        }else{
                            alert("duplicate");
                        }
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

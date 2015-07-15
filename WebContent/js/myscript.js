        $(document).ready(function() {
            getStudentList();
            //getClassName();
            var updateClick;

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
                if (JSONData.length > 0) {
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
                        content += '<td><a href="#" id="' + student.id + '" class="update" data-toggle="modal" data-target="#myModal"><img src="img/edit.png" width="25px" height="25px" title="Edit"/></a>&nbsp;&nbsp;&nbsp;<a href="#" id="' + student.id + '" class="delete"><img src="img/delete.png" width="25px" height="25px" title="Delete"/></a></td>';
                        content += '</tr>';
                        $('tbody').append(content);
                    });
                } else {
                    $('tbody').append('<tr><td colspan="7">No Record...</td></tr>');
                }

            }

            // function getClassName() {
            //     $.post('className.pheak', function(data) {
            //         setSelectOption(data);
            //     });
            // }

            // function setSelectOption(JSONClassname) {
            //     $('#class').html(
            //         $("<option></option>")
            //         .attr("value", "").text(
            //             "All Class"));
            //     $.each(JSONClassname, function(i, item) {
            //         $('#class').append(
            //             $("<option></option>").attr(
            //                 "value", item).text(item));
            //     });
            // }
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
                        var deleteThis = $(this);
                        swal({
                                title: "Are you sure?",
                                text: "Your will not be able to recover this record!",
                                type: "warning",
                                showCancelButton: true,
                                confirmButtonClass: "btn-danger",
                                confirmButtonText: "Yes",
                                closeOnConfirm: false
                            },
                            function() {
                                deleteStudent(deleteThis);
                                swal({
                                    title: "Deleted Success!",
                                    timer: 800,
                                    showConfirmButton: false,
                                    type: "success"
                                });
                            });
                    });
                    $('.update').click(function(e) {
                        updateClick = $(this);
                        updateModal($(this));
                    });
                });
            }

            function updateStatus(selector) {
                var id = selector.attr("id");
                var img = selector.children().attr("src");
                $.post('updateStatus.pheak', {
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

            function updateModal(selector) {
                $('#myBtnSubmit').text('Update');
                var id = selector.attr('id');
                var name = selector.parentsUntil('tbody').find('td').eq(1).text();
                var gender = selector.parentsUntil('tbody').find('td').eq(2).text() == 'Male' ? 1 : 0;
                var university = selector.parentsUntil('tbody').find('td').eq(3).text();
                var classes = selector.parentsUntil('tbody').find('td').eq(4).text();

                $('#id').prop('readonly', true);
                $('#id').val(id);
                $('#nameModal').val(name);
                $('#gender').val(gender);
                $('#university').val(university);
                $('#classes').val(classes);
            }

            function deleteRow(selector) {
                var rowCount = $('tbody tr').length;
                if (rowCount == 1) {
                    selector.parentsUntil("tbody").remove();
                    $('tbody').append('<tr><td colspan="7">No Record...</td></tr>');
                } else {
                    selector.parentsUntil("tbody").remove();
                }
            }
            $("#id").keydown(function(e) {
                // Allow: backspace, delete, tab, escape, enter and .
                if ($.inArray(e.keyCode, [46, 8, 9, 27, 13, 110]) !== -1 ||
                    // Allow: Ctrl+A, Command+A
                    (e.keyCode == 65 && (e.ctrlKey === true || e.metaKey === true)) ||
                    // Allow: home, end, left, right, down, up
                    (e.keyCode >= 35 && e.keyCode <= 40)) {
                    // let it happen, don't do anything
                    return;
                }
                // Ensure that it is a number and stop the keypress
                if ((e.shiftKey || (e.keyCode < 48 || e.keyCode > 57)) && (e.keyCode < 96 || e.keyCode > 105)) {
                    e.preventDefault();
                    
                }
            });

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
                    swal({
                        title: "Inserted Success!",
                        timer: 800,
                        showConfirmButton: false,
                        type: "success"
                    });
                    // $('.alert').slideDown(1000).slideUp(1000);

                });
            }

            function updateStudent(updateID) {
                var id = updateID;
                var name = $('#nameModal').val();
                var gender = $('#gender').val();
                var university = $('#university').val();
                var classes = $('#classes').val();
                $.post('updateStudent.pheak', {
                    id: id,
                    name: name,
                    gender: gender,
                    university: university,
                    classes: classes
                }, function() {
                    $('#myModal').modal('hide');
                    // getStudentList();
                    updateTableRow(updateClick);
                    swal({
                        title: "Updated Success!",
                        timer: 800,
                        showConfirmButton: false,
                        type: "success"
                    });
                });
            }

            function updateTableRow(selector) {
                var row = selector.parents('tr').find('td');
                var name = $('#nameModal').val();
                var gender = ($('#gender').val() == 1) ? "Male" : "Female";
                var university = $('#university').val();
                var classes = $('#classes').val();

                row.eq(1).text(name);
                row.eq(2).text(gender);
                row.eq(3).text(university);
                row.eq(4).text(classes);
            }
            $('#myBtnSubmit').click(function(e) {
                if ($(this).text() == "Add") {
                    if ($('#id').val() != "" && $('#nameModal').val() != "") {
                        var id = $('#id').val();
                        valideStudentId(id);
                    } else if ($('#id').val() == "" && $('#nameModal').val() == "") {
                        $('.modal-body').find('.form-group').eq(0).addClass('has-error');
                        $('.modal-body').find('.form-group').eq(1).addClass('has-error');
                        $('.glyphicon').addClass('glyphicon-remove');
                        $('#nameSpan').text('Name can not be empty !');
                        $('#idModal').text('ID can not be empty !');
                    } else if ($('#id').val() == "") {
                        $('.modal-body').find('.form-group').eq(0).addClass('has-error');
                        $('#span1').addClass('glyphicon-remove');
                        $('#idModal').text('ID can not be empty !');
                    } else if ($('#nameModal').val() == "") {
                        $('.modal-body').find('.form-group').eq(1).addClass('has-error');
                        $('#nameSpan').text('Name can not be empty !');
                        $('#span2').addClass('glyphicon-remove');
                    }
                } else {
                    if ($('#nameModal').val() != "") {
                        updateStudent($('#id').val());
                    } else {
                        $('.modal-body').find('.form-group').eq(1).addClass('has-error');
                        $('#nameSpan').text('Name can not be empty !');
                        $('#span2').addClass('glyphicon-remove');
                    }

                }
            });
            $('input[type="text"]').focus(function(e) {
                $('.form-group').removeClass('has-error');
                $('span').removeClass('glyphicon-remove');
                $('span').text('');
            });

            function valideStudentId(id) {
                $.post('validateStudentId.pheak', {
                    id: id
                }, function(data) {
                    if (data == "true") {
                        addStudent();
                        $('#myModal').modal('hide');
                    } else {
                        $('.modal-body div:first-child div:first-child').addClass('has-error');
                        $('#idModal').text("This ID already existed !");
                        $('#span1').addClass('glyphicon-remove');
                    }
                });
            }
            $('#myAddBtn').click(function(e) {
                $('#myBtnSubmit').text('Add');
                $('#id').removeProp('readonly');
                $('#id').val('');
                $('#nameModal').val('');
                $('#gender option[value=1]').attr('selected', 'selected');
                $('#university option[value="SETEC"]').attr('selected', 'selected');
                $('#classes option[value="PP"]').attr('selected', 'selected');
            });
            $('#myModal').on('hidden.bs.modal', function() {
                $('.form-group').removeClass('has-error');
                $('span').removeClass('glyphicon-remove');
                $('span').text('');
            })
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

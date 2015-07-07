package model.dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import com.mysql.jdbc.Connection;
import com.mysql.jdbc.PreparedStatement;

import model.dto.StudentDto;

public class StudentDao {
	java.sql.Connection con;

	public StudentDao() throws NamingException, SQLException {
		InitialContext iniContext = new InitialContext();
		DataSource ds = (DataSource) iniContext.lookup("java:comp/env/sopheakdb");
		con = ds.getConnection();
		System.out.println("Connecting to database...");
	}

	public ArrayList<StudentDto> listStudent(String... params) throws SQLException {
		String name,classes,status;
		name=params.length >0 ? params[0]:"";
		classes=params.length >1 ? params[1]:"";
		status=params.length >2 ? params[2]:"";
		ArrayList<StudentDto> tempList = new ArrayList();
		java.sql.PreparedStatement ps = con.prepareStatement("select * from student_tbl where name like ? and class like ? and cast(status as text) like ? order by id asc");
		ps.setString(1,"%"+ name+"%");
		ps.setString(2, "%"+ classes+"%");
		ps.setString(3, "%"+ status+"%");
		ResultSet rs = ps.executeQuery();
		while (rs.next()) {
			StudentDto stu = new StudentDto();
			stu.setId(rs.getString("id"));
			stu.setName(rs.getString("name"));
			stu.setGender(rs.getInt("gender"));
			stu.setUniversity(rs.getString("university"));
			stu.setClasses(rs.getString("class"));
			stu.setStatus(rs.getBoolean("status"));

			tempList.add(stu);
		}
		con.close();
		return tempList;
	}

	public boolean updateStudent(String id) throws SQLException {
		java.sql.PreparedStatement ps = con.prepareStatement("update student_tbl set status=NOT status where id=?");
		ps.setString(1, id);
		int result = ps.executeUpdate();
		if (result > 0) {
			System.out.println("update sucess");
			con.close();
			return true;
		} else {
			System.out.println("update fail");
			con.close();
			return false;
		}
	}
}

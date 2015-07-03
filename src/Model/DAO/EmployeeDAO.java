package Model.DAO;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.naming.InitialContext;
import javax.sql.DataSource;

import Model.DTO.EmployeeDto;




public class EmployeeDAO {
	java.sql.Connection con;
	public EmployeeDAO()throws Exception{
		InitialContext init = new InitialContext();
  	    DataSource ds = (DataSource) init.lookup("java:comp/env/sopheakdb");
  	    this.con =  ds.getConnection();
		System.out.println("Connecting to database...");
	}
	
	public ArrayList<EmployeeDto> selectEmployee(String... param) throws SQLException{
		String name = param.length > 0 ?param[0]:"";
		String university = param.length > 1 ?param[1]:"";
		String status = param.length > 2 ?param[2]:"";
		java.sql.PreparedStatement ps = con.prepareStatement("SELECT * FROM employee_tbl WHERE NAME LIKE ? AND UNIVERSITY LIKE ? AND CAST(STATUS AS TEXT) LIKE ?");
		ps.setString(1,"%"+name+"%");
		ps.setString(2,"%"+university+"%");
		ps.setString(3, "%"+status+"%");
		ResultSet rs = ps.executeQuery();
		ArrayList<EmployeeDto> arrEmp = new ArrayList<EmployeeDto>();
		try{
			while(rs.next()){
				EmployeeDto emp = new EmployeeDto();
				emp.setIdLabel(rs.getString("ID_LABE"));
				emp.setName(rs.getString("NAME"));
				emp.setUniversity(rs.getString("UNIVERSITY"));
				emp.setGender(rs.getString("GENDER"));
				emp.setClasses(rs.getString("CLASS"));
				emp.setStatus(rs.getInt("STATUS"));
				
				arrEmp.add(emp);
			}
			return arrEmp;
		}finally{
			if(rs!=null)try{rs.close();}catch(SQLException e){throw e;}
			if(ps!=null)try{ps.close();}catch(SQLException e){throw e;}
			if(con!=null)try{con.close();}catch(SQLException e){throw e;}
		}
	}
	
}

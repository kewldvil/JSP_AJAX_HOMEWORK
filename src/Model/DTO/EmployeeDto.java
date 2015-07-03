package Model.DTO;

public class EmployeeDto {

	private String idLabel;
	private String name;
	private String gender;
	private String university;
	private String classes;
	private int status;

	public String getIdLabel() {
		return idLabel;
	}
	public void setIdLabel(String idLabel) {
		this.idLabel = idLabel;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getGender() {
		return gender;
	}
	public void setGender(String gender) {
		this.gender = gender;
	}
	public String getUniversity() {
		return university;
	}
	public void setUniversity(String university) {
		this.university = university;
	}
	public String getClasses() {
		return classes;
	}
	public void setClasses(String classes) {
		this.classes = classes;
	}
	public int getStatus() {
		return status;
	}
	public void setStatus(int status) {
		this.status = status;
	}
	
}

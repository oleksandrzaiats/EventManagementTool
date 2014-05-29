package com.zayats.model;

import javax.validation.constraints.Size;
import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlRootElement;

import org.hibernate.validator.constraints.Email;
import org.hibernate.validator.constraints.NotEmpty;

@SuppressWarnings("restriction")
@XmlRootElement(name = "user")
public class User {

	private int userId;
	@NotEmpty
	@Size(min = 4, max = 50)
	private String username;
	@NotEmpty
	@Email
	private String email;
	@NotEmpty
	@Size(min = 6, max = 50)
	private String password;
	@NotEmpty
	@Size(max = 50)
	private String firstName;
	@NotEmpty
	@Size(max = 50)
	private String lastName;

	public User() {
	}

	/**
	 * Create new user without role and family
	 * 
	 * @param username
	 * @param email
	 * @param password
	 */
	public User(String username, String email, String password,
			String firstName, String lastName) {
		setUsername(username);
		setEmail(email);
		setPassword(password);
		setFirstName(firstName);
		setLastName(lastName);
	}

	public int getUserId() {
		return userId;
	}

	@XmlElement
	public void setUserId(int userId) {
		this.userId = userId;
	}

	public String getUsername() {
		return username;
	}

	@XmlElement
	public void setUsername(String username) {
		this.username = username;
	}

	public String getEmail() {
		return email;
	}

	@XmlElement
	public void setEmail(String email) {
		this.email = email;
	}

	public String getPassword() {
		return password;
	}

	@XmlElement
	public void setPassword(String password) {
		this.password = password;
	}

	public String getLastName() {
		return lastName;
	}

	@XmlElement
	public void setLastName(String lastName) {
		this.lastName = lastName;
	}

	public String getFirstName() {
		return firstName;
	}

	@XmlElement
	public void setFirstName(String firstName) {
		this.firstName = firstName;
	}
}

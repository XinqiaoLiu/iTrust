<%@page import="edu.ncsu.csc.itrust.action.AddPreregisterPatientAction"%>
<%@page import="edu.ncsu.csc.itrust.exception.FormValidationException"%>
<%@page import="edu.ncsu.csc.itrust.exception.ITrustException"%>

<%@page import="edu.ncsu.csc.itrust.BeanBuilder"%>
<%@page import="edu.ncsu.csc.itrust.beans.PatientBean"%>

<%@include file="/global.jsp"%>

<%
	pageTitle = "iTrust - New patient pre-registration";
%>

<%@include file="/header.jsp"%>

<h1>Patient Preregistration</h1>
<%
	AddPreregisterPatientAction action =  new AddPreregisterPatientAction(prodDAO);
	
	String password = request.getParameter("password");
	String validatePassword = request.getParameter("validatePassword");
	String email = request.getParameter("email");
	Boolean filler = !action.validatePassword(password, validatePassword);
	long mid = 0;
	if (!action.validatePassword(password, validatePassword)){
%>
		<span> The password and the validatePassword do not match </span>
<%
	} else if(!action.validateEmail(email)) {
%>
		<span> Email already exist, please login </span>
<%
	} else if (password != null){
		PatientBean p = new BeanBuilder<PatientBean>().build(request.getParameterMap(), new PatientBean());
		try{
			mid = action.addUser(p, 
				request.getParameter("height").equals("") ? 0 : Double.parseDouble(request.getParameter("height")), 
				request.getParameter("weight").equals("") ? 0 : Double.parseDouble(request.getParameter("weight")),
				Integer.parseInt(request.getParameter("isSmoker")));
		} catch(Exception e){
			out.print(e.toString());
		}
	} 

	if(mid == 0) {

%>
<form id="pg0form" class="needs-validation">
	<h4>Account Information</h4>
	<div class="form-row" style="display: block;">
		<div class="col-md-4 mb-3" style="display: block;">
			<label for="inputFirstname">First name<font color="red"> *</font></label>
			<input type="text" class="form-control" name="firstName" placeholder="First name" required>
		</div>
		<div class="col-md-4 mb-3" style="display: block;">
			<label for="validationServer02">Last name<font color="red"> *</font></label>
			<input type="text" class="form-control" name="lastName" placeholder="Last name" required>
		</div>
		<div class="col-md-4 mb-3" style="display: block;">
			<label for="validationServerEmail">Email<font color="red"> *</font></label>
			<input type="email" class="form-control" name="email" placeholder="Email" required>
		</div>
	</div>
	<div class="form-row" style="display: block;">
		<div class="form-group col-md-6 mb-3" style="display: block;">
			<label for="inputPassword4">Password<font color="red"> *</font></label>
			<input type="password" class="form-control" name="password" placeholder="Password" required>
		</div>
		<div class="form-group col-md-6 mb-3">
			<label for="validatePassword4">Comfirm password<font color="red"> *</font></label>
			<input type="password" class="form-control" name="validatePassword" placeholder="Comfirm password" required>
		</div>
	</div>


   <h4>Contact Information</h4>
	<div class="form-row">
		<div class="col-md-12 mb-3">
			<label for="inputAddress">Phone number</label>
			<input type="number" class="form-control" name="phone" placeholder="0123456789">
		</div>
	</div>
	<div class="form-row">
		<div class="col-md-12 mb-3">
			<label for="inputAddress">Address line 1</label>
			<input type="text" class="form-control" name="streetAddress1" placeholder="1234 Main St">
		</div>
	</div>
	<div class="form-row">
		<div class="col-md-12 mb-3">
			<label for="inputAddress2">Address line 2</label>
			<input type="text" class="form-control" name="streetAddress2" placeholder="Apartment, studio, or floor">
		</div>
	</div>
	<div class="form-row">
		<div class="form-group col-md-6 mb-3">
		<label for="inputCity">City</label>
		<input type="text" class="form-control" name="city">
		</div>
		<div class="form-group col-md-4 mb-3">
		<label for="inputState">State</label>
		<select name="state" class="form-control" id="state">
			<script>
			function addStates() {
				array = ['','AK','AL','AR','AZ','CA','CO','CT','DE','DC','FL','GA',
							'HI','IA','ID','IL','IN','KS','KY','LA','MA','MD','ME',
							'MI','MN','MO','MS','MT','NC','ND','NE','NH','NJ','NM',
							'NV','NY','OH','OK','OR','PA','RI','SC','SD','TN','TX',
							'UT','VA','VT','WA','WI','WV','WY'];
				var select = document.getElementById('state');
				for (var i=0; i<array.length; i++) {
					select.options[select.options.length] = new Option(array[i], i);
				} 
			}
			addStates();
			</script>
		</select>
		</div>
		<div class="form-group col-md-2 mb-3">
		<label for="inputZip">Zip</label>
		<input type="number" class="form-control" name="zip">
		</div>
	</div>

    <h4>Insurance Information</h4>

	<div class="form-row">
		<div class="col-md-12 mb-3">
			<label for="inputAddress">Provider name</label>
			<input type="text" class="form-control" name="icName">
		</div>
	</div>
	<div class="form-row">
		<div class="col-md-12 mb-3">
			<label for="inputAddress">Insurance phone number</label>
			<input type="number" class="form-control" name="icPhone" placeholder="0123456789">
		</div>
	</div>
	<div class="form-row">
		<div class="col-md-12 mb-3">
			<label for="inputAddress">Insurance address line 1</label>
			<input type="text" class="form-control" name="icAddress1" placeholder="1234 Main St">
		</div>
	</div>
	<div class="form-row">
		<div class="col-md-12 mb-3">
			<label for="inputAddress2">Insurance address line 2</label>
			<input type="text" class="form-control" name="icAddress2" placeholder="Apartment, studio, or floor">
		</div>
	</div>
	<div class="form-row">
		<div class="form-group col-md-6 mb-3">
		<label for="inputCity">City</label>
		<input type="text" class="form-control" name="icCity">
		</div>
		<div class="form-group col-md-4 mb-3">
		<label for="inputState">State</label>
		<select name="ICState" class="form-control" id="icState">
			<script>
			function addStates() {
				array = ['','AK','AL','AR','AZ','CA','CO','CT','DE','DC','FL','GA',
							'HI','IA','ID','IL','IN','KS','KY','LA','MA','MD','ME',
							'MI','MN','MO','MS','MT','NC','ND','NE','NH','NJ','NM',
							'NV','NY','OH','OK','OR','PA','RI','SC','SD','TN','TX',
							'UT','VA','VT','WA','WI','WV','WY'];
				var select = document.getElementById('icState');
				for (var i=0; i<array.length; i++) {
					select.options[select.options.length] = new Option(array[i], i);
				} 
			}
			addStates();
			</script>
		</select>
		</div>
		<div class="form-group col-md-2 mb-3">
		<label for="inputZip">Zip</label>
		<input type="number" class="form-control" name="icZip">
		</div>
	</div>

	<h4>Health Information</h4>
	<div class="form-row">
		<div class="col-md-4 mb-3">
			<label for="validationServer01">Height</label>
			<input type="number"  step="0.01" class="form-control" name="height" placeholder="cm">
		</div>
		<div class="col-md-4 mb-3">
			<label for="validationServer02">Weight</label>
			<input type="number"  step="0.01" class="form-control" name="weight" placeholder="lbs">
		</div>
		<div class="col-md-4 mb-3">
			<label for="validationServerEmail">Smoker?</label>
			<select name="isSmoker" class="form-control">
				<option selected value="9">Unknown if ever smoked</option>
				<option value="1">Current every day smoker</option>
				<option value="2">Current some day smoker</option>
				<option value="3">Former smoker</option>
				<option value="4">Never smoker</option>
				<option value="5">Just a smoker</option>
			</select>
		</div>
	</div>

	<button type="submit" class="btn btn-primary" style="margin-top:20px; float:left; width:99%;">Register</button>
</form>
<%
	} else {
%>
		<h4>Register complete</h4>
		<span> Please remember your MID : <b><%= mid %></b> </span>
<%
	}
%>


<%@include file="/footer.jsp" %>
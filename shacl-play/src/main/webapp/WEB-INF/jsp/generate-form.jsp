<!DOCTYPE html>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<!-- setup the locale for the messages based on the language in the session -->
<fmt:setLocale
	value="${sessionScope['fr.sparna.rdf.shacl.shaclplay.SessionData'].userLocale.language}" />
<fmt:setBundle basename="fr.sparna.rdf.shacl.shaclplay.i18n.shaclplay" />

<c:set var="data" value="${requestScope['ConvertFormData']}" />

<html>
	<head>
		<title><fmt:message key="window.app" /></title>

		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		
		<!-- Font Awesome -->
		<link rel="stylesheet" href="<c:url value="/resources/fa/css/all.min.css" />">
		
		<link rel="stylesheet" href="<c:url value="/resources/MDB-Free/css/bootstrap.min.css" />">
		<link rel="stylesheet" href="<c:url value="/resources/MDB-Free/css/mdb.min.css" />">
		<link rel="stylesheet" href="<c:url value="/resources/jasny-bootstrap/jasny-bootstrap.min.css" />" />
		<link rel="stylesheet" href="<c:url value="/resources/css/shacl-play.css" />" />
		
		<script type="text/javascript">
	
			function enabledShapeInput(selected) {
				document.getElementById('shapesSource-' + selected).checked = true;
				document.getElementById('inputShapeUrl').disabled = selected != 'inputShapeUrl';
				//document.getElementById('inputShapeCatalog').disabled = selected != 'inputShapeCatalog';
				document.getElementById('inputShapeFile').disabled = selected != 'inputShapeFile';
				//document.getElementById('inputShapeInline').disabled = selected != 'inputShapeInline';
				
			}
		</script>


	</head>
	<body>

		<jsp:include page="navbar.jsp">
			<jsp:param name="active" value="generate" />
		</jsp:include>

		<div class="container-fluid">
			<div class="row justify-content-md-center">
				<div class="col-6">
					<div class="messages">
						<c:if test="${not empty data.errorMessage}">
							<div class="alert alert-danger" role="alert">
								<button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>
								Error
								${data.errorMessage}
							</div>
						</c:if>
					</div>
					
					<h1 class="display-3"><fmt:message key="generate.title" /></h1>
					
					<form id="upload_form" action="generate" method="POST" enctype="multipart/form-data" class="form-horizontal">
						<h2><i class="fal fa-shapes"></i>&nbsp;&nbsp;<fmt:message key="generate.shapes.title" /></h2>
						
						<blockquote class="blockquote bq-primary">
							
							<div class="form-group row">
								<label for="inputShapeFile" class="col-sm-3 col-form-label">
							    
							    	<input
											type="radio"
											name="shapesSource"
											id="shapesSource-inputShapeFile"
											value="file"
											checked="checked"
											onchange="enabledShapeInput('inputShapeFile')" />
							    	<fmt:message key="generate.shapes.upload" />
							    
							    </label>
							    <div class="col-sm-9">
							    		<div class="fileinput fileinput-new input-group" data-provides="fileinput">
										  <div class="form-control" data-trigger="fileinput" id="inputShapeFile">
										    <i class="fal fa-upload"></i><span class="fileinput-filename with-icon"></span>
										  </div>
										  <span class="input-group-append">
										    <span class="input-group-text fileinput-exists" data-dismiss="fileinput">
										      <fmt:message key="generate.shapes.upload.remove" />
										    </span>
										
										    <span class="input-group-text btn-file">
										      <span class="fileinput-new"><fmt:message key="generate.shapes.upload.select" /></span>
										      <span class="fileinput-exists"><fmt:message key="generate.shapes.upload.change" /></span>
										      <input type="file" name="inputShapeFile" multiple onchange="enabledShapeInput('inputShapeFile')">
										    </span>
										  </span>
										</div>
										<small class="form-text text-muted">
											  <fmt:message key="generate.shapes.upload.help" />
									  </small>
							    </div>
							</div>
							
							<!--  URL -->
							<div class="form-group row">
								
							    <label for="inputShapeUrl" class="col-sm-3 col-form-label">
							    	<input
											type="radio"
											name="shapesSource"
											id="sourceShape-inputShapeUrl"
											value="url"
											onchange="enabledShapeInput('inputShapeUrl')" />
							    	<fmt:message key="generate.shapes.url" />
							    </label>
							    <div class="col-sm-9">
							      <input 
							      	type="text"
							      	class="form-control"
							      	id="inputShapeUrl"
							      	name="inputShapeUrl"
							      	placeholder="<fmt:message key="generate.shapes.url.placeholder" />"
							      	onkeypress="enabledShapeInput('inputShapeUrl');"
							      	onchange="enabledShapeInput('inputShapeUrl')"
							      >
							      <small class="form-text text-muted">
									  <fmt:message key="generate.shapes.url.help" />
							    </small>
							    </div>
							  </div>
							   
						</blockquote>
						
						<h2><i class="fal fa-tools"></i>&nbsp;&nbsp;<fmt:message key="convert.options.title" /></h2>
				      	<blockquote class="blockquote bq-warning">
					      
					      <div class="form-group row">
					      	<div class="col-sm-9">
								<label for="inputShapeCatalog" class="col-sm-3 col-form-label">
									<fmt:message key="generate.options.format" />					    
								</label>
							    <div class="col-sm-4">
						    		<select class="form-control" id="format" name="format" >
						    			<option value="Turtle">Turtle</option>
						    			<option value="RDF/XML">RDF/XML</option>
						    			<option value="N-Triples">N-Triples</option>
						    			<option value="N-Quads">N-Quads</option>
						    			<option value="N3">N3</option>
						    			<option value="TriG">TriG</option>
						    			<option value="JSON-LD">Json-LD</option>
									</select>
								</div>
							</div>
						</div>
						  
						  	<!-- Option count ocurrences -->
						 <div class="form-group row"> 	
						  	<div class="form-group row">
						      	<div class="col-sm-12">
							      	<div class="form-check">
									  <input class="form-check-input col-sm-2" type="checkbox" id="Ocurrencesinstances" name="Ocurrencesinstances" onclick='chkbOIClick(this)' />
									  <label class="col-sm-12 form-check-label" for="Ocurrencesinstances">
									    <fmt:message key="generate.options.Ocurrencesinstances" />
									  </label>
									  <small class="form-text text-muted">
										<fmt:message key="generate.options.Ocurrencesinstances.help" />
									  </small>
									</div>
								</div>
							</div>						  
						  </div>						  
					  	</blockquote>
						
						<button type="submit" id="validate-button" class="btn btn-info btn-lg"><fmt:message key="generate.submit" /></button>
					</form>					
				</div>
			</div>
		</div>
		<!-- /.container-fluid -->


		<jsp:include page="footer.jsp"></jsp:include>

		<!-- SCRIPTS -->
		<!-- JQuery -->
		<script type="text/javascript" src="<c:url value="/resources/MDB-Free/js/jquery.min.js" />"></script>
		<!-- Bootstrap tooltips -->
		<script type="text/javascript" src="<c:url value="/resources/MDB-Free/js/popper.min.js" />"></script>
		<!-- Bootstrap core JavaScript -->
		<script type="text/javascript" src="<c:url value="/resources/MDB-Free/js/bootstrap.min.js" />"></script>
		<!-- MDB core JavaScript -->
		<script type="text/javascript" src="<c:url value="/resources/MDB-Free/js/mdb.min.js" />"></script>
	
		<script type="text/javascript"src="<c:url value="/resources/jasny-bootstrap/jasny-bootstrap.min.js" />"></script>


		<script>
			$(document).ready(function() {
				$('#htmlOrRdf a').click(function(e) {
					e.preventDefault();
					$(this).tab('show')
				});
	
				// Initialize CodeMirror editor and the update callbacks
				var sourceText = document.getElementById('text');
				var editorOptions = {
					mode : 'text/html',
					tabMode : 'indent'
				};
	
				// CodeMirror commented for now
				// var editor = CodeMirror.fromTextArea(sourceText, editorOptions);
				// editor.on("change", function(cm, event) { enabledInput('text'); });
			});
		</script>

	</body>
</html>
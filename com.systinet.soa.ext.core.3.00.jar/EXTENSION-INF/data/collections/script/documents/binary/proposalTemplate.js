///////////////////////////////////////////////////////
// Initial architecture setup for a proposal artifact 

/**
 * Creates architecture elements for a proposal. The architecture elements are:
 * <ul>
 *   <li>plateau in the same package and including the package itself</li>
 *   <li>architecture diagram created in the same package</li>
 *   <li>requirements diagram created in Requirements sub-package</li>
 * </ul>
 * 
 * 
 * @param artifactUuid proposal artifact UUID
 * @param artifactName artifact name, optional
 * @param package proposal package
 *  
 */
function createArchitecture(artifactUuid, artifactName, packageName) {
	// keep track all newly created artifacts so they can be purged on errors
	var createdArtifactUuids = [];
	try {
		var proposal = repositoryService.getArtifact(UUID.toUuid(artifactUuid), ArtifactPartSelector.ALL_PROPERTIES);
                if(scriptEnvironmentUtils.hasPackage(proposal, packageName)) {
                  return { error: "The package name '" + packageName + "' is already in use, please choose another name" };
             	}
		var domainId = proposal.getStringProperty('_domainId');
		if (!artifactName || artifactName === '') artifactName = proposal.getName();
		
		// 1. plateau        
		var plateau = _createArtifactWithPackage('plateauArtifact', artifactName, packageName, createdArtifactUuids, domainId);
		plateau = scriptEnvironmentUtils.assignPackages(plateau, packageName); // package elements are included to the plateau
		plateau = _relation(plateau, 'realizes', proposal);

		// 2. Requirements Diagram
		var diagram1 = _createArtifactWithPackage('diagramArtifact', 'Requirements of ' + artifactName, packageName + "/Requirements", createdArtifactUuids, domainId);
		_createRequirementsDiagram(packageName + "/Requirements", diagram1, plateau, proposal);
		
		// 3. Architecture Diagram
		var diagram2 = _createArtifactWithPackage('diagramArtifact', 'Architecture of ' + artifactName, packageName, createdArtifactUuids, domainId);
		_createArchitectureDiagram(packageName, diagram2, plateau, proposal);

		// 4. set package of the proposal
		proposal = scriptEnvironmentUtils.setPackage(proposal, packageName);
	} catch (e) {
		log.error(e);
		if(e.rhinoException != null){ e.rhinoException.printStackTrace(); }
		else if(e.javaException != null){ e.javaException.printStackTrace();}
		// Rollback created artifacts in reverse order
		if (createdArtifactUuids.length > 0) {
			for ( var idx = createdArtifactUuids.length -1; idx >=0; idx--) {
				try {
					repositoryService.purgeArtifact(UUID.toUuid(createdArtifactUuids[idx]));
				} catch (e) {
					// ignore this kind of exception, let's move on to another artifact
				}
			}
		}
		
	}
}

//////////////////////////////////////////////
// Internal Functions                       //
//////////////////////////////////////////////

/**
 * Creates artifact with given name and under package.
 * 
 * @param artifactSdmName artifact sdm name
 * @param artifactName name of artifact
 * @param artifactPackage package of artifact
 * @param createdArtifactUuids UUIDs of session-created artifacts
 * @returns created artifact
 */
function _createArtifactWithPackage(artifactSdmName, artifactName, artifactPackage, createdArtifactUuids, domainId) {
	var artifact = artifactFactory.newArtifact(artifactSdmName);
	artifact.setName(artifactName);
	artifact = repositoryService.createArtifact(artifact, null, domainId);
	
	// track its uuid if it creates successfully.
	createdArtifactUuids.push(artifact.get_uuid().toString());
	
	// set package
	scriptEnvironmentUtils.setPackage(artifact, artifactPackage);

	return artifact;
}

/**
 * Creates outgoing relationship
 * @param fromArtifact source
 * @param relationName relationship name
 * @param toArtifact target
 */
function _relation(fromArtifact, relationName, toArtifact) {
	fromArtifact = repositoryService.getArtifact(fromArtifact.get_uuid(), ArtifactPartSelector.ALL_PROPERTIES);
	fromArtifact.addRelationProperty(relationName, toArtifact.get_uuid());
	repositoryService.updateArtifact(fromArtifact);
	return fromArtifact;
}


/**
 * Creates requirements diagram.
 */
function _createRequirementsDiagram(packageName, diagramArtifact, plateauArtifact, proposalArtifact){
	// value content template
	var result = {"artifacts":{"value":[]},"connectors":{"value":[]},"locationPath":{"value":packageName},"viewport":{"value":"850,1098,100"}};
	
	result.artifacts.value.push({ // add diagram header
		"localName":"sparx_Text",
		"name":"","stereoType":"",
		"left":20,"right":900,"top":20,"bottom":100,
		"elementId":"h_"+proposalArtifact.get_uuid(),
		"notes":"<b>"+proposalArtifact.getName()+" - Requirement Analysis</b>",
		"style":"{font:'Arial Narrow',fontWeight:false,fontStyle:'normal',fontSize:200}",
		"sparxStyle":"DUID=1285B639;font=Arial Narrow;fontsz=280;bold=0;black=0;italic=0;ul=0;charset=0;pitch=34;",
		"renderIndex":3,
		"locationPath":packageName});
	result.artifacts.value.push({ // add diagram notes
		"localName":"sparx_Note",
		"name":"","stereoType":"",
		"left":20,"right":500,"top":130,"bottom":200,
		"elementId":"n_"+proposalArtifact.get_uuid(),
		"notes":"<font color=\"#0000ff\">"+proposalArtifact.getName()+"</font> proposal is decomposed herein into a tree of requirements. All requirements contained in the diagram are also automatically aggregated into <font color=\"#0000ff\">"+plateauArtifact.getName()+"</font> plateau so that they are part of a named architecture state."+
		        "\r\n\r\nThis note was automatically generated by HP Enterprise Maps.",
		"style":"",
		"sparxStyle":"DUID=324F61F3;",
		"renderIndex":2,
		"locationPath":packageName});
	result.artifacts.value.push({ // add proposal artifact
	    "localName":proposalArtifact.get_artifactSdmName(),
	    "name":proposalArtifact.getName(),"stereoType":"ArchiMate_Requirement",
	    "left":42,"right":182,"top":276,"bottom":346,
	    "uuid":proposalArtifact.get_uuid().toString(),
	    "sparxStyle":"DUID=96992A83;UCRect=1;",
	    "renderIndex":1});	
	
	// upload content of the diagram
	diagramArtifact = _updateDiagramContent(result, diagramArtifact);
	
	// assign contained artifacts to created diagram
	diagramArtifact = _relation(diagramArtifact, 'assignedFrom', proposalArtifact);

	return diagramArtifact;
}

/**
 * Creates architecture diagram.
 */
function _createArchitectureDiagram(packageName, diagramArtifact, plateauArtifact, proposalArtifact){
	// value content template
	var result = {"artifacts":{"value":[]},"connectors":{"value":[]},"locationPath":{"value":packageName},"viewport":{"value":"850,1098,100"}};
	
	result.artifacts.value.push({ // add diagram header
		"localName":"sparx_Text",
		"name":"","stereoType":"",
		"left":20,"right":900,"top":20,"bottom":100,
		"elementId":"h_"+plateauArtifact.get_uuid(),
		"notes":"<b>"+proposalArtifact.getName()+" - High-level Design</b>",
		"style":"{font:'Arial Narrow',fontWeight:false,fontStyle:'normal',fontSize:200}",
		"sparxStyle":"DUID=3E38EAF5;font=Arial Narrow;fontsz=280;bold=0;black=0;italic=0;ul=0;charset=0;pitch=34;",
		"renderIndex":1,
		"locationPath":packageName});
	result.artifacts.value.push({ // add diagram notes
		"localName":"sparx_Note",
		"name":"","stereoType":"",
		"left":20,"right":500,"top":130,"bottom":200,
		"elementId":"n_"+plateauArtifact.get_uuid(),
		"notes":"This diagram models architecture of <font color=\"#0000ff\">"+proposalArtifact.getName()+"</font> proposal. All elements contained in it are aggregated into <font color=\"#0000ff\">"+plateauArtifact.getName()+"</font> plateau so that they are part of a named architecture state."+
		        "\r\n\r\nThis note was automatically generated by HP Enterprise Maps.",
		"style":"",
		"sparxStyle":"DUID=640072FE;",
		"renderIndex":2,
		"locationPath":packageName});
	
	// update diagram content
	diagramArtifact = _updateDiagramContent(result, diagramArtifact);
	
	return diagramArtifact;
}

function _updateDiagramContent(json, diagramArtifact){
	var dataString = com.hp.systinet.sc.ui.scripting.dataService.JSScript.stringify(this, json);
	
	// upload content of the diagram
	diagramArtifact = repositoryService.getArtifact(diagramArtifact.get_uuid(), ArtifactPartSelector.ALL_PROPERTIES);
	var location = Packages.java.lang.String.format("/%s/%s", diagramArtifact.get_domainId(), diagramArtifact.getName().replaceAll("[^a-zA-Z0-9_]", "")) + '-' + new Date().getTime();
	diagramArtifact.setStringProperty("location", location);
	diagramArtifact.setStringProperty("contentType","application/json");
	diagramArtifact.setStringProperty("r_filename", diagramArtifact.getName() + ".json");
	var data = valuesFactory.newArtifactData(new Packages.java.io.ByteArrayInputStream(dataString.toString().getBytes("UTF-8")), "application/json");
	var command = new Packages.com.hp.systinet.repository.command.UpdateCommand(diagramArtifact);
	command.setArtifactData(data);
	diagramArtifact = repositoryService.updateArtifact(command);
	
	return diagramArtifact;
}
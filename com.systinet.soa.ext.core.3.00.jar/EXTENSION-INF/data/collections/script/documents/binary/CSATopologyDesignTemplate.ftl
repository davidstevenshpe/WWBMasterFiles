{ 
	"@type" : "urn:x-hp:2013:software:cloud:topology_model:topology",
	"groupId" : "com.hp.csa",   
	"artifactId" : "${csaArtifactId}",
	"version" : "1.0.0",
	"displayName" : "${serviceDesignName}",
	"resources" : [
<#if appComps?has_content>
	<#list appComps as appComp>
		{
			"id" : "${appComp.id}",
			"name" : "${appComp.name}",
			"component" : {
		<#if appComp.externalUuid??>
			"@self" : "/csa/api/topology-model/component-type/${appComp.externalUuid}"
		</#if>
			},
			
			<#-- List properties of component -->
			<#if appComp.properties??>
			     "properties" : ${appComp.properties},
			<#else>
			     "properties" : [],
			</#if>
			
			"outgoingRelations" : [
			<#if appComp.relationNodes?has_content>				
			<#list appComp.relationNodes as node>
				<#if node.relationshipId != ''>
				{
					"relationType" : "association",
					"id" : "${node.randomUuid}",
					"properties" : [{
						"propertyKey" : "_enable_modify_during_lifecycle_properties",
						"propertyValue" : {
							"value" : null,
							"type" : "string"
						}
					}, {
						"propertyKey" : "_modifiable_properties",
						"propertyValue" : {
							"value" : null,
							"type" : "string"
						}
					}, {
						"propertyKey" : "_relation_type",
						"propertyValue" : {
						"value" : {
							"first" : "Association",
							"second" : "ASSOCIATION"
						},
						"type" : "pair"
			        }
					}],
					<#--
						relationshipId: This is the most important field to specify the relationship between source component type and target data center.
						This value is queried by EM's code. We will get the csa definition of current component type (e.g. ASAC, Docker File), then get the corresponding target relation type (e.g. AmazonServerType, OpenStackServerType) and fill its id to this value.
						Its format is '${relationName}_${appComp.artifactId}__VERSION_${versionNumner}'  (e.g. runningOn_ASAC_89e1138b0e1f4daab63cd8d22b9f7a16__VERSION__1^0)
						If user already knows this value, he can fill it to template directly. But remember that it's also applied to another component type because the value is static.
					-->
					"relationDescriptorName" : "${node.relationshipId}",
					"resourceReference" : {
						"name" : "${node.targetNodeName}"
					}
				}
				<#if node_has_next>,
				</#if>
				</#if>
			</#list>
			</#if>
			],
			"annotations" : {
				<#--Calculate coordinator dynamically to avoid overlaping node-->
				"x": ${(200 * (appComp_index+1))?c},
				"y": 50
			},
			"capabilityChars" : [ ],
			"requirements" : [ ]
		}
		<#if appComp_has_next>,
		</#if>
	</#list>
</#if>
<#if sysSoftware?has_content>
    <#if appComps?has_content>
		,
	</#if>
	<#list sysSoftware as sysSoft>
		{
			"id" : "${sysSoft.id}",
			"name" : "${sysSoft.name}",
			"component" : {
		<#if sysSoft.externalUuid??>
			"@self" : "/csa/api/topology-model/component-type/${sysSoft.externalUuid}"
		</#if>
			},
			
			<#-- List properties of component -->
            <#if sysSoft.properties??>
                 "properties" : ${sysSoft.properties},
            <#else>
                 "properties" : [],
            </#if>
            
			"outgoingRelations" : [			
			<#if sysSoft.relationNodes?has_content>
			<#list sysSoft.relationNodes as node>
				<#if node.relationshipId!=''>
				{
					"relationType" : "association",
					"id" : "${node.randomUuid}",
					"properties" : [{
						"propertyKey" : "_enable_modify_during_lifecycle_properties",
						"propertyValue" : {
							"value" : null,
							"type" : "string"
						}
					}, {
						"propertyKey" : "_modifiable_properties",
						"propertyValue" : {
							"value" : null,
							"type" : "string"
						}
					}, {
						"propertyKey" : "_relation_type",
						"propertyValue" : {
						"value" : {
							"first" : "Association",
							"second" : "ASSOCIATION"
						},
						"type" : "pair"
			        }
					}],
					<#--
						relationDescriptorName: This is the most important field to specify the relationship between source component type and target data center.
						This value is queried by EM's code. We will get the csa definition of current component type (e.g. ASAC, Docker File), then get the corresponding target relation type (e.g. AmazonServerType, OpenStackServerType) and fill its id to this value.
						Its format is '${relationName}_${sysSoft.artifactId}__VERSION_${versionNumner}'  (e.g. runningOn_ASAC_89e1138b0e1f4daab63cd8d22b9f7a16__VERSION__1^0)
						If user already knows this value, he can fill it to template directly. But remember that it's also applied to another component type because the value is static.
					-->
					"relationDescriptorName" : "${node.relationshipId}",
					"resourceReference" : {
						"name" : "${node.targetNodeName}"
					}
				}
				<#if node_has_next>,
				</#if>
				</#if>
			</#list>
			</#if>
			],
			"annotations" : {
				<#--Calculate coordinator dynamically to avoid overlapinging node-->
				"x": ${(200*(sysSoft_index+1))?c},
				"y": 650
			},
			"capabilityChars" : [ ],
			"requirements" : [ ]
		}
		<#if sysSoft_has_next>,
		</#if>
	</#list>
</#if>
<#if servers?has_content>  
	<#list servers as server>
		<#if server.dataCenter?contains('Amazon') || server.dataCenter?contains('AWS') || server.dataCenter?contains('VMware') || server.dataCenter?contains('vCenter') || server.dataCenter?contains('HP Cloud')>
		    <#if (appComps?has_content || sysSoftware?has_content) || (server_index > 0)>
		      ,
		    </#if>
		</#if>
		<#if server.dataCenter?contains('Amazon') || server.dataCenter?contains('AWS')>
  		{
		    "id" : "${server.id}",
		    "name" : "${server.name}",
		    "component" : {
				"groupId" : "com.hp.csa.type",
				"artifactId" : "AmazonServerType",
				"version" : "15.07.0000"
		    },
			
			<#-- List properties of server -->
            <#if server.properties??>
                 "properties" : ${server.properties},
            <#else>
                 "properties" : [],
            </#if>
            
			"outgoingRelations" : [
			<#if server.relationNodes?has_content>				
			<#list server.relationNodes as node>
				<#if node.relationshipId != ''>
				{
					"relationType" : "association",
					"id" : "${node.randomUuid}",
					"properties" : [{
						"propertyKey" : "_enable_modify_during_lifecycle_properties",
						"propertyValue" : {
							"value" : null,
							"type" : "string"
						}
					}, {
						"propertyKey" : "_modifiable_properties",
						"propertyValue" : {
							"value" : null,
							"type" : "string"
						}
					}, {
						"propertyKey" : "_relation_type",
						"propertyValue" : {
						"value" : {
							"first" : "Association",
							"second" : "ASSOCIATION"
						},
						"type" : "pair"
			        }
					}],
					<#--
						relationshipId: This is the most important field to specify the relationship between source component type and target data center.
						This value is queried by EM's code. We will get the csa definition of current component type (e.g. ASAC, Docker File), then get the corresponding target relation type (e.g. AmazonServerType, OpenStackServerType) and fill its id to this value.
						Its format is '${relationName}_${server.artifactId}__VERSION_${versionNumner}'  (e.g. runningOn_ASAC_89e1138b0e1f4daab63cd8d22b9f7a16__VERSION__1^0)
						If user already knows this value, he can fill it to template directly. But remember that it's also applied to another component type because the value is static.
					-->
					"relationDescriptorName" : "${node.relationshipId}",
					"resourceReference" : {
						"name" : "${node.targetNodeName}"
					}
				}
				<#if node_has_next>,
				</#if>
				</#if>
			</#list>
			</#if>
			],
			"annotations" : {
			  "uniqueName" : "${server.name}",
			  "displayName" : "Amazon Server ",			  
			  "description" : "Amazon Server",
			  <#--Calculate coordinator dynamically to avoid overlaping node-->
			  "x": ${(200 * (server_index+1))?c},
			  "y": 350
			},
			"capabilityChars" : [ ],
			"requirements" : [ ]
		}			
		
		<#elseif server.dataCenter?contains('VMware') || server.dataCenter?contains('vCenter')>
			{
				"id" : "${server.id}",
				"name" : "${server.name}",
				"component" : {
					"groupId" : "com.hp.csa.type",
					"artifactId" : "VcenterServerType",
					"version" : "15.07.0000"
				},
				
				<#-- List properties of server -->
	            <#if server.properties??>
	                 "properties" : ${server.properties},
	            <#else>
	                 "properties" : [],
	            </#if>
	            
				"outgoingRelations" : [
				<#if server.relationNodes?has_content>				
				<#list server.relationNodes as node>
					<#if node.relationshipId != ''>
					{
						"relationType" : "association",
						"id" : "${node.randomUuid}",
						"properties" : [{
							"propertyKey" : "_enable_modify_during_lifecycle_properties",
							"propertyValue" : {
								"value" : null,
								"type" : "string"
							}
						}, {
							"propertyKey" : "_modifiable_properties",
							"propertyValue" : {
								"value" : null,
								"type" : "string"
							}
						}, {
							"propertyKey" : "_relation_type",
							"propertyValue" : {
							"value" : {
								"first" : "Association",
								"second" : "ASSOCIATION"
							},
							"type" : "pair"
				        }
						}],
						<#--
							relationshipId: This is the most important field to specify the relationship between source component type and target data center.
							This value is queried by EM's code. We will get the csa definition of current component type (e.g. ASAC, Docker File), then get the corresponding target relation type (e.g. AmazonServerType, OpenStackServerType) and fill its id to this value.
							Its format is '${relationName}_${server.artifactId}__VERSION_${versionNumner}'  (e.g. runningOn_ASAC_89e1138b0e1f4daab63cd8d22b9f7a16__VERSION__1^0)
							If user already knows this value, he can fill it to template directly. But remember that it's also applied to another component type because the value is static.
						-->
						"relationDescriptorName" : "${node.relationshipId}",
						"resourceReference" : {
							"name" : "${node.targetNodeName}"
						}
					}
					<#if node_has_next>,
					</#if>
					</#if>
				</#list>
				</#if>
				],
				"annotations" : {
				  "uniqueName" : "${server.name}",
				  "displayName" : "vCenter Server",
				  "description" : "vCenter Server",
				  <#--Calculate coordinator dynamically to avoid overlaping node-->
				  "x": ${(200 * (server_index+1))?c},
				  "y": 350 
				},
				"capabilityChars" : [ ],
				"requirements" : [ ]
			}
		
		<#elseif server.dataCenter?contains('HP Cloud')>
			{
				"id" : "${server.id}",
				"name" : "${server.name}",
				"component" : {
					"groupId" : "com.hp.csa.type",
					"artifactId" : "OpenStackServerType",
					"version" : "15.07.0000"
				},
				
				<#-- List properties of server -->
	            <#if server.properties??>
	                 "properties" : ${server.properties},
	            <#else>
	                 "properties" : [],
	            </#if>
	            							
				"outgoingRelations" : [
				<#if server.relationNodes?has_content>				
				<#list server.relationNodes as node>
					<#if node.relationshipId != ''>
					{
						"relationType" : "association",
						"id" : "${node.randomUuid}",
						"properties" : [{
							"propertyKey" : "_enable_modify_during_lifecycle_properties",
							"propertyValue" : {
								"value" : null,
								"type" : "string"
							}
						}, {
							"propertyKey" : "_modifiable_properties",
							"propertyValue" : {
								"value" : null,
								"type" : "string"
							}
						}, {
							"propertyKey" : "_relation_type",
							"propertyValue" : {
							"value" : {
								"first" : "Association",
								"second" : "ASSOCIATION"
							},
							"type" : "pair"
				        }
						}],
						<#--
							relationshipId: This is the most important field to specify the relationship between source component type and target data center.
							This value is queried by EM's code. We will get the csa definition of current component type (e.g. ASAC, Docker File), then get the corresponding target relation type (e.g. AmazonServerType, OpenStackServerType) and fill its id to this value.
							Its format is '${relationName}_${server.artifactId}__VERSION_${versionNumner}'  (e.g. runningOn_ASAC_89e1138b0e1f4daab63cd8d22b9f7a16__VERSION__1^0)
							If user already knows this value, he can fill it to template directly. But remember that it's also applied to another component type because the value is static.
						-->
						"relationDescriptorName" : "${node.relationshipId}",
						"resourceReference" : {
							"name" : "${node.targetNodeName}"
						}
					}
					<#if node_has_next>,
					</#if>
					</#if>
				</#list>
				</#if>
				],
				"annotations" : {
				  "uniqueName" : "${server.name}",
				  "displayName" : "OpenStack Server",
				  "description" : "Server is a logical component that represents a virtual machine",
				  <#--Calculate coordinator dynamically to avoid overlaping node-->
				  "x": ${(200 * (server_index+1))?c},
				  "y": 350 
				},
				"capabilityChars" : [ ],
				"requirements" : [ ]
			}
		</#if>
	</#list>
</#if>	  
	],  
	"properties" : [],
	"tagIds" : [],
	"state" : "UNLOCKED",
	"hidden" : false,
	"partial" : true,
	"profiles" : []
}
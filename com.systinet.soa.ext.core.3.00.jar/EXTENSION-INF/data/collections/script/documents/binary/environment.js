// Import common packages
importPackage(Packages.com.hp.systinet.repository.sdm.generated.artifacts);
importPackage(Packages.com.hp.systinet.repository.command);
importPackage(Packages.com.hp.systinet.repository.structures);
importPackage(Packages.com.hp.systinet.repository.sdm.propertytypes);
importPackage(Packages.java.util);
importPackage(Packages.com.hp.systinet.dql);
importPackage(Packages.com.hp.systinet.sc.ui.scripting.utils);

// Common variables
System=Packages.java.lang.System;
UUID=Packages.com.hp.systinet.repository.util.PropertiesUtil;
beanFactoryHelper=Packages.com.hp.systinet.spring.BeanFactoryHelper;
repositoryService = environment.getRepositoryService();
artifactFactory = environment.getArtifactFactory();
valuesFactory = environment.getValuesFactory();
queryService = environment.getDqlJsQueryService();
repositoryPreListeners=environment.getScriptedPreEventListener();
repositoryPostListeners=environment.getScriptedPostEventListener();
closureApiFactory=environment.getClosureApiFactory();
scriptExecution=environment.getScriptExecution();
shortcutApi=environment.getShortcutApi();
scriptEnvironmentUtils=environment.getScriptEnvironmentUtils();
artifactRegistry=environment.getArtifactRegistry();
calculatorHelper=environment.getCalculatorHelper();
MODULES = {};
taxonomyApi = Packages.com.systinet.platform.taxonomy.TaxonomyApi.getInstance(com.systinet.platform.security.SecurityManager.getAdminSession());
log=Packages.org.apache.commons.logging.LogFactory.getLog('scripting');

// Functions that call SOAP web services
function callWS(url,requestXml,debug){
    var messageFactory = Packages.javax.xml.soap.MessageFactory.newInstance();
    var request = messageFactory.createMessage();

    var documentBuilderFactory = Packages.javax.xml.parsers.DocumentBuilderFactory.newInstance();
    documentBuilderFactory.setNamespaceAware(true);
    var requestDocument=documentBuilderFactory.newDocumentBuilder().parse(new Packages.java.io.ByteArrayInputStream((new java.lang.String(requestXml)).getBytes()));
    request.getSOAPPart().setContent(new Packages.javax.xml.transform.dom.DOMSource(requestDocument));
    // This is SAAJ standard
    // var connection = Packages.javax.xml.soap.SOAPConnectionFactory.newInstance().createConnection();
    // var response = connection.call(request, new Packages.java.net.URL(url));
    // end of SAAJ standard
    // This is wasp proprietary, but you can debug and setup HTTP Basic
    var serviceClient=Packages.org.systinet.wasp.webservice.ServiceClient.create();
    serviceClient.setServiceURL(url);
    if (debug) serviceClient.getInterceptors().insert(new Packages.com.hp.systinet.proxy.mgmt.impl.WebServiceLoggerInterceptor(),Packages.org.systinet.wasp.webservice.Interceptors.DIRECTION_INOUT);
    var response = Packages.org.systinet.wasp.client.XMLInvocationHelper.call(request, serviceClient,true);
    // end of WASP proprietary
    return response;
}
function callWSHttpBasic(url,username,password,requestXml,debug){
    var messageFactory = Packages.javax.xml.soap.MessageFactory.newInstance();
    var request = messageFactory.createMessage();

    var documentBuilderFactory = Packages.javax.xml.parsers.DocumentBuilderFactory.newInstance();
    documentBuilderFactory.setNamespaceAware(true);
    var requestDocument=documentBuilderFactory.newDocumentBuilder().parse(new Packages.java.io.ByteArrayInputStream((new java.lang.String(requestXml)).getBytes()));
    request.getSOAPPart().setContent(new Packages.javax.xml.transform.dom.DOMSource(requestDocument));
    var serviceClient=Packages.org.systinet.wasp.webservice.ServiceClient.create();
    serviceClient.setServiceURL(url);
    serviceClient.getInterceptors().insert(new Packages.com.hp.systinet.publishing.uddi.facade.HttpBasicInterceptor(username,password),
            Packages.org.systinet.wasp.webservice.Interceptors.DIRECTION_INOUT);
    serviceClient.getContext().getContextData().put("non-preemptive-authorization","true");
    if (debug) serviceClient.getInterceptors().insert(new Packages.com.hp.systinet.proxy.mgmt.impl.WebServiceLoggerInterceptor(),
            Packages.org.systinet.wasp.webservice.Interceptors.DIRECTION_INOUT);
    var response = Packages.org.systinet.wasp.client.XMLInvocationHelper.call(request, serviceClient,true);
    return response;
}
function printSAAJMessage(response){
    var result="&lt;"+response.getElementName().getLocalName();
    var i=response.getAllAttributes();
    while(i.hasNext()) {
        var attr=i.next();
        result+=" "+attr+"='"+response.getAttributeValue(attr)+"'";
    }
    result+="&gt;";
    i=response.getChildElements();
    while(i.hasNext()) {
        var node=i.next();
        if (node instanceof Packages.javax.xml.soap.SOAPElement)
            result+=printSAAJMessage(node);
        if (node instanceof Packages.javax.xml.soap.Text)
            result+=node.getValue();

    }
    result+="&lt;"+response.getElementName().getLocalName()+"/&gt;";
    return result;
}

function setProperty(artifact, propertyName, newValue) {
	scriptEnvironmentUtils.setProperty(artifact, propertyName, newValue);
}
function getPrimitiveValue(artifact, propertyName) {
	return scriptEnvironmentUtils.getPrimitiveValue(artifact, propertyName);
}
function calculateScores(operator, surveyDefinitionUuid, art, scores) {
	return calculatorHelper.calculateScores(operator, surveyDefinitionUuid, art, scores);
}
function calculate(operator, art, properties) {
	return calculatorHelper.calculate(operator, art, properties);
}
function calculateGroup(operator, art, propertyGroup) {
	return calculatorHelper.calculateGroup(operator, art, propertyGroup);
}

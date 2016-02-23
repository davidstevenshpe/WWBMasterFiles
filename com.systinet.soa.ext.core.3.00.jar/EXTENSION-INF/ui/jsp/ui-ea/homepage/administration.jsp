<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>

<syswf:component name="/homepage/tip" prefix="viewpointTip">
    <syswf:param name="title">Custom viewpoint definition</syswf:param>
    <syswf:param name="id">tip.viewpoints</syswf:param>
    <syswf:param name="content">
        You can define custom graphical view points (as you can see the ArchiMate Introductory Viewpoint on the
        home page of the reports tab) to be able to perform impact/dependency analysis between objects you
        are interested in.
        <br/>
        <br/>
        <strong><a href="http://inkscape.org/en/download/windows/">Download and install Inkscape</a></strong>
        <br/>
        <br/>
        And then you will have to:
        <br/>
        <br/>
        <strong>
            <syswf:component prefix="download.vp" name="/homepage/downloadLink">
                <syswf:param name="title">Download and install HP EM extension for Inkscape</syswf:param>
                <syswf:param name="filePrefix">hp-em-inkscape-</syswf:param>
                <syswf:param name="fileSuffix">.msi</syswf:param>
            </syswf:component>
        </strong>
    </syswf:param>
</syswf:component>

<syswf:component name="/homepage/tip" prefix="datamodelTip">
    <syswf:param name="title">Data model customization</syswf:param>
    <syswf:param name="id">tip.datamodel</syswf:param>
    <syswf:param name="content">
        You can define new artifacts in the catalog. You may also add properties to the existing artifacts. To do that
        you will need to:
        <br/><br/>
        <strong>
            <syswf:component prefix="download.wb2" name="/homepage/downloadLink">
                <syswf:param name="title">Download and install HP EM Workbench</syswf:param>
                <syswf:param name="filePrefix">hp-em-workbench-</syswf:param>
                <syswf:param name="fileSuffix">-win64.zip</syswf:param>
            </syswf:component>
        </strong>
        <br/>
        Then you can build and deploy a data model extension for HP EM.
    </syswf:param>
</syswf:component>

<syswf:component name="/homepage/tip" prefix="assertionsTip">
    <syswf:param name="title">Defining new policy Assertions</syswf:param>
    <syswf:param name="id">tip.assertions</syswf:param>
    <syswf:param name="content">
        You can define new <syswf:control id="adm5" mode="anchor" caption="policy assertions" targetTask="/admin/browseArtifact"><syswf:param name="artifactType">assertionArtifact</syswf:param></syswf:control>
        policy assertions - these are small programs written in Javascript or XQuery that are checking data consistency
        of the catalog. You can use them in reporting or for lifecycle approval conditions. To define a new assertion you need to:
        <br/>
        <br/>
        <strong>
            <syswf:component prefix="download.wb1" name="/homepage/downloadLink">
                <syswf:param name="title">Download and install HP EM Workbench</syswf:param>
                <syswf:param name="filePrefix">hp-em-workbench-</syswf:param>
                <syswf:param name="fileSuffix">-win64.zip</syswf:param>
            </syswf:component>
        </strong>
    </syswf:param>
</syswf:component>

<syswf:component name="/homepage/tip" prefix="csvImportTip">
    <syswf:param name="title">Spreadsheet Import & Export</syswf:param>
    <syswf:param name="id">tip.csv</syswf:param>
    <syswf:param name="content">
        You can upload data you prepared in <a class="tip-link" href="https://en.wikipedia.org/wiki/Microsoft_Excel#File_formats">XLS</a>/<a class="tip-link" href="https://en.wikipedia.org/wiki/Office_Open_XML">XLSX</a>/<a class="tip-link" href="http://en.wikipedia.org/wiki/Comma-separated_values">CSV</a> files directly into HP EM - just follow this <syswf:control id="adm52" mode="anchor" caption="link." targetTask="/common/imports/csvImport"/>
        <br/>
        <br/>
        You can also import the files into HP EM from command line.
        <br/>
        <br/>
        CSV importer tool is preinstalled together with HP EM in the following location:
        <br/>
        <br/>
        INSTALL_DIR\client\bin\csvImport.bat[sh]
        <br/>
        <br/>
        If the installation is not accesible, you can:
        <br/>
        <strong>
            <syswf:component prefix="download.csv" name="/homepage/downloadLink">
                <syswf:param name="title">Download CSV importer tool</syswf:param>
                <syswf:param name="filePrefix">hp-em-cmd-tools-</syswf:param>
                <syswf:param name="fileSuffix">.zip</syswf:param>
            </syswf:component>
        </strong>
        <br/>
        HP EM can export data in CSV format via context action when you open specified artifact collection.
    </syswf:param>
</syswf:component>
<syswf:component name="/homepage/tip" prefix="cmdb">
    <syswf:param name="title">CMDB Integration</syswf:param>
    <syswf:param name="id">tip.cmdb</syswf:param>
    <syswf:param name="content">
        To be able to analyze the costs, impact and dependencies of your IT infrastructure on your business, you can integrate HP EM with a
        <a class="tip-link" href="http://en.wikipedia.org/wiki/Configuration_management_database">Configuration Management Database (CMDB)</a>.
        <br/>
        <br/>
        This integration will synchronize the information about servers, running software and other CIs. In HP EM you can connect CIs to application, data and business architecture. HP EM is also able to control
        the lifecycle of synchronized entities.
        <br/>
        HP EM is preconfigured to integrate
        <B>
            <a class="tip-link" href="http://www8.hp.com/us/en/software-solutions/software.html?compURI=1172882">HP Universal CMDB and HP Universal Discovery</a>
        </B>
        <br/>
        <br/>
        The following UD/UCMDB servers are integrated:
        <b><ul>
        <syswf:component prefix="cmdbs" name="/homepage/artifactList">
            <syswf:param name="type"  value="ucmdbRepository"/>
            <syswf:param name="favorites" value="${false}"/>
            <syswf:param name="maxItems" value="${10}"/>
            <syswf:param name="noResults">
                </b>There are no <b><syswf:control id="rep11" mode="anchor" caption="cmdb servers" targetTask="/admin/server/browse">
                <syswf:param name="domainId" value="topLevelDomain"/>
            </syswf:control></b>
                defined yet.<b>
            </syswf:param>
        </syswf:component>
        </ul></b>
        Other CMDB solutions may be supported as well. Please contact your HP sales representative to get more information.
    </syswf:param>
</syswf:component>

<syswf:component name="/homepage/tip" prefix="sparxTip">
    <syswf:param name="title">EA Modelling Tools Integration</syswf:param>
    <syswf:param name="id">tip.sparx</syswf:param>
    <syswf:param name="content">
        HP EM is ready to integrate external modelling tools. Diagrams and entities created by the modelling tool can be synchronized with enterprise architecture repository in HP EM.
        <br/>
        <br/>
        Data between the modelling tool and HP EM can be exchanged via:
        <br/>
        <br/>
        <b>1. On-line bi-directional integration</b> using a plugin (needs to be installed)
        <br/>
        <b>2. Off-line export/import</b> files (the file mapping needs to be configured)
        <br/>
        <br/>
        The on-line integration with a modelling tool requires one or more HP EM connector licenses (one connector license per each mapping configuration).
        Please contact HP sales representative to request extra connector license or get information about support of specific modelling tool.
        <br/>
        <br/>
        <br/>
        HP EM is preconfigured to support online integration with <b>Sparx Enterprise Architect</b>
        <br/>
        <br/>
        Steps to use this integration:
        <br/>
        <a class="tip-link" href="http://www.sparxsystems.com/hpem">1. Download and install Sparx EA trial</a> or use Sparx EA tool with commercial license
        <br/>
        <syswf:component prefix="download.sparx" name="/homepage/downloadLink">
            <syswf:param name="title">2. Download and install the HP EM Extension for Sparx EA</syswf:param>
            <syswf:param name="filePrefix">hp-em-sparx-</syswf:param>
            <syswf:param name="fileSuffix">.msi</syswf:param>
        </syswf:component>
        3. Configure Extension in Sparx EA
        <br/>
        <br/>
        Before you integrate Sparx EA, you need to
        <syswf:control mode="anchor" caption="review/add Sparx EA repository mapping configuration." targetTask="/admin/server/browse">
            <syswf:param name="domainId" value="topLevelDomain"/>
        </syswf:control>
        There are the following mappings already defined:
        <b>
        <ul>
        <syswf:component prefix="sparxList" name="/homepage/artifactList">
            <syswf:param name="type"  value="sparxEaRepository"/>
            <syswf:param name="favorites" value="${false}"/>
            <syswf:param name="maxItems" value="${10}"/>
            <syswf:param name="noResults">
                </b>There are no <b><syswf:control id="rep13" mode="anchor" caption="sparx mappings" targetTask="/admin/server/browse">
                <syswf:param name="domainId" value="topLevelDomain"/>
            </syswf:control></b>
                defined yet.<b>
            </syswf:param>
        </syswf:component>
        </ul>
        </b>
    </syswf:param>
</syswf:component>

<syswf:component name="/homepage/tip" prefix="ppmTip">
    <syswf:param name="title">PPM Integration</syswf:param>
    <syswf:param name="id">tip.ppm</syswf:param>
    <syswf:param name="content">
        HP EM supports integration with <a href="http://en.wikipedia.org/wiki/Project_portfolio_management">project and portfolio management</a> solutions to import proposal, project and financial information. You can analyze entities from PPM
        in the wider perspective of Business and IT.
        <br/>
        <br/>
        Out of the box HP EM is preconfigured to integrate with <B>
        <a class="tip-link" href="http://www8.hp.com/us/en/software-solutions/software.html?compURI=1171920">HP Project and Portfolio Management and HP Application Portfolio Management</a>
        module.</B>
        <br/>
        This system is integrated with the following HP PPM/APM servers:
        <br/>
        <br/>
        <b>
        <ul>
        <syswf:component prefix="ppm" name="/homepage/artifactList">
            <syswf:param name="type"  value="ppmRepository"/>
            <syswf:param name="favorites" value="${false}"/>
            <syswf:param name="maxItems" value="${10}"/>
            <syswf:param name="noResults">
                </b>There are no <b><syswf:control id="rep12" mode="anchor" caption="ppm servers" targetTask="/admin/server/browse">
                <syswf:param name="domainId" value="topLevelDomain"/>
            </syswf:control></b>
                defined yet.<b>
            </syswf:param>
        </syswf:component>
        </ul>
        </b>
        <br/>
        Other systems may be supported as well. Please contact HP sales representative to get more information.
    </syswf:param>
</syswf:component>

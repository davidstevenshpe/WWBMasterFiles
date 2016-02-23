<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>
            <span id="data-sources" class="eam-portfolio-box c-green-dark">
                <header>
                    <i class="icon-field icon-data-sources"></i>
                    <h2>Transformation</h2>
                    <span class="separator-top">
                    	<hr class="hr-c-datasource-top">
                        <hr class="hr-c-datasource-bottom">
                    </span>
                </header>
                <section>
               	  <span class="eam-box-content ">
                     <div class="c-green-in">
                         <ul class="separator-border-datasources">
                             <li>
                                 <h4 class="headerline">Implementation
                                     and Migration</h4>
                             </li>
                             <li>
                                 <h4>
                                     <syswf:control id="tr0" mode="anchor" caption="Roadmap" targetTask="/reports/dashboard">
                                         <syswf:param name="customizationId">reports.dashboard.task.dashboard.Roadmap</syswf:param>
                                     </syswf:control>
                                 </h4>
                             </li>
                             <li>
                                 <h4>
                                     <syswf:control id="tr1" mode="anchor" caption="Projects" targetTask="/common/browseArtifact">
                                         <syswf:param name="artifactType" value="projectArtifact"/>
                                     </syswf:control>
                                 </h4>
                             </li>
                             <li>
                                 <h4>
                                     <syswf:control id="tr2" mode="anchor" caption="Plateaus & To-Be" targetTask="/common/browseArtifact">
                                         <syswf:param name="artifactType" value="plateauArtifact"/>
                                     </syswf:control>
                                 </h4>
                             </li>
                             <li>
                                 <h4>
                                     <syswf:control id="tr3" mode="anchor" caption="Deliverables" targetTask="/common/browseArtifact">
                                         <syswf:param name="artifactType" value="deliverableArtifact"/>
                                     </syswf:control>
                                 </h4>
                             </li>
                         </ul>
                         <ul class="separator-border-datasources">
                             <li>
                                 <h4 class="headerline">Lifecycle</h4>
                             </li>
                             <li>
                                 <h4>
                                     <syswf:control id="tr5" mode="anchor" caption="My Tasks" targetTask="/common/usertask/taskBrowser"/>
                                 </h4>
                             </li>
                             <li>
                                 <h4>
                                     <c:if test="${accessGranted}">
                                         <syswf:control id="tr4" mode="anchor" caption="Processes" targetTask="/admin/lifecycle/process/processBrowser"/>
                                     </c:if>
                                 </h4>
                             </li>
                         </ul>
                         <ul class="separator-border-white">
                             <li>
                                 <h4 class="headerline">Analysis</h4>
                             </li>
                             <li>
                                 <h4>
                                     <syswf:control id="tr6" mode="anchor" caption="Impact and Dependencies" targetTask="/reports/homepage"/>
                                 </h4>
                             </li>
                             <li>
                                 <h4>
                                     <syswf:control id="tr9" mode="anchor" caption="Investments" targetTask="/reports/dashboard">
                                         <syswf:param name="customizationId">reports.dashboard.task.dashboard.Investments</syswf:param>
                                     </syswf:control>
                                 </h4>
                             </li>
                             <li>
                                 <h4>
                                     <syswf:control id="tr8" mode="anchor" caption="Navigator" targetTask="/navigator/homepage"/>
                                 </h4>
                             </li>
                             <li>
                                 <h4>
                                     <syswf:control id="tr85" mode="anchor" caption="Architecture Diagrams" targetTask="/common/browseArtifact">
                                         <syswf:param name="artifactType" value="diagramArtifact"/>
                                     </syswf:control>
                                 </h4>
                             </li>
                         </ul>
                     </div>
                         <ul class="separator-border-datasources">
                             <li>
                                 <h4 class="headerline">
                                     <syswf:control id="tr10" mode="anchor" caption="Favorite Projects" targetTask="/common/browseArtifact">
                                         <syswf:param name="artifactType" value="projectArtifact"/>
                                         <syswf:param name="selected" value="2"/>
                                     </syswf:control>
                                 </h4>
                             </li>
                             <syswf:component prefix="projects" name="/homepage/artifactList">
                                 <syswf:param name="type"  value="projectArtifact"/>
                                 <syswf:param name="favorites" value="${true}"/>
                                 <syswf:param name="maxItems" value="${12}"/>
                                 <syswf:param name="noResults">
                                     Here you will see all  <b><syswf:control id="tr11" mode="anchor" caption="projects" targetTask="/common/browseArtifact">
                                     <syswf:param name="artifactType" value="projectArtifact"/>
                                 </syswf:control></b>
                                     that you will mark as favorite in the catalog. There are no such projects now.
                                 </syswf:param>
                             </syswf:component>
                         </ul>
                	</span>
                </section>  
            </span> 

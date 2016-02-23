<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>
		<span id="governance" class="eam-portfolio-box c-red">
                <header>
                    <i class="icon-field icon-governance" title="Governance"></i>
                    <h2>Governance</h2>
                    <span class="separator-top">
                    	<hr class="hr-c-governance-top">
                        <hr class="hr-c-governance-bottom">
                    </span>
                </header>
                <section>
                	<span class="eam-box-content">
                      <div class="c-red-in">

                          <ul class="separator-border-governance">
                              <li>
                                  <h4 class="headerline">Motivation</h4>
                              </li>
                              <li>
                                  <h4>
                                      <syswf:control id="gov0" mode="anchor" caption="Drivers" targetTask="/common/browseArtifact">
                                          <syswf:param name="artifactType" value="driverArtifact"/>
                                      </syswf:control>
                                  </h4>
                              </li>
                              <li>
                                  <h4>
                                      <syswf:control id="gov1" mode="anchor" caption="Goals" targetTask="/common/browseArtifact">
                                          <syswf:param name="artifactType" value="goalArtifact"/>
                                      </syswf:control>
                                  </h4>
                              </li>
                              <li>
                                  <h4>
                                      <syswf:control id="gov2" mode="anchor" caption="Demands & Requirements" targetTask="/common/browseArtifact">
                                          <syswf:param name="artifactType" value="requirementArtifact"/>
                                      </syswf:control>
                                  </h4>
                              </li>
                          </ul>
                          <ul class="separator-border-white">
                              <li>
                                  <h4 class="headerline">Policy & Compliance</h4>
                              </li>
                              <li>
                                  <h4>
                                      <syswf:control id="gov5" mode="anchor" caption="Reports" targetTask="/reports/browseArtifact">
                                          <syswf:param name="artifactType" value="hpsoaPolicyReportArtifact"/>
                                      </syswf:control>
                                  </h4>
                              </li>
                              <li>
                                  <h4>
                                      <syswf:control id="gov3" mode="anchor" caption="Principles" targetTask="/common/browseArtifact">
                                          <syswf:param name="artifactType" value="principleArtifact"/>
                                      </syswf:control>
                                  </h4>
                              </li>
                              <li>
                                  <h4>
                                      <syswf:control id="gov4" mode="anchor" caption="Policies" targetTask="/admin/browseArtifact">
                                          <syswf:param name="artifactType" value="hpsoaTechnicalPolicyArtifact"/>
                                      </syswf:control>
                                  </h4>
                              </li>
                          </ul>
                      </div>
                        <ul>
                            <li>
                                <h4 class="headerline">
                                    <syswf:control id="gov6" mode="anchor" caption="Favorite Policy Reports" targetTask="/reports/browseArtifact">
                                        <syswf:param name="artifactType" value="hpsoaPolicyReportArtifact"/>
                                        <syswf:param name="selected" value="2"/>
                                    </syswf:control>
                                </h4>
                            </li>
                            <syswf:component prefix="projects" name="/homepage/artifactList">
                                <syswf:param name="type"  value="hpsoaPolicyReportArtifact"/>
                                <syswf:param name="favorites" value="${true}"/>
                                <syswf:param name="maxItems" value="${22}"/>
                                <syswf:param name="noResults">
                                    Here you will see all  <b><syswf:control id="gov7" mode="anchor" caption="policy reports" targetTask="/reports/browseArtifact">
                                    <syswf:param name="artifactType" value="hpsoaPolicyReportArtifact"/>
                                </syswf:control></b>
                                    that you will mark as favorite in the catalog. There are no such policy reports now.
                                </syswf:param>
                            </syswf:component>
                        </ul>
                	</span>
                </section>
            </span>   

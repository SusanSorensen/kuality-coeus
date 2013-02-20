class ProposalActions < ProposalDevelopmentDocument

  proposal_header_elements

  element(:turn_on_validation) { |b| b.frm.button(name: "methodToCall.activate"); b.td(class: "subhead", text: "Validation Errors").wait_until_present }

  action(:show_key_personnel_errors) { |b| b.frm.button(name: "methodToCall.toggleTab.tabKeyPersonnelInformationValidationErrors").click }
  action(:show_budget_versions_errors) { |b| b.frm.button(name: "methodToCall.toggleTab.tabBudgetVersionsValidationErrors").click }
  action(:show_proposal_questions_errors) { |b| b.frm.button(name: "methodToCall.toggleTab.tabAProposalQuestionsValidationErrors").click }
  action(:show_kuali_u_errors) { |b| b.frm.button(name: "methodToCall.toggleTab.tabCKualiUniversityValidationErrors").click }
  action(:show_questionnaire_errors) { |b| b.frm.button(name: "methodToCall.toggleTab.tabS2SFATFlatQuestionnaireValidationErrors").click }
  action(:show_compliance_errors) { |b| b.frm.button(name: "methodToCall.toggleTab.tabBComplianceValidationErrors").click }

  value(:warnings) { |b| b.frm.td(text: "Warnings").parent.parent.td(class: "datacell").text }
  value(:grants_gov_errors) { |b| b.frm.td(text: "Grants.Gov Errors").parent.parent.td(class: "datacell").text }
  value(:unit_business_rules_errors) { |b| b.frm.td(text: "Unit Business Rules Errors").parent.parent.td(class: "datacell").text }
  value(:unit_business_rules_warnings) { |b| b.frm.td(text: "Unit Business Rules Warnings").parent.parent.td(class: "datacell").text }

  element(:link_child_proposal) { |b| b.frm.text_field(id: "newHierarchyProposalNumber") }
  element(:link_budget_type) { |b| b.frm.select(id: "newHierarchyBudgetTypeCode") }
  action(:link_to_hierarchy) { |b| b.frm.button(name: "methodToCall.linkToHierarchy.anchorProposalHierarchy").click }

  element(:person_action_requested) { |b| b.frm.select(name: "newAdHocRoutePerson.actionRequested") }
  element(:person) { |b| b.frm.text_field(name: "newAdHocRoutePerson.id") }
  action(:add_person_request) { |b| b.frm.button(name: "methodToCall.insertAdHocRoutePerson").click }

  element(:group_action_requested) { |b| b.frm.select(name: "newAdHocRouteWorkgroup.actionRequested") }
  element(:namespace_code) { |b| b.frm.text_field(name: "newAdHocRouteWorkgroup.recipientNamespaceCode") }
  element(:name) { |b| b.frm.text_field(name: "newAdHocRouteWorkgroup.recipientName") }
  action(:add_group_request) { |b| b.frm.button(name: "methodToCall.insertAdHocRouteWorkgroup").click }

  action(:delete_proposal) { |b| b.frm.button(name: "methodToCall.deleteProposal").click }

  def validation_errors_and_warnings
    errs = []
      validation_err_war_fields.each { |field| errs << field.html[/(?<=>).*(?=<)/] }
    errs
  end

  private

  element(:validation_err_war_fields) { |b| b.frm.tds(width: "94%") }

end
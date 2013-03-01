class SpecialReview < ProposalDevelopmentDocument

  proposal_header_elements

  element(:error_messages_div) { |b| b.frm.div(id: 'tab-SpecialReview-div').div(class: 'left-errmsg-tab').div }

  # Method returns an array
  value(:error_messages) { |p| p.error_messages_div.divs.collect{|div| div.text} }

  element(:add_type) { |b| b.frm.select(id: 'specialReviewHelper.newSpecialReview.specialReviewTypeCode') }
  element(:add_approval_status) { |b| b.frm.select(id: 'specialReviewHelper.newSpecialReview.approvalTypeCode') }
  element(:add_protocol_number) { |b| b.frm.text_field(id: 'specialReviewHelper.newSpecialReview.protocolNumber') }
  element(:add_application_date) { |b| b.frm.text_field(id: 'specialReviewHelper.newSpecialReview.applicationDate') }
  element(:add_approval_date) { |b| b.frm.text_field(id: 'specialReviewHelper.newSpecialReview.approvalDate') }
  element(:add_expiration_date) { |b| b.frm.text_field(id: 'specialReviewHelper.newSpecialReview.expirationDate') }
  element(:add_exemption_number) { |b| b.frm.select(id: 'specialReviewHelper.newSpecialReview.exemptionTypeCodes') }

  action(:add) { |b| b.frm.button(name: 'methodToCall.addSpecialReview.anchorSpecialReview').click }

end
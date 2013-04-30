class BasePage < PageFactory

  action(:use_new_tab) { |b| b.windows.last.use }
  action(:return_to_portal) { |b| b.portal_window.use }
  action(:close_children) { |b| b.windows[1..-1].each{ |w| w.close} }
  action(:loading) { |b| b.frm.image(alt: 'working...').wait_while_present }
  button 'Logout'

  element(:portal_window) { |b| b.windows(title: 'Kuali Portal Index') }

  class << self

    def document_header_elements
      element(:headerinfo_table) { |b| b.frm.div(id: 'headerarea').table(class: 'headerinfo') }

      value(:document_id) { |p| p.headerinfo_table[0][1].text }
      alias_method :doc_nbr, :document_id
      value(:status) { |p| p.headerinfo_table[0][3].text }
      value(:initiator) { |p| p.headerinfo_table[1][1].text }
      value(:last_updated) {|p| p.headerinfo_table[1][3].text }
      alias_method :created, :last_updated
      value(:committee_id) { |p| p.headerinfo_table[2][1].text }
      alias_method :sponsor_name, :committee_id
      alias_method :budget_name, :committee_id
      value(:committee_name) { |p| p.headerinfo_table[2][3].text }
      alias_method :pi, :committee_name
    end

    def global_buttons
      action(:submit) { |b| b.frm.button(class: 'globalbuttons', title: 'submit').click; b.loading }
      action(:save) { |b| b.frm.button(class: 'globalbuttons', title: 'save').click; b.loading }
      action(:blanket_approve) { |b| b.frm.button(class: 'globalbuttons', title: 'blanket approve').click; b.loading }
      action(:close) { |b| b.frm.button(class: 'globalbuttons', title: 'close').click; b.loading }
      action(:cancel) { |b| b.frm.button(class: 'globalbuttons', title: 'cancel').click; b.loading }
      action(:reload) { |b| b.frm.button(class: 'globalbuttons', title: 'reload').click; b.loading }
      action(:delete_selected) { |b| b.frm.button(class: 'globalbuttons', name: 'methodToCall.deletePerson').click; b.loading }
    end

    def tab_buttons
      action(:expand_all) { |b| b.frm.button(name: 'methodToCall.showAllTabs').click }
    end

    def tiny_buttons
      action(:search) { |b| b.frm.button(title: 'search', value: 'search').click; b.loading }
      action(:clear) { |b| b.frm.button(name: 'methodToCall.clearValues').click; b.loading }
      action(:cancel) { |b| b.frm.link(title: 'cancel').click; b.loading }
    end

    def search_results_table
      element(:results_table) { |b| b.frm.table(id: 'row') }
      action(:return_value) { |match, p| p.results_table.row(text: /#{match}/).link(text: 'return value').click }
      action(:return_random) { |b| b.return_value_links[rand(b.return_value_links.length)].click }
      element(:return_value_links) { |b| b.results_table.links(text: 'return value') }
    end

    def budget_header_elements
      action(:return_to_proposal) { |b| b.frm.button(name: 'methodToCall.returnToProposal').click }
      action(:budget_versions) { |b| b.frm.button(value: 'Budget Version').click }
      action(:parameters) { |b| b.frm.button(value: 'Parameters').click }
      action(:rates) { |b| b.frm.button(value: 'Rates').click }
      action(:summary) { |b| b.frm.button(value: 'Summary').click }
      action(:Personnel) { |b| b.frm.button(value: 'Personnel').click }
      action(:non_personnel) { |b| b.frm.button(value: 'Non-Personnel').click }
      action(:distribution_and_income) { |b| b.frm.button(value: 'Distribution & Income').click }
      # Need the _tab suffix because of method collisions
      action(:modular_budget_tab) { |b| b.frm.button(value: 'Modular Budget').click }
      action(:budget_actions) { |b| b.frm.button(value: 'Budget Actions').click }
    end

    # Gathers all errors on the page and puts them in an array called "errors"
    def error_messages
      element(:errors) do |b|
        errs = []
        b.left_errmsg_tabs.each do |div|
          if div.div.div.exist?
            errs << div.div.divs.collect{ |div| div.text }
          elsif div.li.exist?
            errs << div.lis.collect{ |li| li.text }
          end
        end
        errs.flatten
      end
      element(:left_errmsg_tabs) { |b| b.frm.divs(class: 'left-errmsg-tab') }
    end

  end # self

end # BasePage

module Watir
  module Container
    # Included here because, in a sense, the frame element
    # is a part of the "base page"
    def frm
      case
        when frame(id: 'iframeportlet').exist?
          frame(id: 'iframeportlet')
        when frame(id: /easyXDM_default\d+_provider/).frame(id: 'iframeportlet').exist?
          frame(id: /easyXDM_default\d+_provider/).frame(id: 'iframeportlet')
        when frame(id: /easyXDM_default\d+_provider/).exist?
          frame(id: /easyXDM_default\d+_provider/)
        else
          self
      end
    end
  end

  # Because of the unique way we
  # set up radio buttons in Coeus,
  # we can use this method in our
  # radio button definitions.
  class Radio
    def fit answer
      set unless answer==nil
    end
  end
end
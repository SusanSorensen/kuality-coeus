class DocumentSearch < BasePage

  page_url "#{$base_url}channelTitle=Document Search&channelUrl=https://rdrive.kc.rsmart.com:/kc-dev/kew/DocumentSearch.do?"

  tiny_buttons
  search_results_table
  
  action(:open_doc) { |document_id, b| b.frm.link(text: document_id).click }

end
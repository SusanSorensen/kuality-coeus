class CommitteeDocumentObject

  include Foundry
  include DataFactory
  include StringFactory
  include Navigation

  attr_accessor :description, :committee_id, :document_id, :status, :committee_name,
                :home_unit, :min_members_for_quorum, :maximum_protocols,
                :adv_submission_days, :review_type, :last_updated, :updated_user,
                :initiator, :members, :areas_of_research, :type
  
  def initialize(browser, opts={})
    @browser = browser
    
    defaults = {
      description:            random_alphanums,
      committee_id:           random_alphanums,
      home_unit:              '000001',
      committee_name:         random_alphanums,
      min_members_for_quorum: rand(100).to_s,
      maximum_protocols:      rand(100).to_s,
      adv_submission_days:    rand(365).to_s,
      review_type:            'Full',
      members:                CommitteeMemberCollection.new,
      areas_of_research:      [],
      schedule:               CommitteeScheduleCollection.new
    }

    set_options(defaults.merge(opts))
  end
    
  def create
    visit(Research).central_admin
    on(CentralAdmin).add_irb_committee
    on Committee do |comm|
      @document_id=comm.document_id
      @initiator=comm.initiator
      @status=comm.status
      comm.description.set @description
      comm.committee_id.set @committee_id
      comm.committee_name.set @committee_name
      comm.type.pick! @type
      comm.home_unit.set @home_unit
      comm.min_members_for_quorum.set @min_members_for_quorum
      comm.maximum_protocols.set @maximum_protocols
      comm.adv_submission_days.set @adv_submission_days
      comm.review_type.pick! @review_type
      comm.save
    end
  end

  def submit
    navigate
    on(Committee).submit
  end

  # =======
  private
  # =======

  # Nav Aids...

  def navigate
    open_document unless on_document?
    on(Committee).committee unless on_page?
  end

  def on_page?
    # Note, the rescue clause should be
    # removed when the Selenium bug with
    # firefox elements gets fixed. This is
    # still broken in selenium-webdriver 2.29
    begin
      on(Committee).committee_id_field.exist?
    rescue
      false
    end
  end

end
    
      
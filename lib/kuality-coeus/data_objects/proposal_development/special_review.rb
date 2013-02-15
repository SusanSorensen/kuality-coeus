class SpecialReviewObject

  include Foundry
  include DataFactory
  include StringFactory
  include Navigation

  attr_accessor :type, :approval_status, :document_id

  def initialize(browser, opts={})
    @browser = browser

    defaults = {
      type: :random,
      approval_status: :random
    }

    set_options(defaults.merge(opts))
    requires @document_id
  end

  def create
    navigate
    on SpecialReview do |add|
      add.type.pick @type
      add.approval_status.pick @approval_status
      add.add
      add.save
    end
  end

  def edit opts={}

    set_options(opts)
  end

  def view

  end

  def delete

  end

  private

  def navigate
    open_document unless on_document?
    on(Proposal).special_review unless on_page?
  end

  def on_page?
    # Note, the rescue clause should be
    # removed when the Selenium bug with
    # firefox elements gets fixed. This is
    # still broken in selenium-webdriver 2.29
    begin
      on(SpecialReview).type.exist?
    rescue
      false
    end
  end

end

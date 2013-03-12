class BudgetPeriodObject

  include Foundry
  include DataFactory
  include StringFactory
  include Navigation

  attr_accessor :document_id, :budget_name, :number, :start_date, :end_date,
                :total_sponsor_cost, :direct_cost, :f_and_a_cost, :unrecovered_f_and_a,
                :cost_sharing, :cost_limit, :direct_cost_limit, :datified

  def initialize(browser, opts={})
    @browser = browser

    defaults = {
      total_sponsor_cost:  '0.00',
      direct_cost:         '0.00',
      f_and_a_cost:        '0.00',
      unrecovered_f_and_a: '0.00',
      cost_sharing:        '0.00',
      cost_limit:          '0.00',
      direct_cost_limit:   '0.00'
    }

    set_options(defaults.merge(opts))
    requires :document_id, :budget_name, :start_date
    datify
  end

  def create
    navigate
    on Parameters do |create|
      # TODO!
    end
  end

  def edit opts={}
    navigate
    on Parameters do |edit|
      # TODO!
    end
    set_options(opts)
    datify
  end

  def delete
    navigate
    on(Parameters).delete_period @number
  end

  # =======
  private
  # =======

  # Nav Aids

  def navigate
    open_document unless on_document?
    unless on_page? && on_budget?
      on(Proposal).budget_versions
      on(BudgetVersions).open @budget_name
    end
  end

  def on_page?
    # Note, the rescue clause should be
    # removed when the Selenium bug with
    # firefox elements gets fixed. This is
    # still broken in selenium-webdriver 2.29
    begin
      on(Parameters).on_off_campus.exist?
    rescue
      false
    end
  end

  def on_budget?
    # Note, the rescue clause should be
    # removed when the Selenium bug with
    # firefox elements gets fixed. This is
    # still broken in selenium-webdriver 2.29
    begin
      on(Parameters).budget_name==@budget_name
    rescue
      false
    end
  end

  # This takes the period start date and converts it into a Date object
  # which is then stored in @datified.
  #
  # It's important in the context of the Budget Periods Collection,
  # which uses it to determine the order of the Periods on the page.
  def datify
    @datified=Date.parse(@start_date[/(?<=\/)\d+$/] + '/' + @start_date[/^\d+\/\d+/])
  end

end # BudgetPeriodObject

class BudgetPeriodsCollection < Array

  def period(number)
    self.find { |period| period.number==number }
  end

  # This will update the number values of the budget periods,
  # based on their start date values.
  def re_sort!
    self.sort_by! { |period| period.datified }
    self.each_with_index { |period, index| period.store(:number, index+1) }
  end

  def total_sponsor_cost
    self.collect{ |period| period.total_sponsor_cost.to_f }.inject(0, :+)
  end

end # BudgetPeriodsCollection
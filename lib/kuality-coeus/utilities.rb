module Utilities

  def get(item)
    instance_variable_get(snakify(item))
  end

  def set(item, obj)
    instance_variable_set(snakify(item), obj)
  end

  def make_user(un)
    set(un, (make UserObject, user: un))
  end

  def make_role(role)
    set(role, (make UserObject, role: role))
  end

  def snake_case(string)
    StringFactory.damballa(string)
  end

  def random_dollar_value(max)
    "#{rand(max)}.#{rand(99)}".to_f
  end

  private

  def snakify(item)
    if item.to_s[0]=='@'
      item
    else
      "@#{snake_case(item.to_s)}"
    end
  end

end
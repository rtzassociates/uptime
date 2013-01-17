class Permission < Struct.new(:user)
  def allow?(controller, action)
    controller == "events" && action.in?(%w[index show])
  end
end
module TasksHelper
  def users_assigned_to(task)
    unless task.assigned_users.empty?
      users_list = task.assigned_users.collect { |u| link_to(u.username, u) }.to_sentence
      raw "Assigned to #{users_list}"
    end
  end
end

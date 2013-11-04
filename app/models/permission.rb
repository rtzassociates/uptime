class Permission
  
  def initialize(user)
    allow :sessions, [:new, :create, :destroy]
    allow :password_resets, [:new, :create, :edit, :update]
    allow :pages, [:home]
    if user
      allow :events, [:index, :show, :new, :create]
      allow :events, [:edit, :update] do |event|
        event.problem.user.id == user.id
      end
      allow :sites, [:index, :show]
      allow :comments, [:index, :show, :new, :create]
      allow :comments, [:edit, :update, :destroy] do |comment|
        comment.user.id == user.id
      end
      allow :resolutions, [:index, :show, :new, :create]
      allow :resolutions, [:edit, :update, :destroy] do |resolution|
        resolution.user.id == user.id
      end
      allow :users, [:index, :show]
      allow :users, [:edit, :update] do |the_user|
        the_user.id == user.id
      end
      allow :statuses, [:index, :show]
      allow :subscriptions, [:index, :show, :new, :create, :destroy]
      allow :servers, [:index, :show]
      allow :database_servers, [:index, :show]
      allow :application_servers, [:index, :show]
      allow :databases, [:index, :show]
      allow_all if user.admin?
    end
  end
  
  def allow_all
    @allow_all = true
  end
  
  def allow(controllers, actions, &block)
    @allowed_actions ||= {}
    Array(controllers).each do |controller|
      Array(actions).each do |action|
        @allowed_actions[[controller.to_s, action.to_s]] = block || true
      end
    end
  end
  
  def allow?(controller, action, resource = nil)
    allowed = @allow_all || @allowed_actions[[controller.to_s, action.to_s]]
    allowed && (allowed == true || resource && allowed.call(resource))
  end
    
end
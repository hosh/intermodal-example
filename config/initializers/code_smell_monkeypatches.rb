# TODO: Fix this by making this unnecessary
class Warden::SessionSerializer
  def store(user, scope)
  end

  def fetch(scope)
  end

  def stored?(scope)
    false
  end

  def delete(scope, user=nil)
  end
end

class ::ActionDispatch::Session::AbstractStore
  def get_session(*args)
  end

  def destroy_session(env, sid, options) 
  end
end

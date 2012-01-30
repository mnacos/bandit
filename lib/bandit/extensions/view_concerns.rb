require 'active_support/concern'

module Bandit
  module ViewConcerns
    extend ActiveSupport::Concern
  
    module ClassMethods
      
    end

    module InstanceMethods
      def bandit_choose(exp)
        name = "bandit_#{exp}".intern

        # choose url param with preference
        value = params[name].nil? ? cookies.signed[name] : params[name]

        # choose with default, and set cookie
        cookies.signed[name] = Bandit.get_experiment(exp).choose(value)
      end

      def bandit_sticky_choose(exp)
        name = "bandit_#{exp}".intern

        # choose url param with preference
        value = params[name].nil? ? cookies.signed[name] : params[name]

        # sticky choice may outlast a given alternative
        alternative = if Bandit.get_experiment(exp).alternatives.include?(value)
                        value
                      else
                        Bandit.get_experiment(exp).choose(value)
                      end

        # re-set cookie
        cookies.permanent.signed[name] = alternative
      end
    end
  end
end

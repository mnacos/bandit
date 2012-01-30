require 'active_support/concern'

module Bandit
  module ControllerConcerns
    extend ActiveSupport::Concern
  
    module ClassMethods
      
    end

    module InstanceMethods
      def bandit_convert!(exp, alt=nil, count=1)
        cookiename = "bandit_#{exp}".intern
        alt ||= cookies.signed[cookiename]
        unless alt.nil?
          Bandit.get_experiment(exp).convert!(alt, count)
          cookies.delete(cookiename)
        end
      end

      def bandit_final_convert!(exp, alt=nil, count=1)
        cookiename = "bandit_#{exp}".intern
        cookiename_converted = "bandit_#{exp}_converted".intern
        alt ||= cookies.signed[cookiename]
        unless alt.nil? or cookies.signed[cookiename_converted]
          cookies.permanent.signed[cookiename_converted] = "true"
          Bandit.get_experiment(exp).convert!(alt, count)
        end
      end
    end

  end
end

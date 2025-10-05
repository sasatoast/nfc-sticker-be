module Callable
  extend ActiveSupport::Concern
  #concernで切り出すか、applicationService作ってまとめるかは要検討
  class_methods do
    def call(*args, **kwargs, &block)
      new(*args, **kwargs, &block).call
    end
  end
end

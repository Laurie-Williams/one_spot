module Owned
  class CreateCase
    def self.call(properties:{}, listener:, model:Case)
      self.new(properties, listener, model).execute
    end

    def execute
      kase = @model.i_new(@properties)
      if kase.i_save
        @listener.create_success
      else
        @listener.create_failure(kase)
      end
    end

    private

    def initialize(properties, listener, model)
      @properties = properties
      @listener = listener
      @model = model
    end
  end
end

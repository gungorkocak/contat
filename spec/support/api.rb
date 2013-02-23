module ContAT
  module ApiMacros
    extend ActiveSupport::Concern

    included do
      def page_is_valid_as_json(page)
        expect { parse_json(page) }.not_to raise_error(MultiJson::LoadError)
      end
    end
  end
end

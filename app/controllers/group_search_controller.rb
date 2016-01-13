class GroupSearchController < ApplicationController
  def self.search(q) do
    # These fields are special
    page = q.delete(:page) || 1
    per_page = q.delete(:per_page) || 50

    # Sanitize the rest of the fields
    q = sanitize_fields(q)

    # Perform the search
    s = Group.search do
      paginate page: page, per_page: per_page
      all_of do
        q.each { |k,v| with(k, v) }
      end
    end

    # This is explained further down in the tutorial
    SunspotSearchDecorator.new(s)
  end

  private

  # Given a hash of fields to search, only accept the ones that User indexes.
  # Also accepts `page` and `per_page`.
  def self.sanitize_fields(q)
    whitelisted_fields = Sunspot::Setup.for(Group).fields.map(&:name)
    whitelisted_fields.push(:page, :per_page)
    q.slice(*whitelisted_fields).with_indifferent_access
  end
end

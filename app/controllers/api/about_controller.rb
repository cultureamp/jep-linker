class Api::AboutController < ApplicationController
  def basic
    link_count = Link.count
    render json: {siteName: "linker", linksCreated: link_count}
  end
end

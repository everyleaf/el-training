class LabelsController < ApplicationController
  before_action :logged_in_user

  def index
    @labels = current_user.labels
  end
end

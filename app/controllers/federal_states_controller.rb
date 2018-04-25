class FederalStatesController < ApplicationController
  def index
    @federal_states = FederalState.all
  end
end

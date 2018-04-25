class CatalogueHarvesterWorker
  include Sidekiq::Worker

  def perform(cityportal)
    if true
      cityportal.harvest_whole_portal
    else
      cityportal.harvest_recently_updated
    end
  end
end

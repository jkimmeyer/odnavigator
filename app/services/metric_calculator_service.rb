class MetricCalculatorService
  def self.call(city_portal)
    new.call(city_portal)
  end

  def call(city_portal)
    calc_all_metrics(city_portal)
    get_category_count(city_portal)
  end

private
  def calc_all_metrics(city_portal)
    @city_portal = city_portal
    @data_portal = DataPortal.find(@city_portal.data_portal_id)

    # Berechnung des Medians
    sum_of_datasets = @city_portal.metric_datasets_sum
    if sum_of_datasets > sum_median
      sum_performance = 100.00
    else
      sum_performance = sum_of_datasets.to_f / sum_median.to_f * 100
    end

    openness = @city_portal.metric_openness.round(2)
    access = @city_portal.metric_non_properitary.round(2)
    data_format = @city_portal.metric_machine_readable.round(2)
    completeness = @city_portal.metric_completeness.round(2)

    # Zusammenrechnung der Metriken - asap Gewichtung reinbringen.
    total = ((openness + access + data_format + completeness + sum_performance).to_f / 5).round(2)

    @data_portal.update(openness_quality: openness,
                        sum_of_datasets:  sum_of_datasets,
                        access_quality:   access,
                        format_quality:   data_format,
                        completeness_quality: completeness,
                        quality: total
                       )
  end

  # Mappt die Kategorie Werte zusammen.
  def get_category_count(city_portal)
    @city_portal = city_portal
    @data_portal = DataPortal.find(@city_portal.data_portal_id)

    categories = @city_portal.count_categories
    @data_portal.update(category_counts: categories)
  end

  # Berechnung des Medians.
  def sum_median
    median(CityPortal.all.map {|f| f.metric_datasets_sum})
  end

  def median(array)
    sorted = array.sort
    len = sorted.length
    (sorted[(len - 1) / 2] + sorted[len / 2]) / 2.0
  end
end

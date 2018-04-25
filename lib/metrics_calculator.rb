module Calculator
  module Metrics
# Dataportal Quantity Metrics
    def sum_of_datasets(dataportal)
      return dataportal.datasets.count
    end

    def total_quality(dataportal)
      dataportal.datasets.each do |f|
        total_quality += f.quality
      end
      return total_quality/sum_of_datasets
    end


# Dataportal Quality Metrics
    def format_quality(dataportal)
    end

    def openess_quality(dataportal)
    end

    def completeness_quality(dataportal)
    end

    def access_quality(dataportal)
    end
  end
end

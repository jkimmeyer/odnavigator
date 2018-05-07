class DataResource < ApplicationRecord

  include OdmFormats

  validates_uniqueness_of :unique_identifier
  has_one :dataset

  def machine_readable
    return get_machine_readable.include?(self.data_format.downcase)
  end

  def non_proprietary
    return get_non_proprietary.include?(self.data_format.downcase)
  end
end

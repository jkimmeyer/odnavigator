module CategoryMatcher
  # needs the group hash of a Dataset
  def get_groups_of_dataset(group)
    hash = Hash.new

    # Word Arrays to match the depending category. Key is used to be displayed and to be saved to dataset.
    hash["agri"] = %w[landwirtschaft fischerei forstwirtschaft nahrungsmittel agri agriculture]
    hash["envi"] = %w[envi umwelt environment klima]
    hash["heal"] = %w[health gesundheit heal]
    hash["soci"] = %w[bevoelkerung gesellschaft soci sociality bevölkerung soziales]
    hash["educ"] = %w[bildung kultur education educ]
    hash["ener"] = %w[energie ener]
    hash["just"] = %w[justiz rechtssystem sicherheit recht just justice]
    hash["tran"] = %w[verkehr transport tran transportation infrastruktur]
    hash["econ"] = %w[wirtschaft finanzen econ economy]
    hash["tech"] = %w[wissenschaft technologie tech]
    hash["regi"] = %w[regi regierung verwaltung politik wahlen stadt]
    hash["geo"]  = %w[geo map geographie karte ]

    #Iterate through every hash for the group of a dataset
    hash.each do |key, values|
      # Turns the group hash into a string with words(downcase) like this: "name title description display_name" so its easier to match with the words that fit.
      if values.any? {|value| group.values_at("name", "title", "description", "display_name").join(" ").downcase.include? value}
        # Returns key, if any value includes a word of the group. Can return multiple values.
        return key
      end
    end
  end
end

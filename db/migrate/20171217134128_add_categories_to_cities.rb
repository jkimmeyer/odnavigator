class AddCategoriesToCities < ActiveRecord::Migration[5.1]
  def change
    add_column :cities, :bevoelkerung, :integer
    add_column :cities, :bildung_wissenschaft, :integer
    add_column :cities, :geo, :integer
    add_column :cities, :gesetze_justiz, :integer
    add_column :cities, :gesundheit, :integer
    add_column :cities, :infrastruktur_bauen_wohnen, :integer
    add_column :cities, :kultur_freizeit_sport_tourismus, :integer
    add_column :cities, :politik_wahlen, :integer
    add_column :cities, :transport_verkehr, :integer
    add_column :cities, :soziales, :integer
    add_column :cities, :umwelt_klima, :integer
    add_column :cities, :verbraucher, :integer
    add_column :cities, :verwaltung, :integer
    add_column :cities, :wirtschaft_arbeit, :integer
  end
end

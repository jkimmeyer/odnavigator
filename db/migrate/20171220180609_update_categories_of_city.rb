class UpdateCategoriesOfCity < ActiveRecord::Migration[5.1]
  def change
    rename_column :cities, :gesetze_justiz, :just
    rename_column :cities, :gesundheit, :heal
    rename_column :cities, :politik_wahlen, :gove
    rename_column :cities, :transport_verkehr, :tran
    rename_column :cities, :soziales, :soci
    rename_column :cities, :umwelt_klima, :envi
    rename_column :cities, :verbraucher, :tech
    rename_column :cities, :wirtschaft_arbeit, :econ
    rename_column :cities, :bildung_wissenschaft, :educ
    remove_column :cities, :verwaltung
    remove_column :cities, :infrastruktur_bauen_wohnen
    remove_column :cities, :kultur_freizeit_sport_tourismus
    remove_column :cities, :geo
  end
end

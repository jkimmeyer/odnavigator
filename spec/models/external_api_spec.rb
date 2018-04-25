require 'rails_helper'
# What to test in the Model Spec for Data Api:
# All methods and validations

RSpec.describe DataPortal do

  describe 'database actions' do
    context 'with valid attributes' do
      let!(:api) { build :data_portal }
      it 'instantiates a new DataPortal' do
        expect(api).to be_valid
      end

      it 'gets ckan version' do
        pending "expect(api.version).to eq 'CKAN3'"
        fail
      end

    end
    context 'with invalid attributes' do
      let!(:invalid_api) { build :data_portal, url: nil }
      it 'does not instantiates a new DataPortal' do
        expect(invalid_api).not_to be_valid
      end
    end
  end

  describe '#get' do
    context 'while api is online' do
      #do api request
      it 'returns a result to given params' do
        #check if successful request was made
      end

      it 'does not send request if params not suitable' do
        #check if no request made because params not suitable
      end

    end

    context 'while api is offline' do
      #make api unavaiable
      it 'returns failure message instead of sending request' do
        # do api get_request
        # check for failure message
      end

    end

  end

  describe '#set' do
    let!(:api) { create :data_portal}
    it 'writes a new data api to the database' do
      #saves new entry to database
      expect(DataPortal.count).to eq 1
      expect(DataPortal.first.url).to eq api.url
    end

    it 'updates a data api in the database' do
      #updates entry in the database
    end

  end
end

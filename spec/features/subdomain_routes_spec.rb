require 'rails_helper'

feature "SubdomainRoutes" do
  describe "with subdomain 'test'" do
    let(:subdomain) { 'test' }

    describe "Account Routes" do
      it 'can route to accounts#new'
      it 'can route to accounts#create'
      it 'can route to accounts#show'
    end

    describe "Case Routes" do
      it 'can route to cases#new'
      it 'can route to cases#create'
      it 'can route to cases#index'
    end
  end

  describe "with no subdomain" do

    describe "Account Routes" do
      it 'can route to accounts#new' do
      it 'can route to accounts#create'
      it 'cannot route to accounts#show'
    end

    describe "Case Routes" do
      it 'cannot route to cases#new'
      it 'cannot route to cases#create'
      it 'cannot route to cases#index'
    end
  end

  describe "with subdomain 'www'" do
    let(:subdomain) { 'www' }

    describe "Account Routes" do
      it 'can route to accounts#new'
      it 'can route to accounts#create'
      it 'cannot route to accounts#show'
    end

    describe "Case Routes" do
      it 'cannot route to cases#new'
      it 'cannot route to cases#create'
      it 'cannot route to cases#index'
    end
  end
end

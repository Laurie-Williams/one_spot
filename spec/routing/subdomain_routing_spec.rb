require_relative '../rails_helper'

describe "project routing" do
  describe "with subdomain 'test'" do
    let(:url) { "http://test.lvh.me" }

    describe "Account Routes" do

      it 'can route to accounts#new' do
        expect(:get => "#{url}/accounts/new").to be_routable
      end

      it 'can route to accounts#create' do
        expect(:post => "#{url}/accounts").to be_routable
      end

      it 'can route to accounts#show' do
        expect(:get => "#{url}/accounts/1").to be_routable
      end
    end

    describe "Case Routes" do

      it 'can route to cases#new' do
        expect(:get => "#{url}/cases/new").to be_routable
      end

      it 'can route to cases#create' do
        expect(:post => "#{url}/cases").to be_routable
      end

      it 'can route to cases#index' do
        expect(:get => "#{url}/cases").to be_routable
      end
    end
  end

  describe "with no subdomain" do
    let(:url) { "http://lvh.me" }

    describe "Account Routes" do

      it 'can route to accounts#new' do
        expect(:get => "#{url}/accounts/new").to be_routable
      end

      it 'can route to accounts#create' do
        expect(:post => "#{url}/accounts").to be_routable
      end

      it 'cannot route to accounts#show' do
        expect(:get => "#{url}/accounts/1").not_to be_routable
      end
    end

    describe "Case Routes" do

      it 'cannot route to cases#new' do
        expect(:get => "#{url}/cases/new").not_to be_routable
      end

      it 'cannot route to cases#create' do
        expect(:post => "#{url}/cases").not_to be_routable
      end

      it 'cannot route to cases#index' do
        expect(:get => "#{url}/cases").not_to be_routable
      end
    end
  end

  describe "with subdomain 'www'" do
    let(:url) { 'http://www.lvh.me' }

    describe "Account Routes" do

      it 'can route to accounts#new' do
        expect(:get => "#{url}/accounts/new").to be_routable
      end

      it 'can route to accounts#create' do
        expect(:post => "#{url}/accounts").to be_routable
      end

      it 'cannot route to accounts#show' do
        expect(:get => "#{url}/accounts/1").not_to be_routable
      end
    end

    describe "Case Routes" do

      it 'cannot route to cases#new' do
        expect(:get => "#{url}/cases/new").not_to be_routable
      end

      it 'cannot route to cases#create' do
        expect(:post => "#{url}/cases").not_to be_routable
      end

      it 'cannot route to cases#index' do
        expect(:get => "#{url}/cases").not_to be_routable
      end
    end
  end
end

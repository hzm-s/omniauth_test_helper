require 'spec_helper'

RSpec.describe 'mock_auth_hash' do
  before do
    OmniAuthTestHelper.default_options = {
      provider: :twitter
    }
    RSpec.configure do |c|
      c.include OmniAuthTestHelper
    end
  end

  it do
    auth_hash =
      mock_auth_hash(
        provider: 'google_oauth2',
        uid: 'uid123',
        name: 'Resource Owner'
      )

    aggregate_failures do
      expect(auth_hash['provider']).to eq('google_oauth2')
      expect(auth_hash['uid']).to eq('uid123')
      expect(auth_hash['info']['name']).to eq('Resource Owner')
    end
  end

  it do
    auth_hash =
      mock_auth_hash(
        provider: :google_oauth2,
        uid: :uid123,
        name: :Resource_Owner
      )

    aggregate_failures do
      expect(auth_hash['provider']).to eq('google_oauth2')
      expect(auth_hash['uid']).to eq('uid123')
      expect(auth_hash['info']['name']).to eq('Resource_Owner')
    end
  end

  it do
    auth_hash =
      mock_auth_hash(
        provider: 'google_oauth2',
        name: 'Resource Owner'
      )
    uid = auth_hash['uid']

    aggregate_failures do
      expect(uid).to_not be_nil
      expect(uid).to be_instance_of(String)
      expect(uid.size).to be > 1
    end
  end

  it do
    OmniAuthTestHelper.default_options = {
      provider: :facebook
    }
    auth_hash =
      mock_auth_hash(
        name: 'Resource Owner'
      )
    provider = auth_hash['provider']

    expect(provider).to eq('facebook')
  end

  it do
    auth_hash =
      mock_auth_hash(
        name: 'Resource Owner',
        email: 'resource.owner@gmail.com',
        nickname: 'R.O',
        first_name: 'Resource',
        last_name: 'Owner',
        location: 'Japan',
        description: 'A Smart Guy',
        image: 'http://the.users.image/size/50x50.jpg',
        phone: '0123456789',
        urls: {
          Blog: 'http://the.blog/user'
        }
      )

    aggregate_failures do
      expect(auth_hash['info']['email']).to eq('resource.owner@gmail.com')
      expect(auth_hash['info']['nickname']).to eq('R.O')
      expect(auth_hash['info']['first_name']).to eq('Resource')
      expect(auth_hash['info']['last_name']).to eq('Owner')
      expect(auth_hash['info']['location']).to eq('Japan')
      expect(auth_hash['info']['description']).to eq('A Smart Guy')
      expect(auth_hash['info']['image']).to eq('http://the.users.image/size/50x50.jpg')
      expect(auth_hash['info']['phone']).to eq('0123456789')
      expect(auth_hash['info']['urls']['Blog']).to eq('http://the.blog/user')
    end
  end
end

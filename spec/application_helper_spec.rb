require 'rails_helper'
require_relative '../app/helpers/application_helper'

describe 'Class String' do
  it 'checks if it is a string to be converted into an integer' do
    expect('1'.is_i?).to eq(true)
    expect('+1'.is_i?).to eq(true)
    expect('-1'.is_i?).to eq(true)
    expect('11'.is_i?).to eq(true)
    expect('+11'.is_i?).to eq(true)
    expect('-11'.is_i?).to eq(true)
    expect('0'.is_i?).to eq(true)
    expect('+0'.is_i?).to eq(true)
    expect('-0'.is_i?).to eq(true)

    expect(''.is_i?).to eq(false)
    expect('++11'.is_i?).to eq(false)
    expect('+-11'.is_i?).to eq(false)
    expect('--11'.is_i?).to eq(false)
    expect('1+1'.is_i?).to eq(false)
    expect('1++1'.is_i?).to eq(false)
    expect('11+'.is_i?).to eq(false)
    expect('++0'.is_i?).to eq(false)
    expect('0+'.is_i?).to eq(false)

    expect('a11'.is_i?).to eq(false)
    expect('@11'.is_i?).to eq(false)
    expect('1a1'.is_i?).to eq(false)
    expect('abc'.is_i?).to eq(false)
  end
end

class DummyClass_ApplicationHelper
  include ApplicationHelper
end

describe 'text_abstract' do
  it 'shortens a long sentence to less than 80 characters' do
    dc = DummyClass_ApplicationHelper.new
    expect(dc.text_abstract('')).to eq('')
    expect(dc.text_abstract('assignment')).to eq('assignment')
    expect(dc.text_abstract('You are not reading this directly on GitHub.')).to eq('You are not reading this directly on GitHub.')
    expect(dc.text_abstract('Understand where to modify a Rails app to implement the various parts of a new feature, since a new feature touches.')).to eq('Understand where to modify a Rails app to implement the various parts of a new feature,...')
  end
end

describe 'validate_aptmt_params' do
  it 'does validate_aptmt_params' do
    dc = DummyClass_ApplicationHelper.new
    permitted = { :name => 'Apartment 1', :address => '3811 Meadowcrest Lane', :price => '1200' }
    expect(dc.validate_aptmt_params(permitted)).to eq(true)

    permitted = { :name => 'Apartment 1', :address => '3811 Meadowcrest Lane', :price => '+1200' }
    expect(dc.validate_aptmt_params(permitted)).to eq(true)

    permitted = { :name => 'Apartment 1', :address => '3811 Meadowcrest Lane', :price => '++1200' }
    expect(dc.validate_aptmt_params(permitted)).to eq(false)

    permitted = { :name => 'Apartment 1', :address => '3811 Meadowcrest Lane', :price => '--1200' }
    expect(dc.validate_aptmt_params(permitted)).to eq(false)

    permitted = { :name => 'Apartment 1', :address => '3811 Meadowcrest Lane', :price => '-1200' }
    expect(dc.validate_aptmt_params(permitted)).to eq(false)

    permitted = { :name => 'Apartment 1', :address => '3811 Meadowcrest Lane', :price => 'price' }
    expect(dc.validate_aptmt_params(permitted)).to eq(false)

    permitted = { :name => '', :address => '3811 Meadowcrest Lane', :price => '1200' }
    expect(dc.validate_aptmt_params(permitted)).to eq(false)

    permitted = { :name => 'Apartment 1', :address => '', :price => '1200' }
    expect(dc.validate_aptmt_params(permitted)).to eq(false)

    permitted = { :name => 'Apartment 1', :address => '3811 Meadowcrest Lane', :price => '' }
    expect(dc.validate_aptmt_params(permitted)).to eq(false)
  end

  describe 'validate_comment_params' do
    it 'does validate_comment_params' do
      dc = DummyClass_ApplicationHelper.new
      permitted = { :rating => 'rating', :comment => 'dummy' * 50 }
      expect(dc.validate_comment_params(permitted)).to eq(false)

      permitted = { :rating => '200', :comment => 'dummy' * 50 }
      expect(dc.validate_comment_params(permitted)).to eq(false)

      permitted = { :rating => '50', :comment => 'dummy' }
      expect(dc.validate_comment_params(permitted)).to eq(false)

      permitted = { :rating => '50', :comment => 'dummy' * 50 }
      expect(dc.validate_comment_params(permitted)).to eq(true)
    end
  end
end

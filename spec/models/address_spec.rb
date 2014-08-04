require 'spec_helper'

describe Address do
  it { should belong_to(:hotel) }
  it { should validate_presence_of(:country) }
end
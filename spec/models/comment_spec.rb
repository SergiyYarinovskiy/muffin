require 'spec_helper'

describe Comment do
  it { should belong_to(:hotel) }
  it { should validate_presence_of(:body) }
  it { should validate_presence_of(:rating) }
end
require 'spec_helper'

describe DatabaseServer do
  it { should respond_to(:database_ids) }
  it { should have_many(:databases) }
end

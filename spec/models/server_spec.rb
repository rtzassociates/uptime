require 'spec_helper'

describe Server do
  it { should respond_to(:name) }
  it { should respond_to(:deployed_at_text) }
  it { should respond_to(:description) }
  it { should respond_to(:name) }
  it { should respond_to(:ip_addresses) }
  it { should respond_to(:server_type_id) }
  it { should respond_to(:server_location_id) }
  it { should respond_to(:server_role_id) }
  it { should respond_to(:public_ip_address) }

  it { should belong_to(:server_role) }
  it { should belong_to(:server_type) }
  it { should belong_to(:server_location) }


end

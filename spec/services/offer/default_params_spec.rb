require 'rails_helper'

describe Offer::DefaultParams do
  let(:default_params) { Offer::DefaultParams.new }

  it { expect(default_params.appid).to eq('111')  }
  it { expect(default_params.device_id).to eq('222')  }
  it { expect(default_params.locale).to eq('en')  }
  it { expect(default_params.ip).to eq('1.1.1.1')  }
  it { expect(default_params.offer_types).to eq('333')  }
end
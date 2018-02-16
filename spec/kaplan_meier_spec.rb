require 'kaplan_meier'

RSpec.describe KaplanMeier::Survival do
  let(:km) {KaplanMeier::Survival.new}

  it "has a version number" do
    expect(KaplanMeier::VERSION).not_to be nil
  end

  describe 'basic set of data in a clean order' do
    before do
      km.add_time(46, 1, 1)
      km.add_time(64, 0, 1)
      km.add_time(78)
      km.add_time(124)
      km.add_time(130, 0, 1)
      km.add_time(150, 0, 2)
      puts km.probabilities
    end

    it "last probability is correct" do
      expect(km.probabilities[-1][:probability]).to eq(0.525)
    end

    it "does something useful" do
      expect(km.time_periods).to eq([46, 64, 78, 124, 130, 150])
    end
  end
  describe 'basic set of data out of order' do
    before do
      km.add_time(64, 0, 1)
      km.add_time(78)
      km.add_time(150, 0, 2)
      km.add_time(46, 1, 1)
      km.add_time(124)
      km.add_time(130, 0, 1)
      puts km.probabilities
    end

    it "last probability is correct" do
      expect(km.probabilities[-1][:probability]).to eq(0.525)
    end

    it "does something useful" do
      expect(km.time_periods).to eq([46, 64, 78, 124, 130, 150])
    end
  end
end

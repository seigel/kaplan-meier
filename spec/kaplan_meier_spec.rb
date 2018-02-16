require 'kaplan_meier'

RSpec.describe KaplanMeier::Survival do


  it "has a version number" do
    expect(KaplanMeier::VERSION).not_to be nil
  end

  describe 'calculating values' do
    let(:km) {KaplanMeier::Survival.new}

    before do
      km.add(46, 1, 1)
      km.add(64, 0, 1)
      km.add(78)
      km.add(124)
      km.add(130, 0, 1)
      km.add(150, 0, 2)
    end


    describe 'basic set of data in a clean order' do
      it "last probability is correct" do
        expect(km.probabilities[-1][:probability]).to eq(0.525)
      end

      it "has the proper time periods in the right order" do
        expect(km.time_periods).to eq([46, 64, 78, 124, 130, 150])
      end

      it "has the right probabilities" do
        expect(km.values_for_range(start_time: 48, end_time: 100)[0]).to eq(0.875)
        expect(km.values_for_range(start_time: 48, end_time: 134)[-1]).to eq(0.525)
        expect(km.values_for_range(start_time: 48, end_time: 100).length).to eq(53)
      end

      it "has the right range" do
        expect(km.range(start_time: 48, end_time: 100)[0]).to eq(48)
        expect(km.range(start_time: 48, end_time: 100)[-1]).to eq(100)
        expect(km.range(start_time: 48, end_time: 100).uniq.length).to eq(53)
      end
    end

    describe 'basic set of data out of order' do
      let(:km_wacky) {KaplanMeier::Survival.new}

      before do
        km_wacky.add(64, 0, 1)
        km_wacky.add(78)
        km_wacky.add(150, 0, 1)
        km_wacky.add(46, 1, 1)
        km_wacky.add(150, 0, 1)
        km_wacky.add(124)
        km_wacky.add(130, 0, 1)
      end

      it 'has the same range as in order' do
        expect(km_wacky.range).to eq(km.range)
      end

      it 'has the same probabilities as in order calculations' do
        expect(km_wacky.probabilities).to eq(km.probabilities)
      end

      it 'has the same time periods as in order calculations' do
        expect(km_wacky.time_periods).to eq(km.time_periods)
      end

      it "last probability is correct" do
        expect(km_wacky.probabilities[-1][:probability]).to eq(0.525)
      end

      it "has the proper time periods in the right order" do
        expect(km_wacky.time_periods).to eq([46, 64, 78, 124, 130, 150])
      end
    end
  end
end

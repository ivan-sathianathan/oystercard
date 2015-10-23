require 'oystercard'

describe Oystercard do

  let(:station) { double :station }
  let(:journey) { double :journey }

  it "checks that default balance is zero" do
    subject.balance()
    expect(subject.balance).to eq Oystercard::DEFAULT_BALANCE
  end

  context "#top_up" do
    it "allows for balance to be topped up" do
      2.times { subject.top_up(10) }
      expect(subject.balance).to eq 20
    end
    it "raises error when balance limit reached" do
      subject.top_up(Oystercard::LIMIT)
      expect{subject.top_up(1)}.to raise_error("Unable to top up beyond the limit of £#{Oystercard::LIMIT}")
    end
  end

  context "#touch_in" do
    before(:each) do
      allow(station).to receive(:zone).and_return("zone")
      allow(station).to receive(:location).and_return("location")
    end
    it "raises error with insufficient funds" do
      expect{subject.touch_in(station)}.to raise_error "Unable to touch in: insufficient balance"
    end
    # it "is in_journey" do
    #   expect(subject.in_journey?).to eq true
    # end
    it 'deducts penalty fare when failed to touch out' do
      subject.top_up 10
      subject.touch_in(station)
      expect {subject.touch_in station}.to change {subject.balance}.by(-Oystercard::MAXIMUM_FARE)
    end
  end

  context "#touch_out" do
    let(:station2) {double(:station)}

    before(:each) do
      subject.top_up(20)
      subject.touch_in(station)
    end

    # it "returns not in journey" do
    #   subject.touch_out(station)
    #   expect(subject.in_journey?).to eq false
    # end
    it 'deducts fare on touching out' do
      expect {subject.touch_out station }.to change {subject.balance}.by(-Oystercard::MINIMUM_FARE)
    end
    it 'deducts maximum fare when failed to touch in' do
      subject.touch_out(station)
      expect{subject.touch_out(station2)}.to change{subject.balance}.by(-Oystercard::MAXIMUM_FARE)
    end
  end

  context '#history' do
    let(:journey) { double(:journey, touch_in: :entry_station, touch_out: :exit_station)}

    it 'when journey complete' do
      subject.top_up 20
      subject.touch_in :entry_station
      subject.touch_out :exit_station
      expect(subject.history).to eq({entry_station: :exit_station})
    end
    it 'when fail to touch out' do

    end
    it 'when fail to touch in' do

    end
  end
end

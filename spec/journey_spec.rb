require 'journey'

describe Journey do
 subject { Journey.new station }
 let(:station) { double(:station, :zone => 2, :location => "Peckham") }
 let(:station1) { double(:station, :zone => 1, :location => "Victoria") }


  context "#entry + #exit" do
    it "should set complete to true" do
       subject.exit_station(station1)
       expect(subject.complete?).to eq true
    end
    it "should return minimum fare" do
       subject.exit_station(station1)
       expect(subject.fare).to eq Journey::MINIMUM_FARE
    end
  end

  # context "#entry + #entry" do
  #   it "should set complete to true" do
  #     subject.entry_station(station1)
  #     expect(subject.complete?).to eq true
  #   end
  #   it "should return maximum fare" do
  #     subject.entry_station(station1)
  #     expect(subject.fare).to eq Journey::MAXIMUM_FARE
  #   end
  # end

  context "#exit" do
    it "should set complete to true" do
      subject.exit_station(station)
      expect(subject.complete?).to eq true
    end
    # it "should return maximum fare" do
    #   subject.exit_station(station)
    #   expect(subject.fare).to eq Journey::MAXIMUM_FARE
    # end
  end

  context "#log"
    # # it "records a journey to the log for a normal complete journey" do
    # #   subject.touch_in(station)
    # #   subject.touch_out(station1)
    # #   subject.log
    # #   expect(subject.log.last).to eq {station => station1}
    # # end
    it "records a journey to the log with fail to touch in but touch out" do

    end
    it "records a journey to the log with fail to touch in twice"
end

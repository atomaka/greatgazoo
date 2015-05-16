require 'spec_helper'

Default = Struct.new(:sequence, :time)
Adjusted = Struct.new(:sequence, :start)

describe GreatGazoo do
  it 'can be constructed' do
    warp = GreatGazoo::TimeWarp.new
  end

  describe 'when no values are passed' do
    let(:gg) { GreatGazoo::TimeWarp.new() }
    it 'can bend' do
      gg.bend(Array.new)
    end

    it 'can bend a sequence' do
      sequence = Array.new
      my_time = Time.new(2014, 1, 1, 12, 0, 0)
      sequence << Default.new(1, my_time)

      expect(gg.bend(sequence).first.time).to_not eq(my_time)
    end

    it 'does not bend when it should not' do
      sequence = Array.new
      my_time = Time.new(2014, 1, 1, 6, 0, 0)
      sequence << Default.new(1, my_time)

      expect(gg.bend(sequence).first.time).to eq(my_time)
    end
  end

  describe 'when values are passed' do
    describe 'with non-default time method' do
      let(:gg) { GreatGazoo::TimeWarp.new({time_method: :start}) }

      it 'can bend a sequence' do
        sequence = Array.new
        my_time = Time.new(2014, 1, 1, 12, 0, 0)
        sequence << Adjusted.new(1, my_time)

        expect(gg.bend(sequence).first.start).to_not eq(my_time)
      end
    end

    describe 'with non-default start time' do
      let(:gg) { GreatGazoo::TimeWarp.new({start_time: '16:00'}) }

      it 'can bend a sequence' do
        sequence = Array.new
        my_time = Time.new(2014, 1, 1, 16, 30, 0)
        sequence << Default.new(1, my_time)

        expect(gg.bend(sequence).first.time).to_not eq(my_time)
      end

      it 'does not bend a sequence when it should not' do
        sequence = Array.new
        my_time = Time.new(2014, 1, 1, 15, 30, 0)
        sequence << Default.new(1, my_time)

        expect(gg.bend(sequence).first.time).to eq(my_time)
      end
    end

    describe 'with non-default end time' do
      let(:gg) { GreatGazoo::TimeWarp.new({end_time: '10:00'}) }

      it 'can bend a sequence' do
        sequence = Array.new
        my_time = Time.new(2014, 1, 1, 9, 30, 0)
        sequence << Default.new(1, my_time)

        expect(gg.bend(sequence).first.time).to_not eq(my_time)
      end

      it 'does not bend a sequence when it should not' do
        sequence = Array.new
        my_time = Time.new(2014, 1, 1, 10, 30, 0)
        sequence << Default.new(1, my_time)

        expect(gg.bend(sequence).first.time).to eq(my_time)
      end
    end
  end
end
